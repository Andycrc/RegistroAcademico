package services;

import dao.RolDAO;
import java.util.List;
import models.Rol;

public class RolService {

    private final RolDAO rolDAO = new RolDAO();
  
    public List<Rol> listarRoles() {
        return rolDAO.findAll();
    }
    
    public void crearRol(Rol rol) {
        rolDAO.insert(rol);
    }

    public Rol obtenerRolPorId(int id) {
        return rolDAO.findById(id);
    }

    public void actualizarRol(Rol rol) {
        rolDAO.update(rol, "id");
    }

    public void eliminarRol(int id) {
        rolDAO.delete(id);
    }
}
