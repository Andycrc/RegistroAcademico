package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import models.HistorialAcceso;
import models.Materia;


public class HistorialAccesoDAO extends GenericDAO<HistorialAcceso>{
    
     @Override
    protected String getTableName() {
        return "historialacceso"; // Nombre de la tabla de usuarios en la base de datos
    }
    
    @Override
    protected HistorialAcceso buildEntityFromResultSet(ResultSet resultSet) throws SQLException {
        
        int id                  =   resultSet.getInt("id");
        int usuario_id          =   resultSet.getInt("usuario_id");
        String fecha            =   resultSet.getString("fecha_acceso");
        String tipo_acceso      =   resultSet.getString("tipo_acceso");
        
        HistorialAcceso historial = new HistorialAcceso(id, usuario_id + "", fecha , tipo_acceso);
        
        return historial;
    }
    
    
    public void InsertarHistorial(HistorialAcceso historial){
        this.insert(historial);
    }
    
}
