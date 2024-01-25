/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dao.MateriaDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.Materia;
import models.UsuarioMateria;
import services.MateriaService;

public class MateriaController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        try {
            if (accion != null) {
                switch (accion) {
                    case "agregarMateria":
                        agregarMateria(request, response);
                        break;

                    case "editarMateria":
                        editarMateria(request, response);
                        break;

                    case "eliminarMateria":
                        eliminarMateria(request, response);
                        break;
                        case "unirseMateria":
                        unirseMateria(request, response);
                        break;
                        
                        case "buscarPorNombre":
                        buscarPorNombre(request, response);
                        break;
                        
                        case "verMateria":
                            break;

                    default:
                        response.sendRedirect("/index.jsp");
                        break;
                }
            } else {
                response.sendRedirect("/index.jsp");
            }
        } catch (Exception e) {
            // Mostrar la traza de la excepción
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            e.printStackTrace(pw);
            String errorMessage = "Error inesperado. Detalles del error: " + sw.toString();
            request.setAttribute("error_message", errorMessage);

        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

private void agregarMateria(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    try {
        String nombre = request.getParameter("txtNombreMateria");
        String codigo = request.getParameter("txtCodigo");
        String descripcion = request.getParameter("txtDescripcion");
        int idDocente = Integer.parseInt(request.getParameter("idDocente"));

        // Verifica si el código de acceso ya existe
        MateriaService materiaService = new MateriaService();
        boolean existeCodigo = materiaService.existeCodigoAcceso(codigo);

        if (existeCodigo) {
             // Si el código de acceso ya existe, crea un mensaje de error
            String errorMessage = "El código de acceso ya existe. Por favor, elige otro.";

            // Guarda el mensaje de error en la sesión
            request.getSession().setAttribute("errorMessage", errorMessage);
            // Si el código de acceso ya existe, realiza la lógica necesaria (por ejemplo, muestra un mensaje de error)
            response.sendRedirect(request.getContextPath() + "/Usuario?error=CodigoExistente");
            return;
        }

        // Crea una instancia de la materia
        Materia materia = new Materia();
        materia.setNombre_materia(nombre);
        materia.setCodigo_acceso(codigo);
        materia.setDescripcion(descripcion);
        materia.setIdDocente(idDocente);

          MateriaDAO dao = new MateriaDAO();
            dao.IngresarMateria(materia);

        response.sendRedirect(request.getContextPath() + "/Usuario");

    } catch (Exception e) {
        e.printStackTrace();
        // Maneja el error adecuadamente, por ejemplo, redirigiendo a una página de error
        response.sendRedirect(request.getContextPath() + "/error.jsp");
    }
}

 
    private void eliminarMateria(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int materiaId = Integer.parseInt(request.getParameter("materiaId"));

            // Llama al dao para eliminar la materia
            MateriaDAO dao = new MateriaDAO();
            dao.eliminarMateria(materiaId);

            response.getWriter().write("{\"success\": true}");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false}");
        }
    }

    private void editarMateria(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Obtén los parámetros del formulario de edición
            int materiaId = Integer.parseInt(request.getParameter("id"));
            String nuevoNombre = request.getParameter("nombreMateria");
            String nuevoCodigo = request.getParameter("codigoMateria");
            String nuevaDescripcion = request.getParameter("descripcionMateria");

            // Crea una instancia de la materia con la nueva información
            Materia materia = new Materia();
            materia.setId(materiaId);
            materia.setNombre_materia(nuevoNombre);
            materia.setCodigo_acceso(nuevoCodigo);
            materia.setDescripcion(nuevaDescripcion);

            // Llama al dao para editar la materia
            MateriaDAO dao = new MateriaDAO();
            dao.editarMateria(materia);

            response.getWriter().write("{\"success\": true}");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false}");
        }
    }
    
    
    

    private void unirseMateria(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        
        String codigoAcceso = request.getParameter("codigoAcceso");
        int idEstudiante = Integer.parseInt(request.getParameter("idEstudiante"));

        MateriaDAO materiaDAO = new MateriaDAO();
        Materia materia = materiaDAO.getMateriaPorCodigo(codigoAcceso);

        if (materia != null) {
            
            if (!materiaDAO.estudianteUnidoAMateria(idEstudiante, materia.getId())) {

                UsuarioMateria usuarioMateria = new UsuarioMateria();
                usuarioMateria.setUsuario_id(idEstudiante);
                usuarioMateria.setMateria_id(materia.getId());
                usuarioMateria.setFechaInscripcion(new Date(System.currentTimeMillis()));

                materiaDAO.agregarUsuarioMateria(usuarioMateria);

                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Te uniste a la materia correctamente.");
            } else {

                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Ya te uniste previamente a esta materia.");
            }
        } else {

            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Codigo incorrecto o materia no encontrada.");
        }
    } catch (Exception e) {
        e.printStackTrace();

        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        response.getWriter().write("Error inesperado en el servidor.");
    }
}
    
    
    
    
    
    private void buscarPorNombre(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        
        String nombreBusqueda = request.getParameter("nombreBusqueda");

        
        MateriaDAO dao = new MateriaDAO();
        List<Materia> materiasEncontradas = dao.obtenerMateriasPorNombre(nombreBusqueda);

        
        Gson gson = new Gson();
        String jsonResult = gson.toJson(materiasEncontradas);

        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResult);

    } catch (Exception e) {
        e.printStackTrace();

        
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        response.getWriter().write("Error inesperado en el servidor.");
    }
}






}
