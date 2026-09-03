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

    // GET ALL APPOINTMENTS
    public List<AppointmentDTO> findAll()
            throws Exception {

        String sql = """
                SELECT *
                FROM appointments
                ORDER BY appointment_date DESC,
                         appointment_time DESC
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
                appointments.add(map(rs));
            }
        }

        return appointments;
    }


    // GET ONE APPOINTMENT
    public AppointmentDTO findById(int id)
            throws Exception {

        String sql =
                "SELECT * FROM appointments WHERE id = ?";

        try (
                Connection c = DB.get();
                PreparedStatement ps =
                        c.prepareStatement(sql)
        ) {

            ps.setInt(1, id);

            try (ResultSet rs =
                         ps.executeQuery()) {

                if (rs.next()) {
                    return map(rs);
                }
            }
        }

        return null;
    }


    // CREATE APPOINTMENT
    public AppointmentDTO create(
            AppointmentDTO appointment)
            throws Exception {

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

            if (appointment.appointmentNumber == null
                    || appointment.appointmentNumber.isBlank()) {

                appointment.appointmentNumber =
                        "APT-" + System.currentTimeMillis();
            }

            if (appointment.status == null
                    || appointment.status.isBlank()) {

                appointment.status = "Scheduled";
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

            int rows =
                    ps.executeUpdate();

            System.out.println(
                    "Appointment rows inserted: "
                            + rows
            );

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
                    "Appointment created successfully"
            );

            System.out.println(
                    "Appointment ID: "
                            + appointment.id
            );

            System.out.println(
                    "Appointment Number: "
                            + appointment.appointmentNumber
            );

            return appointment;
        }
    }


    // UPDATE APPOINTMENT
    public boolean update(
            int id,
            AppointmentDTO appointment)
            throws Exception {

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


    // CANCEL APPOINTMENT
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

            ps.setInt(1, id);

            return ps.executeUpdate() == 1;
        }
    }


    // DELETE APPOINTMENT
    public boolean delete(int id)
            throws Exception {

        String sql =
                "DELETE FROM appointments WHERE id = ?";

        try (
                Connection c = DB.get();
                PreparedStatement ps =
                        c.prepareStatement(sql)
        ) {

            ps.setInt(1, id);

            return ps.executeUpdate() == 1;
        }
    }


    private AppointmentDTO map(ResultSet rs)
            throws Exception {

        AppointmentDTO a =
                new AppointmentDTO();

        a.id =
                rs.getInt("id");

        a.appointmentNumber =
                rs.getString(
                        "appointment_number"
                );

        a.patientId =
                rs.getInt(
                        "patient_id"
                );

        a.dentistId =
                rs.getInt(
                        "dentist_id"
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