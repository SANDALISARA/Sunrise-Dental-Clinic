package sunrise.dental.service.dao;

import sunrise.dental.service.dto.PatientDTO;
import sunrise.dental.service.util.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import java.util.ArrayList;
import java.util.List;

public class PatientDAO {


    // =========================================================
    // GET ALL PATIENTS
    // =========================================================
    public List<PatientDTO> findAll()
            throws Exception {

        String sql =
                "SELECT * FROM patients ORDER BY id DESC";

        List<PatientDTO> patients =
                new ArrayList<>();


        try (
                Connection c = DB.get();

                PreparedStatement ps =
                        c.prepareStatement(sql);

                ResultSet rs =
                        ps.executeQuery()
        ) {

            while (rs.next()) {

                patients.add(
                        map(rs)
                );
            }
        }

        return patients;
    }


    // =========================================================
    // GET PATIENT BY ID
    // =========================================================
    public PatientDTO findById(int id)
            throws Exception {

        String sql =
                "SELECT * FROM patients WHERE id = ?";


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
    // CREATE PATIENT
    // =========================================================
    public PatientDTO create(
            PatientDTO patient)
            throws Exception {

        String sql = """
                INSERT INTO patients
                (
                    patient_number,
                    patient_name,
                    date_of_birth,
                    gender,
                    phone,
                    email,
                    address,
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


            // ---------------------------------------------
            // AUTO GENERATE PATIENT NUMBER
            // ---------------------------------------------
            if (patient.patientNumber == null
                    || patient.patientNumber.isBlank()) {

                patient.patientNumber =
                        "PAT-" + System.currentTimeMillis();
            }


            ps.setString(
                    1,
                    patient.patientNumber
            );


            ps.setString(
                    2,
                    patient.patientName
            );


            ps.setString(
                    3,
                    patient.dateOfBirth
            );


            ps.setString(
                    4,
                    patient.gender
            );


            ps.setString(
                    5,
                    patient.phone
            );


            ps.setString(
                    6,
                    patient.email
            );


            ps.setString(
                    7,
                    patient.address
            );


            ps.setString(
                    8,
                    patient.medicalHistory
            );


            ps.executeUpdate();


            try (
                    ResultSet rs =
                            ps.getGeneratedKeys()
            ) {

                if (rs.next()) {

                    patient.id =
                            rs.getInt(1);
                }
            }


            System.out.println(
                    "Patient created successfully"
            );


            return patient;
        }
    }


    // =========================================================
    // UPDATE PATIENT
    // =========================================================
    public boolean update(
            int id,
            PatientDTO patient)
            throws Exception {

        String sql = """
                UPDATE patients
                SET
                    patient_name = ?,
                    date_of_birth = ?,
                    gender = ?,
                    phone = ?,
                    email = ?,
                    address = ?,
                    medical_history = ?
                WHERE id = ?
                """;


        try (
                Connection c = DB.get();

                PreparedStatement ps =
                        c.prepareStatement(sql)
        ) {


            ps.setString(
                    1,
                    patient.patientName
            );


            ps.setString(
                    2,
                    patient.dateOfBirth
            );


            ps.setString(
                    3,
                    patient.gender
            );


            ps.setString(
                    4,
                    patient.phone
            );


            ps.setString(
                    5,
                    patient.email
            );


            ps.setString(
                    6,
                    patient.address
            );


            ps.setString(
                    7,
                    patient.medicalHistory
            );


            ps.setInt(
                    8,
                    id
            );


            int rows =
                    ps.executeUpdate();


            System.out.println(
                    "Patient rows updated: "
                            + rows
            );


            return rows == 1;
        }
    }


    // =========================================================
    // DELETE PATIENT
    // =========================================================
    public boolean delete(int id)
            throws Exception {

        String sql =
                "DELETE FROM patients WHERE id = ?";


        try (
                Connection c = DB.get();

                PreparedStatement ps =
                        c.prepareStatement(sql)
        ) {

            ps.setInt(
                    1,
                    id
            );


            int rows =
                    ps.executeUpdate();


            System.out.println(
                    "Patient rows deleted: "
                            + rows
            );


            return rows == 1;
        }
    }


    // =========================================================
    // RESULTSET -> DTO
    // =========================================================
    private PatientDTO map(
            ResultSet rs)
            throws Exception {

        PatientDTO patient =
                new PatientDTO();


        patient.id =
                rs.getInt(
                        "id"
                );


        patient.patientNumber =
                rs.getString(
                        "patient_number"
                );


        patient.patientName =
                rs.getString(
                        "patient_name"
                );


        patient.dateOfBirth =
                rs.getString(
                        "date_of_birth"
                );


        patient.gender =
                rs.getString(
                        "gender"
                );


        patient.phone =
                rs.getString(
                        "phone"
                );


        patient.email =
                rs.getString(
                        "email"
                );


        patient.address =
                rs.getString(
                        "address"
                );


        patient.medicalHistory =
                rs.getString(
                        "medical_history"
                );


        return patient;
    }
}