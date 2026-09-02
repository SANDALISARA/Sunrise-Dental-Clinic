package sunrise.dental.service.dao;

import sunrise.dental.service.dto.TreatmentDTO;
import sunrise.dental.service.util.DB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TreatmentDAO {

    public List<TreatmentDTO> findAll()
            throws Exception {

        String sql =
                "SELECT * FROM treatments ORDER BY treatment_name";

        try (
                Connection c = DB.get();
                PreparedStatement ps =
                        c.prepareStatement(sql);
                ResultSet rs =
                        ps.executeQuery()
        ) {

            List<TreatmentDTO> list =
                    new ArrayList<>();

            while (rs.next()) {
                list.add(map(rs));
            }

            return list;
        }
    }

    public TreatmentDTO findById(int id)
            throws Exception {

        String sql =
                "SELECT * FROM treatments WHERE id=?";

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

    public TreatmentDTO create(
            TreatmentDTO d)
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

            ps.setString(1, d.treatmentCode);

            ps.setString(
                    2,
                    d.treatmentName
            );

            ps.setString(
                    3,
                    d.description
            );

            ps.setDouble(
                    4,
                    d.price
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
            TreatmentDTO d)
            throws Exception {

        String sql = """
                UPDATE treatments
                SET treatment_code=?,
                    treatment_name=?,
                    description=?,
                    price=?
                WHERE id=?
                """;

        try (
                Connection c = DB.get();
                PreparedStatement ps =
                        c.prepareStatement(sql)
        ) {

            ps.setString(
                    1,
                    d.treatmentCode
            );

            ps.setString(
                    2,
                    d.treatmentName
            );

            ps.setString(
                    3,
                    d.description
            );

            ps.setDouble(
                    4,
                    d.price
            );

            ps.setInt(
                    5,
                    id
            );

            return ps.executeUpdate() == 1;
        }
    }

    public boolean delete(int id)
            throws Exception {

        try (
                Connection c = DB.get();
                PreparedStatement ps =
                        c.prepareStatement(
                                "DELETE FROM treatments WHERE id=?"
                        )
        ) {

            ps.setInt(1, id);

            return ps.executeUpdate() == 1;
        }
    }

    private TreatmentDTO map(ResultSet rs)
            throws Exception {

        TreatmentDTO d =
                new TreatmentDTO();

        d.id =
                rs.getInt("id");

        d.treatmentCode =
                rs.getString("treatment_code");

        d.treatmentName =
                rs.getString("treatment_name");

        d.description =
                rs.getString("description");

        d.price =
                rs.getDouble("price");

        return d;
    }
}