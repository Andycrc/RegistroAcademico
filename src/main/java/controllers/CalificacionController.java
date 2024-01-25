package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.Materia;
import services.UsuarioService;

@WebServlet(name = "CalificacionController", urlPatterns = {"/calificaciones/*"})
public class CalificacionController extends HttpServlet {
             
            
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Lógica para manejar la ruta "/calificaciones"
            // Puedes realizar operaciones GET generales aquí
        } else {
            // Lógica para manejar rutas adicionales bajo "/api/calificaciones"
            String[] pathParts = pathInfo.split("/");
            if (pathParts.length == 2) {
                String calificacionId = pathParts[1];
                // Lógica para manejar la ruta con un identificador específico (por ejemplo, ID de calificación)
            } else if (pathParts.length == 3) {
                String idMateria = pathParts[2];
                // Lógica para manejar la ruta con un identificador de materia específico
            }
        }
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
    
}
