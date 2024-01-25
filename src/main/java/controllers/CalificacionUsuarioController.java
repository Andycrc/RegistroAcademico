package controllers;
import javax.json.Json;
import javax.json.JsonArray;
import javax.json.JsonObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;
import javax.json.JsonReader;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.CalificacionUsuario;
import models.Evaluacion;
import models.Materia;
import models.Usuario;
import models.UsuarioMateria;
import services.CalificacionService;
import services.EvaluacionService;
import services.UsuarioMateriaService;
import services.UsuarioService;
import utils.SessionManager;


@WebServlet(name = "CalificacionUsuarioController", urlPatterns = {"/CalificacionUsuario","/CalificacionesMaestro","/CalificacionesMateria"})
public class CalificacionUsuarioController extends HttpServlet {
    private final CalificacionService scalificacion = new CalificacionService();
    private final UsuarioMateriaService usuariomateria = new UsuarioMateriaService();
    private final UsuarioService usuario = new UsuarioService();
    private final EvaluacionService evaluacion = new EvaluacionService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
           String uri = request.getRequestURI();
        if (uri.endsWith("/CalificacionUsuario")) {
            String idEvaluacion = request.getParameter("idEvaluacion");
            int idEvaluacionI = Integer.parseInt(idEvaluacion);
            HttpSession session = request.getSession();
        
            Evaluacion evaluaciones = evaluacion.buscarEvaluacionPorId(idEvaluacionI);
            request.setAttribute("evaluaciones", evaluaciones);

            String idMateriaString = (String) session.getAttribute("idMateria");
            int idMateria = Integer.parseInt(idMateriaString);

            //cargar usuario incritos a esa materia 
            List<Usuario> usuariosM = usuario.getUsuariosByMateriaId(idMateria);

            request.setAttribute("usuariosM", usuariosM);
           // Crear una lista para almacenar las calificaciones de los usuarios
            List<CalificacionUsuario> calificacionesUsuariosc = new ArrayList<>();

            // Iterar sobre la lista de usuarios
            for (Usuario usuario : usuariosM) {
                // Obtener el ID del usuario
                int idUsuario = usuario.getId();

                // Llamar al método para buscar la calificación del usuario para la evaluación
                CalificacionUsuario calificacionUsuario = scalificacion.buscarCalificacionUsuarioPorUsuarioYEvaluacion(idUsuario, idEvaluacionI);

                // Si se encontró una calificación, agregarla a la lista
                if (calificacionUsuario != null) {
                    calificacionesUsuariosc.add(calificacionUsuario);
                }
            }

            request.setAttribute("calificacionesUsuariosc", calificacionesUsuariosc);

            // Guarda el ID de la materia en la sesión
            session.setAttribute("idEvaluacion", idEvaluacion);

            List<CalificacionUsuario> calificaciones = scalificacion.buscarCalificacionUsuario(idEvaluacion);

            request.setAttribute("calificaciones", calificaciones);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/Docente/evaluaciones/calificacion.jsp");
                // Redirige a la página JSP
                dispatcher.forward(request, response);
        } else if (uri.endsWith("/CalificacionesMaestro")) {
            Usuario userLogged = (Usuario) SessionManager.getAttribute(request, "Usuario");
            List<Materia> materias = usuario.obtenerMateriasPorDocente(userLogged.getId());
            request.setAttribute("materias", materias);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/Docente/calificaciones/index.jsp");
            dispatcher.forward(request, response);

          
        }else if (uri.endsWith("/CalificacionesMateria")) {
           HttpSession session = request.getSession();

            String idMateria = request.getParameter("idMateria");
            session.setAttribute("idMateria", idMateria);

            List<Object[]> datosCalificaciones = scalificacion.obtenerDatosCalificacionesPorMateria(Integer.parseInt(idMateria));
            request.setAttribute("datosCalificaciones", datosCalificaciones);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/Docente/calificaciones/calificaciones.jsp");
            dispatcher.forward(request, response);

          
        }
        
          
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                 String accion = request.getParameter("accion");
                 if (accion != null) {
                    switch (accion) {
                        case "agregarCalificacion":
                            agregarCalificacion(request, response);
                            break;
                       case "actualizarCalificacion":
                           actualizarCalificacion(request,response );
                           break;
                       case "filtrarfecha":
                           filtrarFecha(request,response);
                           break;
                        default:
                            // Manejar otra acción si es necesario
                            break;
                }
        }
    }
    
    private void filtrarFecha(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String idMateria = request.getParameter("idMateria");
        String fecha = request.getParameter("fechaFiltro");
            List<Object[]> datosCalificaciones = scalificacion.obtenerDatosCalificacionesFiltradasPorMateriaYFecha(Integer.parseInt(idMateria),fecha);
            request.setAttribute("datosCalificaciones", datosCalificaciones);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/Docente/calificaciones/calificaciones.jsp");
            dispatcher.forward(request, response);
    }
   private void agregarCalificacion(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            // Obtiene la cadena JSON de la solicitud
            StringBuilder jsonRequest = new StringBuilder();
            String line;
            BufferedReader reader = request.getReader();
            while ((line = reader.readLine()) != null) {
                jsonRequest.append(line);
            }

            // Convierte la cadena JSON a una lista de objetos CalificacionUsuario
            List<CalificacionUsuario> calificacionesUsuarios = parseJson(jsonRequest.toString());

            HttpSession session = request.getSession();
            String idEvaluacionString = (String) session.getAttribute("idEvaluacion");

            if (idEvaluacionString != null) {
                int idEvaluacion = Integer.parseInt(idEvaluacionString);

                for (CalificacionUsuario calificacionUsuario : calificacionesUsuarios) {
                    int usuarioId = calificacionUsuario.getUsuario_id();
                    double calificacion = calificacionUsuario.getCalificacion();
                    int materiaID = calificacionUsuario.getMateria_id();
                    String fechaCalificacion = calificacionUsuario.getFecha_calificacion();
                    // Insertar la calificación en la base de datos
                    scalificacion.insertarCalificacionUsuario(usuarioId,materiaID, calificacion, fechaCalificacion,idEvaluacion);
                }
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": true}");

            } else {
                // Manejar el caso en el que idEvaluacion es nulo
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false, \"error\": \"Error: El ID de evaluación no es un número válido\"}");        }
        } catch (Exception e) {
            e.printStackTrace();
            // Manejar la excepción según tus necesidades
            response.sendRedirect(request.getContextPath() + "/ErrorPage.jsp");
        }
    }

    private void actualizarCalificacion(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            // Obtiene la cadena JSON de la solicitud
            StringBuilder jsonRequest = new StringBuilder();
            String line;
            BufferedReader reader = request.getReader();
            while ((line = reader.readLine()) != null) {
                jsonRequest.append(line);
            }

            // Convierte la cadena JSON a una lista de objetos CalificacionUsuario
            List<CalificacionUsuario> calificacionesUsuarios = parseJson(jsonRequest.toString());

            HttpSession session = request.getSession();
            String idEvaluacionString = (String) session.getAttribute("idEvaluacion");

            if (idEvaluacionString != null) {
                int idEvaluacion = Integer.parseInt(idEvaluacionString);

                for (CalificacionUsuario calificacionUsuario : calificacionesUsuarios) {
                    int usuarioId = calificacionUsuario.getUsuario_id();
                    double calificacion = calificacionUsuario.getCalificacion();
                    int materiaID = calificacionUsuario.getMateria_id();
                    String fechaCalificacion = calificacionUsuario.getFecha_calificacion();
                    // Insertar la calificación en la base de datos
                    scalificacion.actualizarCalificacionUsuario(usuarioId,idEvaluacion,calificacion,fechaCalificacion);
                }
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": true}");

            } else {
                // Manejar el caso en el que idEvaluacion es nulo
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false, \"error\": \"Error: El ID de evaluación no es un número válido\"}");        }
        } catch (Exception e) {
            e.printStackTrace();
            // Manejar la excepción según tus necesidades
            response.sendRedirect(request.getContextPath() + "/ErrorPage.jsp");
        }
    }

    private List<CalificacionUsuario> parseJson(String jsonString) {
        List<CalificacionUsuario> calificacionesUsuarios = new ArrayList<>();

        try (JsonReader reader = Json.createReader(new StringReader(jsonString))) {
            JsonArray jsonArray = reader.readArray();

            for (JsonObject jsonObject : jsonArray.getValuesAs(JsonObject.class)) {
                int usuarioId = Integer.parseInt(jsonObject.getString("usuario_id"));
                int materiaId = Integer.parseInt(jsonObject.getString("materia_id"));
                double calificacion = jsonObject.getJsonNumber("calificacion").doubleValue();
                String fechaCalificacion = jsonObject.getString("fecha_calificacion");
                int idEvaluacion = Integer.parseInt(jsonObject.getString("id_evaluacion"));

                CalificacionUsuario calificacionUsuario = new CalificacionUsuario();
                calificacionUsuario.setUsuario_id(usuarioId);
                calificacionUsuario.setMateria_id(materiaId);
                calificacionUsuario.setCalificacion(calificacion);
                calificacionUsuario.setFecha_calificacion(fechaCalificacion);
                calificacionUsuario.setId_evaluacion(idEvaluacion);

                calificacionesUsuarios.add(calificacionUsuario);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Manejar la excepción según tus necesidades
        }

        return calificacionesUsuarios;
    }



}
