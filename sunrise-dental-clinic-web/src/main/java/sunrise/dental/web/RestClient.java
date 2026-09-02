package sunrise.dental.web;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

public class RestClient {

    private static final String BASE =
            System.getProperty(
                    "service.base",
                    "http://localhost:8080/sunrise-dental-service/api/"
            );

    public static String get(String path)
            throws IOException {

        HttpURLConnection connection =
                (HttpURLConnection)
                        new URL(BASE + path).openConnection();

        connection.setRequestMethod("GET");

        return read(connection);
    }

    public static String post(
            String path,
            String json)
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

        try (OutputStream output =
                     connection.getOutputStream()) {

            output.write(
                    json.getBytes(StandardCharsets.UTF_8)
            );
        }

        return read(connection);
    }

    public static String put(
            String path,
            String json)
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

        try (OutputStream output =
                     connection.getOutputStream()) {

            output.write(
                    json.getBytes(StandardCharsets.UTF_8)
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

        int statusCode =
                connection.getResponseCode();

        InputStream inputStream;

        if (statusCode >= 400) {
            inputStream = connection.getErrorStream();
        } else {
            inputStream = connection.getInputStream();
        }

        if (inputStream == null) {
            return "";
        }

        try (InputStream input = inputStream) {

            return new String(
                    input.readAllBytes(),
                    StandardCharsets.UTF_8
            );
        }
    }
}