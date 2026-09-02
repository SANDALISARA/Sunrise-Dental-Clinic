package sunrise.dental.service.dao;

import sunrise.dental.service.dto.BillDTO;
import sunrise.dental.service.util.DB;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {

    public BillDTO createBill(
            BillDTO bill)
            throws Exception {

        try (Connection c = DB.get()) {

            c.setAutoCommit(false);

            try {

                // Get predetermined treatment price
                String treatmentSql =
                        "SELECT price FROM treatments WHERE id=?";

                try (
                        PreparedStatement ps =
                                c.prepareStatement(
                                        treatmentSql
                                )
                ) {

                    ps.setInt(
                            1,
                            bill.treatmentId
                    );

                    try (ResultSet rs =
                                 ps.executeQuery()) {

                        if (!rs.next()) {

                            throw new SQLException(
                                    "Treatment not found: "
                                            + bill.treatmentId
                            );
                        }

                        bill.treatmentFee =
                                rs.getDouble("price");
                    }
                }

                bill.totalAmount =
                        bill.consultationFee
                                + bill.treatmentFee;

                bill.billNumber =
                        generateBillNumber();

                bill.billDate =
                        LocalDate.now().toString();

                if (bill.paymentStatus == null
                        || bill.paymentStatus.isBlank()) {

                    bill.paymentStatus =
                            "Pending";
                }

                String sql = """
                        INSERT INTO bills
                        (
                            bill_number,
                            patient_id,
                            appointment_id,
                            treatment_id,
                            consultation_fee,
                            treatment_fee,
                            total_amount,
                            bill_date,
                            payment_status
                        )
                        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                        """;

                try (
                        PreparedStatement ps =
                                c.prepareStatement(
                                        sql,
                                        Statement.RETURN_GENERATED_KEYS
                                )
                ) {

                    ps.setString(
                            1,
                            bill.billNumber
                    );

                    ps.setInt(
                            2,
                            bill.patientId
                    );

                    ps.setInt(
                            3,
                            bill.appointmentId
                    );

                    ps.setInt(
                            4,
                            bill.treatmentId
                    );

                    ps.setDouble(
                            5,
                            bill.consultationFee
                    );

                    ps.setDouble(
                            6,
                            bill.treatmentFee
                    );

                    ps.setDouble(
                            7,
                            bill.totalAmount
                    );

                    ps.setString(
                            8,
                            bill.billDate
                    );

                    ps.setString(
                            9,
                            bill.paymentStatus
                    );

                    ps.executeUpdate();

                    try (ResultSet rs =
                                 ps.getGeneratedKeys()) {

                        if (rs.next()) {
                            bill.id =
                                    rs.getInt(1);
                        }
                    }
                }

                c.commit();

                return bill;

            } catch (Exception e) {

                c.rollback();

                throw e;

            } finally {

                c.setAutoCommit(true);
            }
        }
    }

    public List<BillDTO> findAll()
            throws Exception {

        String sql = """
                SELECT *
                FROM bills
                ORDER BY id DESC
                """;

        try (
                Connection c = DB.get();
                PreparedStatement ps =
                        c.prepareStatement(sql);
                ResultSet rs =
                        ps.executeQuery()
        ) {

            List<BillDTO> bills =
                    new ArrayList<>();

            while (rs.next()) {

                BillDTO d =
                        new BillDTO();

                d.id =
                        rs.getInt("id");

                d.billNumber =
                        rs.getString(
                                "bill_number"
                        );

                d.patientId =
                        rs.getInt(
                                "patient_id"
                        );

                d.appointmentId =
                        rs.getInt(
                                "appointment_id"
                        );

                d.treatmentId =
                        rs.getInt(
                                "treatment_id"
                        );

                d.consultationFee =
                        rs.getDouble(
                                "consultation_fee"
                        );

                d.treatmentFee =
                        rs.getDouble(
                                "treatment_fee"
                        );

                d.totalAmount =
                        rs.getDouble(
                                "total_amount"
                        );

                d.billDate =
                        rs.getString(
                                "bill_date"
                        );

                d.paymentStatus =
                        rs.getString(
                                "payment_status"
                        );

                bills.add(d);
            }

            return bills;
        }
    }

    private String generateBillNumber() {

        return "BILL-" +
                System.currentTimeMillis();
    }
}