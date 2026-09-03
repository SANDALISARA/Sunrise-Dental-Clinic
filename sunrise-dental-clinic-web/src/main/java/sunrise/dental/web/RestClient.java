package sunrise.dental.web;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

public class RestClient {

    private static final String BASE =
            "http://localhost:8080/sunrise-dental-clinic-service/api/";

    public static String get(String path) throws IOException {

        HttpURLConnection connection =
                (HttpURLConnection)
                new URL(BASE + path).openConnection();

        connection.setRequestMethod("GET");
        connection.setRequestProperty("Accept", "application/json");

        return read(connection);
    }

    public static String post(String path, String json)
            throws IOException {

        HttpURLConnection connection =
                (HttpURLConnection)
                new URL(BASE + path).openConnection();

        connection.setRequestMethod("POST");

        connection.setRequestProperty(
                "Content-Type",
                "application/json"
        );

        connection.setRequestProperty(
                "Accept",
                "application/json"
        );

        connection.setDoOutput(true);

        try (OutputStream os =
                     connection.getOutputStream()) {

            os.write(
                    json.getBytes(
                            StandardCharsets.UTF_8
                    )
            );
        }

        return read(connection);
    }

    public static String put(String path, String json)
            throws IOException {

        HttpURLConnection connection =
                (HttpURLConnection)
                new URL(BASE + path).openConnection();

        connection.setRequestMethod("PUT");

        connection.setRequestProperty(
                "Content-Type",
                "application/json"
        );

        connection.setRequestProperty(
                "Accept",
                "application/json"
        );

        connection.setDoOutput(true);

        try (OutputStream os =
                     connection.getOutputStream()) {

            os.write(
                    json.getBytes(
                            StandardCharsets.UTF_8
                    )
            );
        }

        return read(connection);
    }

    public static String delete(String path)
            throws IOException {

        HttpURLConnection connection =
                (HttpURLConnection)
                new URL(BASE + path).openConnection();

        connection.setRequestMethod("DELETE");

        return read(connection);
    }

    private static String read(
            HttpURLConnection connection)
            throws IOException {

        int code = connection.getResponseCode();

        InputStream stream;

        if (code >= 400) {
            stream = connection.getErrorStream();
        } else {
            stream = connection.getInputStream();
        }

        if (stream == null) {
            return "";
        }

        try (InputStream input = stream) {

            return new String(
                    input.readAllBytes(),
                    StandardCharsets.UTF_8
            );
        }
    }
}