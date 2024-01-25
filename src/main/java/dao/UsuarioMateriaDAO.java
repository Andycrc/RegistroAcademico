package dao;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import models.UsuarioMateria;

public class UsuarioMateriaDAO extends GenericDAO<UsuarioMateria> {
    
    @Override
    protected String getTableName() {
        return "usuariomateria"; // Nombre de la tabla de usuarios en la base de datos
    }
    
     @Override
    protected UsuarioMateria buildEntityFromResultSet(ResultSet resultSet) throws SQLException {
        
        int id          = resultSet.getInt("id");
        int usuario_id  = resultSet.getInt("usuario_id");
        int materia_id  = resultSet.getInt("materia_id");
        Date fecha_inscripcion = resultSet.getDate("fecha_inscripcion");
        
        UsuarioMateria usuario = new UsuarioMateria(id , usuario_id , materia_id, fecha_inscripcion);
      
        
        return usuario;
    }
    
    
    
   
}
