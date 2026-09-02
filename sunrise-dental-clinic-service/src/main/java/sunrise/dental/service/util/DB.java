package sunrise.dental.service.util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class DB {

    private static final Properties properties =
            new Properties();

    static {

        try (
                InputStream in =
                        DB.class
                                .getClassLoader()
                                .getResourceAsStream(
                                        "db.properties"
                                )
        ) {

            if (in == null) {

                throw new RuntimeException(
                        "db.properties not found"
                );
            }

            properties.load(in);

            Class.forName(
                    "com.mysql.cj.jdbc.Driver"
            );

        } catch (Exception e) {

            throw new RuntimeException(
                    "Database configuration error",
                    e
            );
        }
    }

    public static Connection get()
            throws Exception {

        String url =
                properties.getProperty(
                        "db.url"
                );

        String user =
                properties.getProperty(
                        "db.user"
                );

        String password =
                properties.getProperty(
                        "db.password"
                );

        return DriverManager.getConnection(
                url,
                user,
                password
        );
    }
}