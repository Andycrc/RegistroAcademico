package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.Materia;
import models.Usuario;
import models.UsuarioMateria;

public class UsuarioDAO extends GenericDAO<Usuario> {

    @Override
    protected String getTableName() {
        return "usuario"; // Nombre de la tabla de usuarios en la base de datos
    }

    @Override
    protected Usuario buildEntityFromResultSet(ResultSet resultSet) throws SQLException {
        
        int id          =   resultSet.getInt("id");
        String nombre   =   resultSet.getString("nombre");
        String apellido =   resultSet.getString("apellido");
        String email    =   resultSet.getString("email");
        String password =   resultSet.getString("password");
        int rol_id      =   resultSet.getInt("rol_id");
        
        Usuario usuario = new Usuario();
        usuario.setId(id);
        usuario.setNombre(nombre);
        usuario.setApellido(apellido);
        usuario.setEmail(email);
        usuario.setPassword(password);
        usuario.setRol_id(rol_id);
        
        
        return usuario;
    }
    
    public Usuario findUserByEmail(String email) {
        List<Usuario> usuarios = findByColumn("email", email);

        if (!usuarios.isEmpty()) {
            return usuarios.get(0); // Devuelve el primer usuario encontrado
        } else {
            return null; // No se encontró ningún usuario con ese correo electrónico
        }
    }
    
    public Usuario LoginUser(String email_ , String password_){
        return login(email_, password_);
    }
    
    public int registerUser(Usuario user_){
        int resultado = 0;
        try{
            insert(user_);
            System.out.println("Registrado existosamente");
            resultado = 1;
        }catch(Exception e){
            resultado = 0;
            System.out.println(e.getMessage());
        }
        
        return resultado;
    }
    
    
    
    public List<UsuarioMateria> obtenerMateriasPorEstudiante(int IdEstudiante) {
        List<UsuarioMateria> usuariomateria = new ArrayList<>();

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "SELECT m.id AS idMateria, m.nombre_materia AS nombreMateria, u.nombre AS nombreDocente, um.fecha_inscripcion AS fechaInscripcion FROM usuariomateria um " +
                        "JOIN materia m on um.materia_id = m.id JOIN usuario u on m.idDocente = u.id " +
                      "WHERE um.usuario_id = ?")) {

            statement.setInt(1, IdEstudiante);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    
                    UsuarioMateria materia = new UsuarioMateria();
                    
                    materia.setIdMateria(resultSet.getInt("idMateria"));
                    materia.setNombreMateria(resultSet.getString("nombreMateria"));
                    materia.setNombreDocente(resultSet.getString("nombreDocente"));
                    materia.setFechaInscripcion(resultSet.getDate("fechaInscripcion"));
                  
                    
                    usuariomateria.add(materia);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return usuariomateria;
    }
    
    
    
    public void actualizarUsuario(Usuario usuario) {
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = getConnection();
            String updateQuery = "UPDATE usuario SET nombre = ?, apellido = ?, email = ?, password = ? WHERE id = ?";
            statement = connection.prepareStatement(updateQuery);
            statement.setString(1, usuario.getNombre());
            statement.setString(2, usuario.getApellido());
            statement.setString(3, usuario.getEmail());
            statement.setString(4, usuario.getPassword());
            statement.setInt(5, usuario.getId());

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(connection);
        }
    }
    
    public List<Usuario> getUsuariosByMateriaId(int materiaId) {
    List<Usuario> usuarios = new ArrayList<>();

    try (Connection connection = getConnection();
         PreparedStatement statement = connection.prepareStatement(
                 "SELECT u.id, u.nombre, u.apellido " +
                 "FROM usuario u " +
                 "JOIN usuariomateria um ON u.id = um.usuario_id " +
                 "WHERE um.materia_id = ?")) {

            statement.setInt(1, materiaId);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    int idUsuario = resultSet.getInt("id");
                    String nombre = resultSet.getString("nombre");
                    String apellido = resultSet.getString("apellido");

                    Usuario usuario = new Usuario();
                    usuario.setId(idUsuario);
                    usuario.setNombre(nombre);
                    usuario.setApellido(apellido);

                    usuarios.add(usuario);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return usuarios;
    }



}
