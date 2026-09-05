package sunrise.dental.service.dao;

import sunrise.dental.service.dto.AppointmentDTO;
import sunrise.dental.service.util.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO {


    // =========================================================
    // GET ALL APPOINTMENTS
    // INCLUDING PATIENT + DENTIST NAMES
    // =========================================================
    public List<AppointmentDTO> findAll()
            throws Exception {

        String sql = """
                SELECT
                    a.id,
                    a.appointment_number,
                    a.patient_id,
                    p.patient_name,
                    a.dentist_id,
                    d.dentist_name,
                    a.appointment_date,
                    a.appointment_time,
                    a.reason,
                    a.status
                FROM appointments a
                LEFT JOIN patients p
                    ON a.patient_id = p.id
                LEFT JOIN dentists d
                    ON a.dentist_id = d.id
                ORDER BY
                    a.appointment_date DESC,
                    a.appointment_time ASC
                """;


        List<AppointmentDTO> appointments =
                new ArrayList<>();


        try (
                Connection c = DB.get();

                PreparedStatement ps =
                        c.prepareStatement(sql);

                ResultSet rs =
                        ps.executeQuery()
        ) {

            while (rs.next()) {

                appointments.add(
                        map(rs)
                );
            }
        }


        return appointments;
    }


    // =========================================================
    // GET APPOINTMENT BY ID
    // =========================================================
    public AppointmentDTO findById(int id)
            throws Exception {

        String sql = """
                SELECT
                    a.id,
                    a.appointment_number,
                    a.patient_id,
                    p.patient_name,
                    a.dentist_id,
                    d.dentist_name,
                    a.appointment_date,
                    a.appointment_time,
                    a.reason,
                    a.status
                FROM appointments a
                LEFT JOIN patients p
                    ON a.patient_id = p.id
                LEFT JOIN dentists d
                    ON a.dentist_id = d.id
                WHERE a.id = ?
                """;


        try (
                Connection c = DB.get();

                PreparedStatement ps =
                        c.prepareStatement(sql)
        ) {

            ps.setInt(
                    1,
                    id
            );


            try (
                    ResultSet rs =
                            ps.executeQuery()
            ) {

                if (rs.next()) {

                    return map(rs);
                }
            }
        }


        return null;
    }


    // =========================================================
    // CHECK DENTIST SLOT
    // =========================================================
    public boolean isSlotAvailable(
            int dentistId,
            String appointmentDate,
            String appointmentTime,
            int excludeAppointmentId)
            throws Exception {

        String sql = """
                SELECT COUNT(*)
                FROM appointments
                WHERE dentist_id = ?
                AND appointment_date = ?
                AND appointment_time = ?
                AND status <> 'Cancelled'
                AND id <> ?
                """;


        try (
                Connection c = DB.get();

                PreparedStatement ps =
                        c.prepareStatement(sql)
        ) {

            ps.setInt(
                    1,
                    dentistId
            );

            ps.setString(
                    2,
                    appointmentDate
            );

            ps.setString(
                    3,
                    appointmentTime
            );

            ps.setInt(
                    4,
                    excludeAppointmentId
            );


            try (
                    ResultSet rs =
                            ps.executeQuery()
            ) {

                if (rs.next()) {

                    return rs.getInt(1) == 0;
                }
            }
        }


        return false;
    }


    // =========================================================
    // CREATE APPOINTMENT
    // =========================================================
    public AppointmentDTO create(
            AppointmentDTO appointment)
            throws Exception {


        // -----------------------------------------------------
        // CHECK DENTIST AVAILABILITY
        // -----------------------------------------------------
        boolean available =
                isSlotAvailable(
                        appointment.dentistId,
                        appointment.appointmentDate,
                        appointment.appointmentTime,
                        0
                );


        if (!available) {

            throw new IllegalStateException(
                    "Selected dentist is already booked "
                    + "for this date and time."
            );
        }


        String sql = """
                INSERT INTO appointments
                (
                    appointment_number,
                    patient_id,
                    dentist_id,
                    appointment_date,
                    appointment_time,
                    reason,
                    status
                )
                VALUES (?, ?, ?, ?, ?, ?, ?)
                """;


        try (
                Connection c = DB.get();

                PreparedStatement ps =
                        c.prepareStatement(
                                sql,
                                Statement.RETURN_GENERATED_KEYS
                        )
        ) {


            // -------------------------------------------------
            // AUTO APPOINTMENT NUMBER
            // -------------------------------------------------
            if (appointment.appointmentNumber == null
                    || appointment.appointmentNumber.isBlank()) {

                appointment.appointmentNumber =
                        "APT-" + System.currentTimeMillis();
            }


            if (appointment.status == null
                    || appointment.status.isBlank()) {

                appointment.status =
                        "Scheduled";
            }


            ps.setString(
                    1,
                    appointment.appointmentNumber
            );


            ps.setInt(
                    2,
                    appointment.patientId
            );


            ps.setInt(
                    3,
                    appointment.dentistId
            );


            ps.setString(
                    4,
                    appointment.appointmentDate
            );


            ps.setString(
                    5,
                    appointment.appointmentTime
            );


            ps.setString(
                    6,
                    appointment.reason
            );


            ps.setString(
                    7,
                    appointment.status
            );


            ps.executeUpdate();


            try (
                    ResultSet rs =
                            ps.getGeneratedKeys()
            ) {

                if (rs.next()) {

                    appointment.id =
                            rs.getInt(1);
                }
            }


            System.out.println(
                    "Appointment created: "
                            + appointment.appointmentNumber
            );


            return appointment;
        }
    }


    // =========================================================
    // UPDATE APPOINTMENT
    // =========================================================
    public boolean update(
            int id,
            AppointmentDTO appointment)
            throws Exception {


        // -----------------------------------------------------
        // CHECK SLOT EXCLUDING THIS APPOINTMENT
        // -----------------------------------------------------
        boolean available =
                isSlotAvailable(
                        appointment.dentistId,
                        appointment.appointmentDate,
                        appointment.appointmentTime,
                        id
                );


        if (!available) {

            throw new IllegalStateException(
                    "Selected dentist is already booked "
                    + "for this date and time."
            );
        }


        String sql = """
                UPDATE appointments
                SET
                    patient_id = ?,
                    dentist_id = ?,
                    appointment_date = ?,
                    appointment_time = ?,
                    reason = ?,
                    status = ?
                WHERE id = ?
                """;


        try (
                Connection c = DB.get();

                PreparedStatement ps =
                        c.prepareStatement(sql)
        ) {


            ps.setInt(
                    1,
                    appointment.patientId
            );


            ps.setInt(
                    2,
                    appointment.dentistId
            );


            ps.setString(
                    3,
                    appointment.appointmentDate
            );


            ps.setString(
                    4,
                    appointment.appointmentTime
            );


            ps.setString(
                    5,
                    appointment.reason
            );


            ps.setString(
                    6,
                    appointment.status
            );


            ps.setInt(
                    7,
                    id
            );


            return ps.executeUpdate() == 1;
        }
    }

    // =========================================================
// COMPLETE APPOINTMENT
// =========================================================
public boolean complete(int id)
        throws Exception {

    String sql = """
            UPDATE appointments
            SET status = 'Completed'
            WHERE id = ?
            AND status <> 'Cancelled'
            """;

    try (
            Connection c = DB.get();
            PreparedStatement ps =
                    c.prepareStatement(sql)
    ) {

        ps.setInt(1, id);

        return ps.executeUpdate() == 1;
    }
}
    

    // =========================================================
    // CANCEL APPOINTMENT
    // =========================================================
    public boolean cancel(int id)
            throws Exception {

        String sql = """
                UPDATE appointments
                SET status = 'Cancelled'
                WHERE id = ?
                """;


        try (
                Connection c = DB.get();

                PreparedStatement ps =
                        c.prepareStatement(sql)
        ) {

            ps.setInt(
                    1,
                    id
            );


            return ps.executeUpdate() == 1;
        }
    }


    // =========================================================
    // MAP RESULTSET
    // =========================================================
    private AppointmentDTO map(
            ResultSet rs)
            throws Exception {


        AppointmentDTO a =
                new AppointmentDTO();


        a.id =
                rs.getInt(
                        "id"
                );


        a.appointmentNumber =
                rs.getString(
                        "appointment_number"
                );


        a.patientId =
                rs.getInt(
                        "patient_id"
                );


        a.patientName =
                rs.getString(
                        "patient_name"
                );


        a.dentistId =
                rs.getInt(
                        "dentist_id"
                );


        a.dentistName =
                rs.getString(
                        "dentist_name"
                );


        a.appointmentDate =
                rs.getString(
                        "appointment_date"
                );


        a.appointmentTime =
                rs.getString(
                        "appointment_time"
                );


        a.reason =
                rs.getString(
                        "reason"
                );


        a.status =
                rs.getString(
                        "status"
                );


        return a;
    }
}