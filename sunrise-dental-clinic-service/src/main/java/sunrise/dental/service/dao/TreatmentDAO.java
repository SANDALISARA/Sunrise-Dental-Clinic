package sunrise.dental.service.dao;

import sunrise.dental.service.dto.TreatmentDTO;
import sunrise.dental.service.util.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import java.util.ArrayList;
import java.util.List;

public class TreatmentDAO {


    // =========================================================
    // GET ALL TREATMENTS
    // =========================================================
    public List<TreatmentDTO> findAll()
            throws Exception {

        String sql =
                "SELECT * FROM treatments ORDER BY id DESC";

        List<TreatmentDTO> treatments =
                new ArrayList<>();

        try (
                Connection c = DB.get();

                PreparedStatement ps =
                        c.prepareStatement(sql);

                ResultSet rs =
                        ps.executeQuery()
        ) {

            while (rs.next()) {

                treatments.add(
                        map(rs)
                );
            }
        }

        return treatments;
    }


    // =========================================================
    // GET TREATMENT BY ID
    // =========================================================
    public TreatmentDTO findById(int id)
            throws Exception {

        String sql =
                "SELECT * FROM treatments WHERE id = ?";

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
    // CREATE / ADD TREATMENT
    // =========================================================
    public TreatmentDTO create(
            TreatmentDTO treatment)
            throws Exception {

        String sql = """
                INSERT INTO treatments
                (
                    treatment_code,
                    treatment_name,
                    description,
                    price
                )
                VALUES (?, ?, ?, ?)
                """;

        try (
                Connection c = DB.get();

                PreparedStatement ps =
                        c.prepareStatement(
                                sql,
                                Statement.RETURN_GENERATED_KEYS
                        )
        ) {

            // Generate treatment code automatically
            if (treatment.treatmentCode == null
                    || treatment.treatmentCode.isBlank()) {

                treatment.treatmentCode =
                        "TRT-" + System.currentTimeMillis();
            }


            ps.setString(
                    1,
                    treatment.treatmentCode
            );


            ps.setString(
                    2,
                    treatment.treatmentName
            );


            ps.setString(
                    3,
                    treatment.description
            );


            ps.setDouble(
                    4,
                    treatment.price
            );


            int rows =
                    ps.executeUpdate();


            System.out.println(
                    "Treatment rows inserted: "
                            + rows
            );


            try (
                    ResultSet rs =
                            ps.getGeneratedKeys()
            ) {

                if (rs.next()) {

                    treatment.id =
                            rs.getInt(1);
                }
            }


            System.out.println(
                    "Treatment added successfully"
            );


            System.out.println(
                    "Treatment ID: "
                            + treatment.id
            );


            System.out.println(
                    "Treatment Code: "
                            + treatment.treatmentCode
            );


            System.out.println(
                    "Treatment Name: "
                            + treatment.treatmentName
            );


            System.out.println(
                    "Treatment Price: "
                            + treatment.price
            );


            return treatment;
        }
    }


    // =========================================================
    // UPDATE TREATMENT
    // =========================================================
    public boolean update(
            int id,
            TreatmentDTO treatment)
            throws Exception {

        String sql = """
                UPDATE treatments
                SET
                    treatment_code = ?,
                    treatment_name = ?,
                    description = ?,
                    price = ?
                WHERE id = ?
                """;

        try (
                Connection c = DB.get();

                PreparedStatement ps =
                        c.prepareStatement(sql)
        ) {

            ps.setString(
                    1,
                    treatment.treatmentCode
            );


            ps.setString(
                    2,
                    treatment.treatmentName
            );


            ps.setString(
                    3,
                    treatment.description
            );


            ps.setDouble(
                    4,
                    treatment.price
            );


            ps.setInt(
                    5,
                    id
            );


            return ps.executeUpdate() == 1;
        }
    }


    // =========================================================
    // DELETE TREATMENT
    // =========================================================
    public boolean delete(int id)
            throws Exception {

        String sql =
                "DELETE FROM treatments WHERE id = ?";

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
    // DATABASE RESULT -> DTO
    // =========================================================
    private TreatmentDTO map(
            ResultSet rs)
            throws Exception {

        TreatmentDTO treatment =
                new TreatmentDTO();


        treatment.id =
                rs.getInt(
                        "id"
                );


        treatment.treatmentCode =
                rs.getString(
                        "treatment_code"
                );


        treatment.treatmentName =
                rs.getString(
                        "treatment_name"
                );


        treatment.description =
                rs.getString(
                        "description"
                );


        treatment.price =
                rs.getDouble(
                        "price"
                );


        return treatment;
    }
}