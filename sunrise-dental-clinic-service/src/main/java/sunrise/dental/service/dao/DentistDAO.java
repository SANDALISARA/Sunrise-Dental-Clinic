package sunrise.dental.service.dao;

import sunrise.dental.service.dto.DentistDTO;
import sunrise.dental.service.util.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import java.util.ArrayList;
import java.util.List;

public class DentistDAO {


    // =========================================================
    // GET ALL DENTISTS
    // =========================================================
    public List<DentistDTO> findAll()
            throws Exception {

        String sql =
                "SELECT * FROM dentists ORDER BY id DESC";

        List<DentistDTO> dentists =
                new ArrayList<>();


        try (
                Connection c = DB.get();

                PreparedStatement ps =
                        c.prepareStatement(sql);

                ResultSet rs =
                        ps.executeQuery()
        ) {

            while (rs.next()) {

                dentists.add(
                        map(rs)
                );
            }
        }

        return dentists;
    }


    // =========================================================
    // GET DENTIST BY ID
    // =========================================================
    public DentistDTO findById(int id)
            throws Exception {

        String sql =
                "SELECT * FROM dentists WHERE id = ?";


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
    // CREATE DENTIST
    // =========================================================
    public DentistDTO create(
            DentistDTO dentist)
            throws Exception {

        String sql = """
                INSERT INTO dentists
                (
                    dentist_number,
                    dentist_name,
                    specialization,
                    phone,
                    email
                )
                VALUES (?, ?, ?, ?, ?)
                """;


        try (
                Connection c = DB.get();

                PreparedStatement ps =
                        c.prepareStatement(
                                sql,
                                Statement.RETURN_GENERATED_KEYS
                        )
        ) {


            // Automatically generate dentist number
            if (dentist.dentistNumber == null
                    || dentist.dentistNumber.isBlank()) {

                dentist.dentistNumber =
                        "DEN-" + System.currentTimeMillis();
            }


            ps.setString(
                    1,
                    dentist.dentistNumber
            );


            ps.setString(
                    2,
                    dentist.dentistName
            );


            ps.setString(
                    3,
                    dentist.specialization
            );


            ps.setString(
                    4,
                    dentist.phone
            );


            ps.setString(
                    5,
                    dentist.email
            );


            ps.executeUpdate();


            try (
                    ResultSet rs =
                            ps.getGeneratedKeys()
            ) {

                if (rs.next()) {

                    dentist.id =
                            rs.getInt(1);
                }
            }


            System.out.println(
                    "Dentist created successfully."
            );


            return dentist;
        }
    }


    // =========================================================
    // UPDATE DENTIST
    // =========================================================
    public boolean update(
            int id,
            DentistDTO dentist)
            throws Exception {

        String sql = """
                UPDATE dentists
                SET
                    dentist_name = ?,
                    specialization = ?,
                    phone = ?,
                    email = ?
                WHERE id = ?
                """;


        try (
                Connection c = DB.get();

                PreparedStatement ps =
                        c.prepareStatement(sql)
        ) {


            ps.setString(
                    1,
                    dentist.dentistName
            );


            ps.setString(
                    2,
                    dentist.specialization
            );


            ps.setString(
                    3,
                    dentist.phone
            );


            ps.setString(
                    4,
                    dentist.email
            );


            ps.setInt(
                    5,
                    id
            );


            int rows =
                    ps.executeUpdate();


            System.out.println(
                    "Dentist rows updated: "
                            + rows
            );


            return rows == 1;
        }
    }


    // =========================================================
    // DELETE DENTIST
    // =========================================================
    public boolean delete(int id)
            throws Exception {

        String sql =
                "DELETE FROM dentists WHERE id = ?";


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
                    "Dentist rows deleted: "
                            + rows
            );


            return rows == 1;
        }
    }


    // =========================================================
    // RESULTSET -> DTO
    // =========================================================
    private DentistDTO map(
            ResultSet rs)
            throws Exception {


        DentistDTO dentist =
                new DentistDTO();


        dentist.id =
                rs.getInt(
                        "id"
                );


        dentist.dentistNumber =
                rs.getString(
                        "dentist_number"
                );


        dentist.dentistName =
                rs.getString(
                        "dentist_name"
                );


        dentist.specialization =
                rs.getString(
                        "specialization"
                );


        dentist.phone =
                rs.getString(
                        "phone"
                );


        dentist.email =
                rs.getString(
                        "email"
                );


        return dentist;
    }
}