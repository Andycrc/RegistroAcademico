package utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class SessionManager {
 
    public static HttpSession getSession(HttpServletRequest request_){
        return request_.getSession(true);
    }
    
    // Método para establecer un atributo en la sesión
    public static void setAttribute(HttpServletRequest request, String attributeName, Object attributeValue) {
        HttpSession session = getSession(request);
        session.setAttribute(attributeName, attributeValue);
    }

    // Método para obtener un atributo de la sesión
    public static Object getAttribute(HttpServletRequest request, String attributeName) {
        HttpSession session = getSession(request);
        return session.getAttribute(attributeName);
    }

    // Método para invalidar la sesión
    public static void invalidateSession(HttpServletRequest request) {
        HttpSession session = getSession(request);
        session.invalidate();
    }
    
    
}
