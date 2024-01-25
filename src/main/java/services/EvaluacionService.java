package services;

import dao.EvaluacionDAO;
import java.util.List;
import models.Evaluacion;

public class EvaluacionService {
    
    private final EvaluacionDAO evaluacionDAO = new EvaluacionDAO();
    
    public List<Evaluacion> buscarEvaluacionesMateria(String id_materia){
        return this.evaluacionDAO.buscarEvaluacionesMateria(id_materia);
    }
    public Evaluacion insertarEvaluacionMateria(String nombreEvaluacion,double porcentajeCalificacion, int materiaId) {
        // Llama al método correspondiente en el DAO
        return this.evaluacionDAO.insertarEvaluacionMateria(nombreEvaluacion,porcentajeCalificacion, materiaId);
    }
    public void eliminarEvaluacionMateria(int id) {
        // Llama al método correspondiente en el DAO
        this.evaluacionDAO.eliminarEvaluacionMateria(id);
    }
    
    public void actualizarNombreEvaluacion(int id, String nuevoNombreEvaluacion,double nuevoPorcentajeCalificacion, int nuevoMateriaId) {
        // Llama al método correspondiente en el DAO
        this.evaluacionDAO.actualizarNombreEvaluacion(id, nuevoNombreEvaluacion,nuevoPorcentajeCalificacion, nuevoMateriaId);
    }
    
    public Evaluacion buscarEvaluacionPorId(int id) {
        // Llama al nuevo método en el DAO
        return this.evaluacionDAO.buscarEvaluacionPorId(id);
    }

}
