package ViewModel;

import models.Rol;
import models.Usuario;

public class UsuarioViewModel {
    
    private Usuario usuario;
    private Rol role;
    
    public UsuarioViewModel(){
        
    }

    public UsuarioViewModel(Usuario usuario, Rol role) {
        this.usuario = usuario;
        this.role = role;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public Rol getRole() {
        return role;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public void setRole(Rol role) {
        this.role = role;
    }
    
    
    
    
}
