package controllers;

import dao.CalificacionUsuarioDao;
import dao.EvaluacionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.CalificacionUsuario;
import models.Evaluacion;

@WebServlet(name = "EntrarMateriaController", urlPatterns = {"/EntrarMateriaController"})
public class EntrarMateriaController extends HttpServlet {

    private final EvaluacionDAO evaluacionDao = new EvaluacionDAO();
    private final CalificacionUsuarioDao calificacionUsuarioDao = new CalificacionUsuarioDao();
    
    @Override
    public void init() throws ServletException {
        super.init();
    }

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String materiaIdParam = request.getParameter("materiaId");
        String materiaNombre = request.getParameter("materiaNombre");
        String estudianteId = request.getParameter("estudianteId");

    if (materiaIdParam != null && !materiaIdParam.isEmpty()) {
        try {
            int materiaId = Integer.parseInt(materiaIdParam);
            

            System.out.println("Materia ID: " + materiaId);
            System.out.println("Materia Nombre: " + materiaNombre);
            System.out.println("Estudiante ID: " + estudianteId);

            request.setAttribute("nombreMateria", materiaNombre);
            
            List<Evaluacion> evaluaciones = evaluacionDao.buscarEvaluacionesMateria(materiaId + "");
            List<CalificacionUsuario> calificaciones = calificacionUsuarioDao.obtenerCalificacionesPorMateriaYEstudiante(materiaId , estudianteId + "");
            
            // Obtener la lista de calificaciones y evaluaciones disponibles
           // List<CalificacionUsuario> calificaciones = calificacionUsuarioDao.obtenerCalificacionesPorMateriaYEstudiante(materiaId, estudianteId);
            //System.out.println("Tamaño de la lista de calificaciones en controller: " + calificaciones.size());

            if (evaluaciones.size() > 0) {
                request.setAttribute("evaluaciones", evaluaciones);
            }
            
            System.out.println(calificaciones);
            
            request.setAttribute("calificaciones", calificaciones);

            RequestDispatcher dispatcher = request.getRequestDispatcher("views/Estudiante/materia.jsp");
            dispatcher.forward(request, response);
        } catch (NumberFormatException e) {
            System.err.println("Invalid Materia ID format: " + materiaIdParam);
            response.sendRedirect(request.getContextPath());
        }
    } else {
        response.sendRedirect(request.getContextPath());
    }
}

    

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
