/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import models.Evaluacion;

/**
 *
 * @author EternoNR
 */
public class EvaluacionDAO extends GenericDAO<Evaluacion> {

    @Override
    protected String getTableName() {
       return "evaluacion"; // Nombre de la tabla de usuarios en la base de datos
    }
    
    @Override
    protected Evaluacion buildEntityFromResultSet(ResultSet resultSet) throws SQLException {
        // Construye y devuelve un objeto Evaluacion a partir de un ResultSet
        int id = resultSet.getInt("id");
        String nombreEvaluacion = resultSet.getString("nombre_evaluacion");
        double porcentajeCalificacion = resultSet.getDouble("porcentajeCalificacion");
        int materiaId = resultSet.getInt("materia_id");

        return new Evaluacion(id, nombreEvaluacion,porcentajeCalificacion, materiaId);
    }
    
    public List<Evaluacion> buscarEvaluacionesMateria(String id_materia){
        return this.findByColumn("materia_id", id_materia);
    }
   
    
    public Evaluacion insertarEvaluacionMateria(String nombreEvaluacion,double porcentajeCalificacion, int materiaId) {
        Evaluacion evaluacion = new Evaluacion(0, nombreEvaluacion,porcentajeCalificacion, materiaId); // El ID se establece en 0, se autogenerará en la base de datos
        this.insert(evaluacion);
        return evaluacion; // Devuelve el objeto Evaluacion con el ID actualizado
    }
    
    public void eliminarEvaluacionMateria(int id) {
        this.delete(id);
    }
     
    public void actualizarNombreEvaluacion(int id, String nuevoNombreEvaluacion,double nuevoPorcentajeCalificacion, int nuevoMateriaId) {
        Evaluacion evaluacionActualizada = new Evaluacion(id, nuevoNombreEvaluacion,nuevoPorcentajeCalificacion, nuevoMateriaId);
        this.update(evaluacionActualizada, "id");
    }
    
    public Evaluacion buscarEvaluacionPorId(int id) {
        return findById(id);
    }

    
}
