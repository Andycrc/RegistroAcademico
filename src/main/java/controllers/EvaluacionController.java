/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.Evaluacion;
import services.CalificacionService;
import services.EvaluacionService;


@WebServlet(name = "EvaluacionController", urlPatterns = {"/Evaluacion"})
public class EvaluacionController extends HttpServlet {
    private final EvaluacionService evaluacion = new EvaluacionService();
    CalificacionService calificacionService = new CalificacionService();

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idMateria = request.getParameter("idMateria");
        // Guarda el ID de la materia en la sesión
        HttpSession session = request.getSession();
        List<Object[]> datosCalificaciones = calificacionService.obtenerDatosCalificacionesPorMateria(Integer.parseInt(idMateria));

        // Pasa los resultados a la vista
        request.setAttribute("datosCalificaciones", datosCalificaciones);
        
        session.setAttribute("idMateria", idMateria);
        
        List<Evaluacion> evaluaciones = evaluacion.buscarEvaluacionesMateria(idMateria);
         double sumaPorcentajes = 0;
            for (Evaluacion evaluacion : evaluaciones) {
                sumaPorcentajes += evaluacion.getPorcentajeCalificacion();
            }

        // Agregar la suma a la solicitud para enviarla a la vista
        request.setAttribute("sumaPorcentajes", sumaPorcentajes);
        
        request.setAttribute("evaluaciones", evaluaciones);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/Docente/evaluaciones/index.jsp");
                // Redirige a la página JSP
        dispatcher.forward(request, response);

        
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         String accion = request.getParameter("accion");

        if (accion != null) {
            switch (accion) {
                case "agregarEvaluacion":
                    agregarEvaluacion(request, response);
                    break;
                case "eliminarEvaluacion":
                    eliminarEvaluacion(request, response);
                    break;
                case "actualizarEvaluacion":
                    actualizarNombreEvaluacion(request, response);
                    break;
                // Agrega más casos según tus necesidades
                default:
                    // Manejar otra acción si es necesario
                    break;
            }
        }
    }
    
     private void agregarEvaluacion(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
            // Obtener datos del formulario
            String nombreEvaluacion = request.getParameter("txtNombreEvaluacion");
            int materiaId = Integer.parseInt(request.getParameter("idMateria"));
            double porcentajeCalificacion = Double.parseDouble(request.getParameter("txtPorcentajeCalificacion"));
            // Aquí podrías realizar validaciones adicionales si es necesario

            // Agregar evaluación a la base de datos
            evaluacion.insertarEvaluacionMateria(nombreEvaluacion,porcentajeCalificacion, materiaId);

            // Redirigir a la página de éxito o a donde sea necesario
            // Aquí puedes agregar un mensaje de éxito si lo deseas
            request.setAttribute("mensajeExito", "La evaluación se ha agregado correctamente");
            // Puedes redirigir a la misma página del formulario o a otra página
            response.sendRedirect("Evaluacion?idMateria="+materiaId);

        } catch (NumberFormatException e) {
            // Manejar el error de conversión a entero
            // Puedes agregar un mensaje de error específico para este caso
            request.setAttribute("mensajeError", "Error: El ID de materia no es un número válido");
            // Redirigir a la página de error o al formulario con un mensaje de error
            response.sendRedirect("formulario_evaluacion.jsp");

        } catch (Exception e) {
            // Manejar otros errores
            // Puedes agregar un mensaje de error genérico para otros casos
            request.setAttribute("mensajeError", "Ha ocurrido un error al agregar la evaluación");
            // Redirigir a la página de error o al formulario con un mensaje de error
            response.sendRedirect("formulario_evaluacion.jsp");
        }
    }
    
    private void eliminarEvaluacion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Obtener el ID de la evaluación a eliminar
            int idEvaluacion = Integer.parseInt(request.getParameter("idEvaluacion"));
            // Llamar al método correspondiente en el servicio
            evaluacion.eliminarEvaluacionMateria(idEvaluacion);

            // Enviar una respuesta JSON de éxito
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\": true}");
        } catch (NumberFormatException e) {
            // Enviar una respuesta JSON de error con mensaje específico
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\": false, \"error\": \"Error: El ID de evaluación no es un número válido\"}");
        } catch (Exception e) {
            // Enviar una respuesta JSON de error genérico
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\": false, \"error\": \"Ha ocurrido un error al eliminar la evaluación\"}");
        }
    }
    private void actualizarNombreEvaluacion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            try {
                // Obtener datos del formulario
                int idEvaluacion = Integer.parseInt(request.getParameter("id"));
                String nuevoNombreEvaluacion = request.getParameter("nombreEvaluacion");
                int nuevoIdmateria = Integer.parseInt(request.getParameter("idMateria"));
                double nuevoPorcentajeCalificacion = Double.parseDouble(request.getParameter("porcentajeCalificacion"));

                // Aquí podrías realizar validaciones adicionales si es necesario

                // Actualizar nombre de la evaluación en la base de datos
                evaluacion.actualizarNombreEvaluacion(idEvaluacion, nuevoNombreEvaluacion,nuevoPorcentajeCalificacion,nuevoIdmateria);

                // Enviar una respuesta JSON de éxito
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": true}");
            } catch (NumberFormatException e) {
                // Enviar una respuesta JSON de error con mensaje específico
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false, \"error\": \"Error: El ID de evaluación no es un número válido\"}");
            } catch (Exception e) {
                // Enviar una respuesta JSON de error genérico
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false, \"error\": \"Ha ocurrido un error al actualizar el nombre de la evaluación\"}");
            }
        }





  
}
