/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.Usuario;
import services.UsuarioService;
import utils.PasswordEncryptor;

/**
 *
 * @author bryanmejia
 */
public class PerfilController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        try {
            if (accion != null) {
                switch (accion) {
                    case "editarPerfil":
                        editarPerfil(request, response);
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

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    
    
    private void editarPerfil(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession(false);

   
    if (session != null && session.getAttribute("Usuario") != null) {
        Usuario usuario = (Usuario) session.getAttribute("Usuario");

        
        String nuevaPassword = request.getParameter("nuevoPassword");


        
        if (nuevaPassword != null && !nuevaPassword.isEmpty()) {
         String hashedPassword = PasswordEncryptor.encryptPassword(nuevaPassword);
         System.out.println("Nueva contraseña encriptada: " + hashedPassword);
         usuario.setPassword(hashedPassword);
        }

        usuario.setNombre(request.getParameter("nombre"));
        usuario.setApellido(request.getParameter("apellido"));
        usuario.setEmail(request.getParameter("email"));

        UsuarioService service = new UsuarioService();

        try {
            service.actualizarUsuario(usuario);

           
            session.setAttribute("Usuario", usuario);
           
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Perfil actualizado correctamente.");
                       
                
        } catch (Exception e) {
            e.printStackTrace();
            
             response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Hubo un problema al actualizar el usuario, intenta de nuevo");
        }
    }

}


    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
