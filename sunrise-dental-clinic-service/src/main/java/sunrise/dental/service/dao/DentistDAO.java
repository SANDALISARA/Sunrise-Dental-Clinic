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

    // GET ALL DENTISTS
    public List<DentistDTO> findAll() throws Exception {

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
                dentists.add(map(rs));
            }
        }

        return dentists;
    }


    // GET DENTIST BY ID
    public DentistDTO findById(int id)
            throws Exception {

        String sql =
                "SELECT * FROM dentists WHERE id = ?";

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


    // CREATE DENTIST
    public DentistDTO create(DentistDTO d)
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
            if (d.dentistNumber == null
                    || d.dentistNumber.isBlank()) {

                d.dentistNumber =
                        "DEN-" + System.currentTimeMillis();
            }

            ps.setString(
                    1,
                    d.dentistNumber
            );

            ps.setString(
                    2,
                    d.dentistName
            );

            ps.setString(
                    3,
                    d.specialization
            );

            ps.setString(
                    4,
                    d.phone
            );

            ps.setString(
                    5,
                    d.email
            );

            int rows =
                    ps.executeUpdate();

            System.out.println(
                    "Dentist rows inserted: " + rows
            );

            try (
                    ResultSet rs =
                            ps.getGeneratedKeys()
            ) {

                if (rs.next()) {
                    d.id = rs.getInt(1);
                }
            }

            System.out.println(
                    "Dentist registered successfully"
            );

            System.out.println(
                    "Dentist ID: " + d.id
            );

            System.out.println(
                    "Dentist Number: "
                            + d.dentistNumber
            );

            return d;
        }
    }


    // UPDATE DENTIST
    public boolean update(
            int id,
            DentistDTO d)
            throws Exception {

        String sql = """
                UPDATE dentists
                SET
                    dentist_number = ?,
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
                    d.dentistNumber
            );

            ps.setString(
                    2,
                    d.dentistName
            );

            ps.setString(
                    3,
                    d.specialization
            );

            ps.setString(
                    4,
                    d.phone
            );

            ps.setString(
                    5,
                    d.email
            );

            ps.setInt(
                    6,
                    id
            );

            return ps.executeUpdate() == 1;
        }
    }


    // DELETE DENTIST
    public boolean delete(int id)
            throws Exception {

        String sql =
                "DELETE FROM dentists WHERE id = ?";

        try (
                Connection c = DB.get();
                PreparedStatement ps =
                        c.prepareStatement(sql)
        ) {

            ps.setInt(1, id);

            return ps.executeUpdate() == 1;
        }
    }


    // MAP DATABASE RESULT TO DTO
    private DentistDTO map(ResultSet rs)
            throws Exception {

        DentistDTO d =
                new DentistDTO();

        d.id =
                rs.getInt("id");

        d.dentistNumber =
                rs.getString(
                        "dentist_number"
                );

        d.dentistName =
                rs.getString(
                        "dentist_name"
                );

        d.specialization =
                rs.getString(
                        "specialization"
                );

        d.phone =
                rs.getString(
                        "phone"
                );

        d.email =
                rs.getString(
                        "email"
                );

        return d;
    }
}