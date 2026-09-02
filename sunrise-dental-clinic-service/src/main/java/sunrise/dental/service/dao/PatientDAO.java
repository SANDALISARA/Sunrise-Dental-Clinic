package sunrise.dental.service.dao;

import sunrise.dental.service.dto.PatientDTO;
import sunrise.dental.service.util.DB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PatientDAO {

    public List<PatientDTO> findAll() throws Exception {

        String sql =
                "SELECT * FROM patients ORDER BY id DESC";

        try (
                Connection c = DB.get();
                PreparedStatement ps = c.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            List<PatientDTO> patients =
                    new ArrayList<>();

            while (rs.next()) {
                patients.add(map(rs));
            }

            return patients;
        }
    }

    public PatientDTO findById(int id) throws Exception {

        String sql =
                "SELECT * FROM patients WHERE id=?";

        try (
                Connection c = DB.get();
                PreparedStatement ps = c.prepareStatement(sql)
        ) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return map(rs);
                }

                return null;
            }
        }
    }

    public PatientDTO create(PatientDTO d)
            throws Exception {

        String sql = """
                INSERT INTO patients
                (
                    patient_number,
                    patient_name,
                    date_of_birth,
                    gender,
                    address,
                    phone,
                    email,
                    medical_history
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
                """;

        try (
                Connection c = DB.get();
                PreparedStatement ps =
                        c.prepareStatement(
                                sql,
                                Statement.RETURN_GENERATED_KEYS
                        )
        ) {

            ps.setString(1, d.patientNumber);
            ps.setString(2, d.patientName);
            ps.setString(3, d.dateOfBirth);
            ps.setString(4, d.gender);
            ps.setString(5, d.address);
            ps.setString(6, d.phone);
            ps.setString(7, d.email);
            ps.setString(8, d.medicalHistory);

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
            PatientDTO d)
            throws Exception {

        String sql = """
                UPDATE patients
                SET patient_number=?,
                    patient_name=?,
                    date_of_birth=?,
                    gender=?,
                    address=?,
                    phone=?,
                    email=?,
                    medical_history=?
                WHERE id=?
                """;

        try (
                Connection c = DB.get();
                PreparedStatement ps =
                        c.prepareStatement(sql)
        ) {

            ps.setString(1, d.patientNumber);
            ps.setString(2, d.patientName);
            ps.setString(3, d.dateOfBirth);
            ps.setString(4, d.gender);
            ps.setString(5, d.address);
            ps.setString(6, d.phone);
            ps.setString(7, d.email);
            ps.setString(8, d.medicalHistory);
            ps.setInt(9, id);

            return ps.executeUpdate() == 1;
        }
    }

    public boolean delete(int id)
            throws Exception {

        String sql =
                "DELETE FROM patients WHERE id=?";

        try (
                Connection c = DB.get();
                PreparedStatement ps =
                        c.prepareStatement(sql)
        ) {

            ps.setInt(1, id);

            return ps.executeUpdate() == 1;
        }
    }

    private PatientDTO map(ResultSet rs)
            throws Exception {

        PatientDTO d = new PatientDTO();

        d.id = rs.getInt("id");

        d.patientNumber =
                rs.getString("patient_number");

        d.patientName =
                rs.getString("patient_name");

        d.dateOfBirth =
                rs.getString("date_of_birth");

        d.gender =
                rs.getString("gender");

        d.address =
                rs.getString("address");

        d.phone =
                rs.getString("phone");

        d.email =
                rs.getString("email");

        d.medicalHistory =
                rs.getString("medical_history");

        return d;
    }
}