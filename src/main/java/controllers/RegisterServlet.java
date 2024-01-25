
package controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.Rol;
import models.Usuario;
import services.UsuarioService;
import utils.PasswordEncryptor;

@WebServlet(name = "RegisterServlet", urlPatterns = { "/Register" })
public class RegisterServlet extends HttpServlet {

    public final UsuarioService usuario = new UsuarioService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Rol> roles = usuario.listarRoles();
        
        request.setAttribute("roles", roles);
        
        // Realizar el forward a registro.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("registro.jsp");
        dispatcher.forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            int rolId = Integer.parseInt(request.getParameter("rol"));

            if (email.isEmpty() || password.isEmpty()) {
                request.setAttribute("mensajeError", "Datos incorrectas");

                // Realiza el reenvío después de configurar los atributos en la solicitud
                RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
                dispatcher.forward(request, response);

            } else {

                if (validateSession(email, password)) {
                    request.setAttribute("mensajeError", "Datos incorrectas");

                    // Realiza el reenvío a la página de inicio
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/registro.jsp");
                    dispatcher.forward(request, response);

                } else {

                    // Registrar al estudiante
                    String passwordEncriptada = PasswordEncryptor.encryptPassword(password);
                    
                    // Construir usuario para registrar
                    Usuario usuario = new Usuario(nombre , apellido, email, passwordEncriptada, rolId);
                    
                    int resultado = this.usuario.RegisterUser(usuario);
                    
                    if(resultado == 0){
                        request.setAttribute("mensajeError", "Datos incorrectas");

                        // Realiza el reenvío a la página de inicio
                        RequestDispatcher dispatcher = request.getRequestDispatcher("/registro.jsp");
                        dispatcher.forward(request, response);
                    }
                    
                    if(resultado == 1){
                        request.setAttribute("successfulMessage", "Registrado correctamente.Inicia sesion");

                        // Realiza el reenvío a la página de inicio
                        RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
                        dispatcher.forward(request, response);
                    }
                }

            }

        } catch (Exception error) {
            System.out.println("Error: " + error.getMessage());
        }
    }

    public boolean validateSession(String email_, String password_) {
        Usuario usuarioLogin = usuario.loginUser(email_, password_);
        return usuarioLogin != null;
    }

}
