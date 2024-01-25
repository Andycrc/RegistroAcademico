package services;

import dao.EvaluacionDAO;
import dao.HistorialAccesoDAO;
import dao.MateriaDAO;
import dao.RolDAO;
import dao.UsuarioDAO;
import java.util.List;
import models.HistorialAcceso;
import models.Materia;
import models.Rol;
import models.Usuario;
import models.UsuarioMateria;

public class UsuarioService {

    private final UsuarioDAO usuarioDAO = new UsuarioDAO();
    private final RolDAO rolDAO = new RolDAO();
    private final MateriaDAO materiaDAO = new MateriaDAO(); 
    private final EvaluacionDAO evaluacionDAO = new EvaluacionDAO();
    private final HistorialAccesoDAO historialDao = new HistorialAccesoDAO();
    
    
    public List<Usuario> buscarCalificacionUsuario() {
        return usuarioDAO.findAll();
    }
    
    public Usuario findUserByEmail(String email) {
        return usuarioDAO.findUserByEmail(email);
    }
    
    public Usuario loginUser(String email_ , String password_){
        return usuarioDAO.LoginUser(email_, password_);
    }
    
    public Rol rolUsuario(int idUsuario_){
        Usuario usuario = usuarioDAO.findById(idUsuario_);
        return rolDAO.findById(usuario.getRol_id());
    }
    
    public List<Materia> obtenerMateriasPorDocente(int IdDocente) {
        return materiaDAO.obtenerMateriasPorDocente(IdDocente);
    }
    
    public int RegisterUser(Usuario user_){
        return usuarioDAO.registerUser(user_);
    }
    
    public List<Rol> listarRoles(){
        return rolDAO.findAll();
    }
    
    
    public List<UsuarioMateria> obtenerMateriasPorEstudiante(int IdEstudiante) {
        return usuarioDAO.obtenerMateriasPorEstudiante(IdEstudiante);
    }
    
     public void actualizarUsuario(Usuario usuario) {
        usuarioDAO.actualizarUsuario(usuario);
     }

    public List<Usuario> getUsuariosByMateriaId(int materiaId) {
        return usuarioDAO.getUsuariosByMateriaId(materiaId);
    }
    
    public void insertarHistorial(HistorialAcceso historial){
        historialDao.InsertarHistorial(historial);
    }
}
