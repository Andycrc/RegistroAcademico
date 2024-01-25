
package services;

import dao.CalificacionUsuarioDao;
import java.util.List;
import models.CalificacionUsuario;


public class CalificacionService {
    private final CalificacionUsuarioDao CalificacionUsuarioDao = new CalificacionUsuarioDao();
        
    public List<CalificacionUsuario> buscarCalificacionUsuario(String id_evaluacion) {
        
        return CalificacionUsuarioDao.buscarCalificacionUsuario(id_evaluacion);
    }
    
    public CalificacionUsuario insertarCalificacionUsuario(int usuarioId, int materiaId, double calificacion, String fechaCalificacion, int idEvaluacion) {
        return CalificacionUsuarioDao.insertarCalificacionUsuario(usuarioId, materiaId, calificacion, fechaCalificacion, idEvaluacion);
    }
    public List<Object[]> obtenerDatosCalificacionesPorMateria(int idMateria) {
        return CalificacionUsuarioDao.obtenerDatosCalificacionesPorMateria(idMateria);
    }
    public CalificacionUsuario buscarCalificacionUsuarioPorUsuarioYEvaluacion(int idUsuario, int idEvaluacion) {
        return CalificacionUsuarioDao.buscarCalificacionUsuarioPorUsuarioYEvaluacion(idUsuario, idEvaluacion);
    }
    public void actualizarCalificacionUsuario(int usuarioId, int idEvaluacion, double nuevaCalificacion, String nuevaFechaCalificacion) {
        CalificacionUsuarioDao.actualizarCalificacionUsuario(usuarioId, idEvaluacion, nuevaCalificacion, nuevaFechaCalificacion);
    }
    public List<Object[]> obtenerDatosCalificacionesFiltradasPorMateriaYFecha(int idMateria, String fechaFiltro) {
    return CalificacionUsuarioDao.obtenerDatosCalificacionesFiltradasPorMateriaYFecha(idMateria, fechaFiltro);
}

}
