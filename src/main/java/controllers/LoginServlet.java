package controllers;

import java.io.IOException;
import java.time.LocalDate;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.HistorialAcceso;
import models.Usuario;
import services.UsuarioService;
import utils.PasswordEncryptor;
import utils.ProjectConstants;
import utils.SessionManager;

public class LoginServlet extends HttpServlet {

    public final UsuarioService usuario = new UsuarioService();
    
        @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try{
            
            // Verificar si el usuario está autenticado (logueado)
            Boolean isLogged = ProjectConstants.isUserLogged(request);

            if (isLogged != null && isLogged) {
                response.sendRedirect(request.getContextPath() + "/Usuario");
            } else {
                // El usuario no está autenticado, redirige a la página de inicio de sesión o muestra un mensaje de error
                response.sendRedirect(request.getContextPath() + "/");
            }
            
        }catch(Exception error){
            response.sendRedirect(request.getContextPath() + "/");
        }
        
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            
  
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            if (email.isEmpty() || password.isEmpty()) {
               request.setAttribute("mensajeError", "Credenciales incorrectas");
               
               // Realiza el reenvío después de configurar los atributos en la solicitud
                RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
                dispatcher.forward(request, response);
               
            } else {
                
                String passwordEncriptada = PasswordEncryptor.encryptPassword(password);
                
                if (validateSession(email, passwordEncriptada)) {
                    
                    System.out.println("Password encriptada: " + passwordEncriptada);
                    
                    Usuario usuarioLogin = usuario.loginUser(email, passwordEncriptada);
                    SessionManager.setAttribute(request, "Usuario", usuarioLogin);
                    SessionManager.setAttribute(request, "isLogged", true);
                    
                    LocalDate fechaActual = LocalDate.now();
                    
                    
                    HistorialAcceso historial = new HistorialAcceso(usuarioLogin.getId()  + "",fechaActual.toString(), usuarioLogin.getRol_id() + "");
                    
                    usuario.insertarHistorial(historial);
                    
                    response.sendRedirect(request.getContextPath() + "/Usuario");
             
                } else {
                    request.setAttribute("mensajeError", "Credenciales incorrectas");

                    // Realiza el reenvío a la página de inicio
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
                    dispatcher.forward(request, response);
                }
                
            }
                           
        } catch (Exception error) {
            System.out.println("Error: " + error.getMessage());
        }
       
        
    }
    
    public boolean validateSession(String email_, String password_){
        Usuario usuarioLogin = usuario.loginUser(email_, password_);
        return usuarioLogin != null;
    }
}
