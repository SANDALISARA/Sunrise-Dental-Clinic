package sunrise.dental.service.dao;

import sunrise.dental.service.dto.DentistDTO;
import sunrise.dental.service.util.DB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DentistDAO {

    public List<DentistDTO> findAll()
            throws Exception {

        String sql =
                "SELECT * FROM dentists ORDER BY dentist_name";

        try (
                Connection c = DB.get();
                PreparedStatement ps =
                        c.prepareStatement(sql);
                ResultSet rs =
                        ps.executeQuery()
        ) {

            List<DentistDTO> list =
                    new ArrayList<>();

            while (rs.next()) {
                list.add(map(rs));
            }

            return list;
        }
    }

    public DentistDTO findById(int id)
            throws Exception {

        String sql =
                "SELECT * FROM dentists WHERE id=?";

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

    public DentistDTO create(
            DentistDTO d)
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

            ps.setString(1, d.dentistNumber);
            ps.setString(2, d.dentistName);
            ps.setString(3, d.specialization);
            ps.setString(4, d.phone);
            ps.setString(5, d.email);

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
            DentistDTO d)
            throws Exception {

        String sql = """
                UPDATE dentists
                SET dentist_number=?,
                    dentist_name=?,
                    specialization=?,
                    phone=?,
                    email=?
                WHERE id=?
                """;

        try (
                Connection c = DB.get();
                PreparedStatement ps =
                        c.prepareStatement(sql)
        ) {

            ps.setString(1, d.dentistNumber);
            ps.setString(2, d.dentistName);
            ps.setString(3, d.specialization);
            ps.setString(4, d.phone);
            ps.setString(5, d.email);
            ps.setInt(6, id);

            return ps.executeUpdate() == 1;
        }
    }

    public boolean delete(int id)
            throws Exception {

        String sql =
                "DELETE FROM dentists WHERE id=?";

        try (
                Connection c = DB.get();
                PreparedStatement ps =
                        c.prepareStatement(sql)
        ) {

            ps.setInt(1, id);

            return ps.executeUpdate() == 1;
        }
    }

    private DentistDTO map(ResultSet rs)
            throws Exception {

        DentistDTO d =
                new DentistDTO();

        d.id =
                rs.getInt("id");

        d.dentistNumber =
                rs.getString("dentist_number");

        d.dentistName =
                rs.getString("dentist_name");

        d.specialization =
                rs.getString("specialization");

        d.phone =
                rs.getString("phone");

        d.email =
                rs.getString("email");

        return d;
    }
}