package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import models.CalificacionUsuario;
import models.Evaluacion;
import models.Materia;

public class CalificacionUsuarioDao extends GenericDAO<CalificacionUsuario> {

    @Override
    protected String getTableName() {
        return "calificacionusuario"; // Nombre de la tabla de usuarios en la base de datos
    }
    
    @Override
    protected CalificacionUsuario buildEntityFromResultSet(ResultSet resultSet) throws SQLException {
        
        int id = resultSet.getInt("id");
        int usuarioId = resultSet.getInt("usuario_id");
        int materiaId = resultSet.getInt("materia_id");
        double calificacionMateria = resultSet.getDouble("calificacion");
        String fechaCalificacion = resultSet.getString("fecha_calificacion");
        int id_evaluacion = resultSet.getInt("id_evaluacion");
        
        CalificacionUsuario calificacion = new CalificacionUsuario(id, usuarioId, materiaId, calificacionMateria, fechaCalificacion, id_evaluacion);
        
        return calificacion;
    }
    

    public List<CalificacionUsuario> buscarCalificacionUsuario(String id_evaluacion){
        return this.findByColumn("id_evaluacion", id_evaluacion);
    }
   
     
    public CalificacionUsuario insertarCalificacionUsuario(int usuarioId, int materiaId, double calificacion, String fechaCalificacion, int idEvaluacion) {
        CalificacionUsuario calificacionUsuario = new CalificacionUsuario(); // Crea una instancia de CalificacionUsuario

        // Establece los valores para el nuevo registro de CalificacionUsuario
        calificacionUsuario.setUsuario_id(usuarioId);
        calificacionUsuario.setMateria_id(materiaId);
        calificacionUsuario.setCalificacion(calificacion);
        calificacionUsuario.setFecha_calificacion(fechaCalificacion);
        calificacionUsuario.setId_evaluacion(idEvaluacion);

        // Inserta el registro de CalificacionUsuario en la base de datos
        this.insert(calificacionUsuario);

        return calificacionUsuario; // Devuelve el objeto CalificacionUsuario con el ID actualizado
    }
    
    public List<Object[]> obtenerDatosCalificacionesPorMateria(int idMateria) {
        List<Object[]> resultados = new ArrayList<>();

        try (Connection connection = getConnection();
                          PreparedStatement statement = connection.prepareStatement(
                     "SELECT cu.id AS calificacion_id, e.nombre_evaluacion, m.nombre_materia, "
                             + "u.id AS id_usuario, u.nombre AS nombre_usuario, u.apellido AS apellido_usuario, "
                             + "cu.calificacion, e.porcentajeCalificacion, cu.fecha_calificacion "
                             + "FROM calificacionusuario cu "
                             + "JOIN evaluacion e ON cu.id_evaluacion = e.id "
                             + "JOIN usuario u ON cu.usuario_id = u.id "
                             + "JOIN materia m ON cu.materia_id = m.id "
                             + "WHERE cu.materia_id = ?")) {

            statement.setInt(1, idMateria);

            try (ResultSet resultSet = statement.executeQuery()) {
                Map<String, List<Object[]>> resultMap = new HashMap<>();

                while (resultSet.next()) {
                    String nombreEvaluacion = resultSet.getString("nombre_evaluacion");
                    String key = nombreEvaluacion + "_" + resultSet.getInt("id_usuario");

                    if (!resultMap.containsKey(key)) {
                        resultMap.put(key, new ArrayList<>());
                    }

                    Object[] fila = new Object[]{
                            resultSet.getInt("calificacion_id"),
                            resultSet.getString("nombre_evaluacion"),
                            resultSet.getString("nombre_materia"),
                            resultSet.getInt("id_usuario"),
                            resultSet.getString("nombre_usuario"),
                            resultSet.getString("apellido_usuario"),
                            resultSet.getDouble("calificacion"),
                            resultSet.getDouble("porcentajeCalificacion"),
                            resultSet.getString("fecha_calificacion")
                    };

                    resultMap.get(key).add(fila);
                }

                // Convertir el mapa a una lista plana
                for (List<Object[]> lista : resultMap.values()) {
                    resultados.addAll(lista);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return resultados;

    }
public List<Object[]> obtenerDatosCalificacionesFiltradasPorMateriaYFecha(int idMateria, String fechaFiltro) {
        List<Object[]> resultados = new ArrayList<>();

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "SELECT cu.id AS calificacion_id, e.nombre_evaluacion, m.nombre_materia, "
                             + "u.id AS id_usuario, u.nombre AS nombre_usuario, u.apellido AS apellido_usuario, "
                             + "cu.calificacion, e.porcentajeCalificacion, cu.fecha_calificacion "
                             + "FROM calificacionusuario cu "
                             + "JOIN evaluacion e ON cu.id_evaluacion = e.id "
                             + "JOIN usuario u ON cu.usuario_id = u.id "
                             + "JOIN materia m ON cu.materia_id = m.id "
                             + "WHERE cu.materia_id = ? AND cu.fecha_calificacion = ?")) {

            statement.setInt(1, idMateria);
            statement.setString(2, fechaFiltro);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Object[] fila = new Object[]{
                            resultSet.getInt("calificacion_id"),
                            resultSet.getString("nombre_evaluacion"),
                            resultSet.getString("nombre_materia"),
                            resultSet.getInt("id_usuario"),
                            resultSet.getString("nombre_usuario"),
                            resultSet.getString("apellido_usuario"),
                            resultSet.getDouble("calificacion"),
                            resultSet.getDouble("porcentajeCalificacion"),
                            resultSet.getString("fecha_calificacion")
                    };

                    resultados.add(fila);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return resultados;
    } 
    
    public CalificacionUsuario buscarCalificacionUsuarioPorUsuarioYEvaluacion(int idUsuario, int idEvaluacion) {
        CalificacionUsuario calificacion = null;

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "SELECT * FROM calificacionusuario WHERE usuario_id = ? AND id_evaluacion = ?")) {

            statement.setInt(1, idUsuario);
            statement.setInt(2, idEvaluacion);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    int id = resultSet.getInt("id");
                    int usuarioId = resultSet.getInt("usuario_id");
                    int materiaId = resultSet.getInt("materia_id");
                    double calificacionMateria = resultSet.getDouble("calificacion");
                    String fechaCalificacion = resultSet.getString("fecha_calificacion");
                    int id_evaluacion = resultSet.getInt("id_evaluacion");

                    calificacion = new CalificacionUsuario(id, usuarioId, materiaId, calificacionMateria, fechaCalificacion, id_evaluacion);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return calificacion;
    }
    
    public void actualizarCalificacionUsuario(int usuarioId, int idEvaluacion, double nuevaCalificacion, String nuevaFechaCalificacion) {
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "UPDATE calificacionusuario SET calificacion = ?, fecha_calificacion = ? " +
                             "WHERE usuario_id = ? AND id_evaluacion = ?")) {

            statement.setDouble(1, nuevaCalificacion);
            statement.setString(2, nuevaFechaCalificacion);
            statement.setInt(3, usuarioId);
            statement.setInt(4, idEvaluacion);

            int filasActualizadas = statement.executeUpdate();

            if (filasActualizadas == 0) {
                // No se encontró ninguna fila que coincida con los parámetros proporcionados
                // Puedes manejar esto de acuerdo a tus requisitos, por ejemplo, lanzar una excepción
                // o imprimir un mensaje de advertencia.
                System.out.println("No se encontró ninguna CalificacionUsuario para actualizar.");
            } else {
                System.out.println("CalificacionUsuario actualizada con éxito.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            // Puedes manejar la excepción de acuerdo a tus requisitos
        }
    }
    
    public List<CalificacionUsuario> obtenerCalificacionesPorMateriaYEstudiante(int materiaId, String estudianteId) {
        return this.findByColums("materia_id", materiaId + "" , "usuario_id" , estudianteId);
    }
}
