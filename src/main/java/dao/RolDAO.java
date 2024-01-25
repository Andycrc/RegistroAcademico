package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import models.Rol;


public class RolDAO extends GenericDAO<Rol> {
    
    @Override
    protected String getTableName() {
        return "rol"; // Nombre de la tabla de usuarios en la base de datos
    }

    @Override
    protected Rol buildEntityFromResultSet(ResultSet resultSet) throws SQLException {
        
        int id          =   resultSet.getInt("id");
        String nombre   =   resultSet.getString("nombre");

        Rol rol = new Rol(id , nombre);
        
        return rol;
    }
    
}
