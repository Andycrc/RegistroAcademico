package utils;

import javax.servlet.http.HttpServletRequest;

public class ProjectConstants {
    
    public static final String rutaBase = "/RegistroAcademico/";
    
    public static final boolean isUserLogged(HttpServletRequest request_){
        return (Boolean) SessionManager.getAttribute(request_, "isLogged");
    }
    
    public static final void closeActiveSession(HttpServletRequest request_){
       SessionManager.invalidateSession(request_);
    }
    
}
