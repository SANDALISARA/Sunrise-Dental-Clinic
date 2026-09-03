package sunrise.dental.service.dao;

import sunrise.dental.service.dto.BillDTO;
import sunrise.dental.service.util.DB;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {

    // =========================================================
    // CREATE BILL
    // =========================================================
    public BillDTO createBill(BillDTO bill)
            throws Exception {

        try (Connection c = DB.get()) {

            c.setAutoCommit(false);

            try {

                // ---------------------------------------------
                // GET TREATMENT PRICE
                // ---------------------------------------------
                String treatmentSql =
                        "SELECT price FROM treatments WHERE id=?";

                try (
                        PreparedStatement ps =
                                c.prepareStatement(treatmentSql)
                ) {

                    ps.setInt(
                            1,
                            bill.treatmentId
                    );

                    try (
                            ResultSet rs =
                                    ps.executeQuery()
                    ) {

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


                // ---------------------------------------------
                // CALCULATE TOTAL
                // ---------------------------------------------
                bill.totalAmount =
                        bill.consultationFee
                                + bill.treatmentFee;


                // ---------------------------------------------
                // BILL NUMBER
                // ---------------------------------------------
                bill.billNumber =
                        "BILL-"
                                + System.currentTimeMillis();


                bill.billDate =
                        LocalDate.now().toString();


                // New bill starts as Pending
                bill.paymentStatus =
                        "Pending";


                // ---------------------------------------------
                // INSERT BILL
                // ---------------------------------------------
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


                    try (
                            ResultSet rs =
                                    ps.getGeneratedKeys()
                    ) {

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


    // =========================================================
    // GET ALL BILLS
    // =========================================================
    public List<BillDTO> findAll()
            throws Exception {

        String sql =
                "SELECT * FROM bills ORDER BY id DESC";


        List<BillDTO> bills =
                new ArrayList<>();


        try (
                Connection c = DB.get();

                PreparedStatement ps =
                        c.prepareStatement(sql);

                ResultSet rs =
                        ps.executeQuery()
        ) {

            while (rs.next()) {

                bills.add(
                        map(rs)
                );
            }
        }


        return bills;
    }


    // =========================================================
    // GET BILL BY ID
    // =========================================================
    public BillDTO findById(int id)
            throws Exception {

        String sql =
                "SELECT * FROM bills WHERE id=?";


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
    // PAY BILL
    // =========================================================
    public boolean markAsPaid(int id)
            throws Exception {

        String sql = """
                UPDATE bills
                SET payment_status='Paid'
                WHERE id=?
                """;


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
    // MAP DATABASE RESULT
    // =========================================================
    private BillDTO map(ResultSet rs)
            throws Exception {

        BillDTO bill =
                new BillDTO();


        bill.id =
                rs.getInt("id");

        bill.billNumber =
                rs.getString(
                        "bill_number"
                );

        bill.patientId =
                rs.getInt(
                        "patient_id"
                );

        bill.appointmentId =
                rs.getInt(
                        "appointment_id"
                );

        bill.treatmentId =
                rs.getInt(
                        "treatment_id"
                );

        bill.consultationFee =
                rs.getDouble(
                        "consultation_fee"
                );

        bill.treatmentFee =
                rs.getDouble(
                        "treatment_fee"
                );

        bill.totalAmount =
                rs.getDouble(
                        "total_amount"
                );

        bill.billDate =
                rs.getString(
                        "bill_date"
                );

        bill.paymentStatus =
                rs.getString(
                        "payment_status"
                );


        return bill;
    }
}