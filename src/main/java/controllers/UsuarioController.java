package controllers;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.Materia;
import models.Usuario;
import models.UsuarioMateria;
import services.UsuarioService;
import utils.SessionManager;

@WebServlet("/Usuario/*")
public class UsuarioController extends HttpServlet {

    // Diccionario que mapea las acciones a las rutas
    private Map<String, String> actionToPath = new HashMap<>();
    private UsuarioService usuario = new UsuarioService();
    
    public UsuarioController() {
        actionToPath.put("estudianteIndex", "/views/Estudiante/index.jsp");
        actionToPath.put("docenteIndex", "/views/Docente/index.jsp");
    }
    
    private String procesarAccion(HttpServletRequest request){
        
        // Obtener la informacion de la ruta 
        Usuario userLogged = (Usuario) SessionManager.getAttribute(request, "Usuario");
        
        String rol = usuario.rolUsuario(userLogged.getId()).getNombre();
        
        String pathInfo = request.getPathInfo();
        String[] segments = null;
        String accion = "";
        
        // Devolver null si hay problema 
        if(pathInfo == null){
            accion = rol.equals("Estudiante") ? "estudianteIndex" : "docenteIndex";
            return actionToPath.get(accion) ;
        }
        
        // Dividir la uri para saber que acción hará
        segments = pathInfo.split("/");
        
        // Validar que existan parametros 
        if(segments.length < 1){
            accion = rol.equals("Estudiante") ? "estudianteIndex" : "docenteIndex";
            return actionToPath.get(accion) ;
        }
        
        // Obtener la accion a realizar
        accion = segments[1];
        
        return actionToPath.get(accion) ;
    }
     
    // METODOS SOBREESCRITOS

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
         // Verificar si el usuario está autenticado (logueado)
        Boolean isLogged = (Boolean) SessionManager.getAttribute(request, "isLogged");

        if (isLogged != null && isLogged) {
            
            // Obtener la información del usuario
        Usuario userLogged = (Usuario) SessionManager.getAttribute(request, "Usuario");
        String rol = usuario.rolUsuario(userLogged.getId()).getNombre();

        if (rol.equals("Profesor")) {
            // Si el usuario es un profesor, se obtienen las materias y establece como atributo en el request
             UsuarioService usuarioService = new UsuarioService();
             
            List<Materia> materias = usuarioService.obtenerMateriasPorDocente(userLogged.getId());
            request.setAttribute("materias", materias);
            
        }
        
        if (rol.equals("Estudiante")) {
            // Si el usuario es un profesor, se obtienen las materias y establece como atributo en el request
             UsuarioService usuarioService = new UsuarioService();
             
            List<UsuarioMateria> materias_usuario = usuarioService.obtenerMateriasPorEstudiante(userLogged.getId());
            request.setAttribute("materias_usuario", materias_usuario);
            
        }
        
            // El usuario está autenticado, muestra la página del panel de control del estudiante
            String redirectPath = procesarAccion(request);
            if (redirectPath != null) {
                RequestDispatcher dispatcher = request.getRequestDispatcher(redirectPath);
                // Redirige a la página JSP
                dispatcher.forward(request, response);
            } 
        } else {
            // El usuario no está autenticado, redirige a la página de inicio de sesión o muestra un mensaje de error
            response.sendRedirect(request.getContextPath() + "/");
        }
        
    }


}
