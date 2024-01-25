package controllers;

import java.io.IOException;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/checkDatabase")
public class DatabaseCheckServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/registroAcademico";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        boolean baseDeDatosExiste = false;
        try {
            baseDeDatosExiste = validarExistenciaDeBaseDeDatos();
        } catch (SQLException ex) {
            Logger.getLogger(DatabaseCheckServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"databaseExists\":" + baseDeDatosExiste + "}");
    }

    private boolean validarExistenciaDeBaseDeDatos() throws SQLException {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            return true;
        } catch (ClassNotFoundException e) {
            return false;
        } finally {
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
