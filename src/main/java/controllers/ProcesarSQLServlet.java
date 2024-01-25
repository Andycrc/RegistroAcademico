package controllers;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet(name = "ProcesarSQLServlet", urlPatterns = { "/ProcesarSQLServlet" })
@MultipartConfig
public class ProcesarSQLServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        boolean success = ejecutarScriptSQL(request);

        if (success) {
            response.getWriter().write("{\"status\":\"success\",\"message\":\"Base de datos creada con éxito.\"}");
        } else {
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Error al crear la base de datos.\"}");
        }
    }

    private boolean ejecutarScriptSQL(HttpServletRequest request) {
        try {
            Part filePart = request.getPart("archivoSQL");
            InputStream fileContent = filePart.getInputStream();

            try (BufferedReader reader = new BufferedReader(new InputStreamReader(fileContent))) {
                StringBuilder sqlScript = new StringBuilder();
                String line;

                while ((line = reader.readLine()) != null) {
                    sqlScript.append(line).append("\n");
                }

                return procesarArchivoSQL(sqlScript.toString());
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean procesarArchivoSQL(String sqlScript) {
        Connection connection = null;
        Statement statement = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            statement = connection.createStatement();

            // Divide el script SQL en declaraciones individuales utilizando el punto y coma
            // como separador
            String[] sqlStatements = sqlScript.split(";");

            for (String sql : sqlStatements) {
                if (!sql.trim().isEmpty()) {
                    // Ejecuta cada declaración SQL individual
                    statement.execute(sql);
                }
            }

            return true;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            if (statement != null) {
                try {
                    statement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
