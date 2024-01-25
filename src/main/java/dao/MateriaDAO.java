package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.Materia;
import models.UsuarioMateria;

public class MateriaDAO extends GenericDAO<Materia>{
    
    @Override
    protected String getTableName() {
        return "materia"; // Nombre de la tabla de usuarios en la base de datos
    }
    
    @Override
    protected Materia buildEntityFromResultSet(ResultSet resultSet) throws SQLException {
        
        int id                  =   resultSet.getInt("id");
        String nombre           =   resultSet.getString("nombre_materia");
        String codigo_acceso    =   resultSet.getString("codigo_acceso");
        String descripcion    =   resultSet.getString("descripcion");
        int IdDocente = resultSet.getInt("idDocente");
        
        Materia materia = new Materia(id, nombre , codigo_acceso , descripcion, IdDocente);
        
        return materia;
    }
    
    
    public List<Materia> obtenerMateriasPorDocente(int IdDocente) {
        List<Materia> materias = new ArrayList<>();

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "SELECT * FROM materia WHERE idDocente = ?")) {

            statement.setInt(1, IdDocente);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Materia materia = new Materia();
                    materia.setId(resultSet.getInt("id"));
                    materia.setNombre_materia(resultSet.getString("nombre_materia"));
                    materia.setCodigo_acceso(resultSet.getString("codigo_acceso"));
                    materia.setDescripcion(resultSet.getString("descripcion"));
                    materia.setIdDocente(resultSet.getInt("idDocente"));
                    
                    materias.add(materia);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return materias;
    }
    
    
    public void IngresarMateria(Materia materia) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();

            String query = "INSERT INTO materia (nombre_materia, codigo_acceso, descripcion, idDocente) " +
                           "VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(query);
            
            stmt.setString(1, materia.getNombre_materia());
            stmt.setString(2, materia.getCodigo_acceso());
            stmt.setString(3, materia.getDescripcion());
            stmt.setInt(4, materia.getIdDocente());

            stmt.executeUpdate();
        } finally {
            closeConnection(conn);
        }
    }
    
    
    public void editarMateria(Materia materia) throws SQLException {
    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        conn = getConnection();

        String query = "UPDATE materia SET nombre_materia = ?, codigo_acceso = ?, descripcion = ?" +
                       "WHERE id = ?";
        stmt = conn.prepareStatement(query);

        stmt.setString(1, materia.getNombre_materia());
        stmt.setString(2, materia.getCodigo_acceso());
        stmt.setString(3, materia.getDescripcion());
        stmt.setInt(4, materia.getId());

        stmt.executeUpdate();
    } finally {
        closeConnection(conn);
    }
}

    
    
    
    public void eliminarMateria(int materiaId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();

            String query = "DELETE FROM materia WHERE id = ?";
            stmt = conn.prepareStatement(query);

            stmt.setInt(1, materiaId);

            stmt.executeUpdate();
        } finally {
            closeConnection(conn);
        }
    }
    
    
    
        public Materia getMateriaPorCodigo(String codigoAcceso) {
        Materia materia = null;

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "SELECT * FROM materia WHERE codigo_acceso = ?")) {

            statement.setString(1, codigoAcceso);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    materia = buildEntityFromResultSet(resultSet);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return materia;
    }

        
        
    public void agregarUsuarioMateria(UsuarioMateria usuariomateria) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();

            String query = "INSERT INTO usuariomateria (usuario_id, materia_id, fecha_inscripcion) " +
                           "VALUES (?, ?, ?)";
            stmt = conn.prepareStatement(query);
            
            stmt.setInt(1, usuariomateria.getUsuario_id());
            stmt.setInt(2, usuariomateria.getMateria_id());
            stmt.setDate(3, usuariomateria.getFechaInscripcion());

            stmt.executeUpdate();
        } finally {
            closeConnection(conn);
        }
    }
    
    
    
        public boolean estudianteUnidoAMateria(int usuarioId, int materiaId) {
        boolean yaUnido = false;

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "SELECT * FROM usuariomateria WHERE usuario_id = ? AND materia_id = ?")) {

            statement.setInt(1, usuarioId);
            statement.setInt(2, materiaId);

            try (ResultSet resultSet = statement.executeQuery()) {
                yaUnido = resultSet.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return yaUnido;
    }
        
        
        
        
        public List<Materia> obtenerMateriasPorNombre(String nombre) throws SQLException {
       List<Materia> materias = new ArrayList<>();
       Connection conn = null;
       PreparedStatement stmt = null;
       ResultSet rs = null;

       try {
           conn = getConnection();
           String query = "SELECT m.id,  m.nombre_materia AS nombreMateria, m.descripcion AS materiaDescripcion, u.nombre AS nombreDocente "
                          + "FROM materia m JOIN usuario u on m.idDocente = u.id " +
                            "where m.nombre_materia LIKE ?";
           stmt = conn.prepareStatement(query);
           stmt.setString(1, "%"+nombre+"%");
           rs = stmt.executeQuery();

           while (rs.next()) {
               Materia materia = new Materia();
               materia.setId(rs.getInt("id"));             
               materia.setNombre_materia(rs.getString("nombreMateria"));
               materia.setDescripcion(rs.getString("materiaDescripcion"));
               materia.setNombreDocente(rs.getString("nombreDocente"));

               materias.add(materia);
           }
       } finally {
           closeConnection(conn);
       }

       return materias;
    }

    public boolean existeCodigoAcceso(String codigoAcceso) {
        boolean existe = false;

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "SELECT COUNT(*) FROM materia WHERE codigo_acceso = ?")) {

            statement.setString(1, codigoAcceso);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    int count = resultSet.getInt(1);
                    existe = count > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return existe;
    }

    
    
  

   
    
}
