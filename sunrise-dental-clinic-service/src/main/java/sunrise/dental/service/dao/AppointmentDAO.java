package sunrise.dental.service.dao;

import sunrise.dental.service.dto.AppointmentDTO;
import sunrise.dental.service.util.DB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO {

    public List<AppointmentDTO> findAll()
            throws Exception {

        String sql = """
                SELECT *
                FROM appointments
                ORDER BY appointment_date DESC,
                         appointment_time DESC
                """;

        try (
                Connection c = DB.get();
                PreparedStatement ps =
                        c.prepareStatement(sql);
                ResultSet rs =
                        ps.executeQuery()
        ) {

            List<AppointmentDTO> list =
                    new ArrayList<>();

            while (rs.next()) {
                list.add(map(rs));
            }

            return list;
        }
    }

    public AppointmentDTO findById(int id)
            throws Exception {

        String sql =
                "SELECT * FROM appointments WHERE id=?";

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

                return null;
            }
        }
    }

    public AppointmentDTO create(
            AppointmentDTO d)
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

            if (d.appointmentNumber == null
                    || d.appointmentNumber.isBlank()) {

                d.appointmentNumber =
                        generateAppointmentNumber();
            }

            ps.setString(
                    1,
                    d.appointmentNumber
            );

            ps.setInt(
                    2,
                    d.patientId
            );

            ps.setInt(
                    3,
                    d.dentistId
            );

            ps.setString(
                    4,
                    d.appointmentDate
            );

            ps.setString(
                    5,
                    d.appointmentTime
            );

            ps.setString(
                    6,
                    d.reason
            );

            if (d.status == null
                    || d.status.isBlank()) {

                d.status = "Scheduled";
            }

            ps.setString(
                    7,
                    d.status
            );

            ps.executeUpdate();

            try (ResultSet rs =
                         ps.getGeneratedKeys()) {

                if (rs.next()) {
                    d.id = rs.getInt(1);
                }
            }

            return d;
        }
    }

    public boolean update(
            int id,
            AppointmentDTO d)
            throws Exception {

        String sql = """
                UPDATE appointments
                SET patient_id=?,
                    dentist_id=?,
                    appointment_date=?,
                    appointment_time=?,
                    reason=?,
                    status=?
                WHERE id=?
                """;

        try (
                Connection c = DB.get();
                PreparedStatement ps =
                        c.prepareStatement(sql)
        ) {

            ps.setInt(
                    1,
                    d.patientId
            );

            ps.setInt(
                    2,
                    d.dentistId
            );

            ps.setString(
                    3,
                    d.appointmentDate
            );

            ps.setString(
                    4,
                    d.appointmentTime
            );

            ps.setString(
                    5,
                    d.reason
            );

            ps.setString(
                    6,
                    d.status
            );

            ps.setInt(
                    7,
                    id
            );

            return ps.executeUpdate() == 1;
        }
    }

    public boolean cancel(int id)
            throws Exception {

        String sql = """
                UPDATE appointments
                SET status='Cancelled'
                WHERE id=?
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

    public boolean delete(int id)
            throws Exception {

        try (
                Connection c = DB.get();
                PreparedStatement ps =
                        c.prepareStatement(
                                "DELETE FROM appointments WHERE id=?"
                        )
        ) {

            ps.setInt(1, id);

            return ps.executeUpdate() == 1;
        }
    }

    private String generateAppointmentNumber() {

        return "APT-" +
                System.currentTimeMillis();
    }

    private AppointmentDTO map(
            ResultSet rs)
            throws Exception {

        AppointmentDTO d =
                new AppointmentDTO();

        d.id =
                rs.getInt("id");

        d.appointmentNumber =
                rs.getString(
                        "appointment_number"
                );

        d.patientId =
                rs.getInt("patient_id");

        d.dentistId =
                rs.getInt("dentist_id");

        d.appointmentDate =
                rs.getString(
                        "appointment_date"
                );

        d.appointmentTime =
                rs.getString(
                        "appointment_time"
                );

        d.reason =
                rs.getString("reason");

        d.status =
                rs.getString("status");

        return d;
    }
}