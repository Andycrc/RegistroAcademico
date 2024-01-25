package dao;

import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public abstract class GenericDAO<T> extends BaseDAO {

    protected abstract String getTableName();

    protected T buildEntityFromResultSet(ResultSet resultSet) throws SQLException {
        return null;
    }

    public void insert(T entity) {
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = getConnection();
            String tableName = getTableName();
            String insertQuery = "INSERT INTO " + tableName + " (";

            Field[] fields = entity.getClass().getDeclaredFields();
            for (int i = 0; i < fields.length; i++) {
                insertQuery += fields[i].getName();
                if (i < fields.length - 1) {
                    insertQuery += ", ";
                }
            }

            insertQuery += ") VALUES (";

            // Añadimos un marcador de posición para cada columna
            for (int i = 0; i < fields.length; i++) {
                insertQuery += "?";
                if (i < fields.length - 1) {
                    insertQuery += ", ";
                }
            }

            insertQuery += ")";

            statement = connection.prepareStatement(insertQuery);

            // A continuación, establecemos los valores de los campos de la entidad en la
            // declaración preparada
            for (int i = 0; i < fields.length; i++) {
                Field field = fields[i];
                field.setAccessible(true);
                Object value = field.get(entity);
                statement.setObject(i + 1, value); // Los índices comienzan en 1
            }

            statement.executeUpdate();
        } catch (SQLException | IllegalAccessException e) {
            e.printStackTrace();
        } finally {
            closeResources(connection);
        }
    }

    public T findById(int id) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        T entity = null;

        try {
            connection = getConnection();
            String tableName = getTableName();
            String selectQuery = "SELECT * FROM " + tableName + " WHERE id = ?";
            statement = connection.prepareStatement(selectQuery);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                entity = buildEntityFromResultSet(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(connection);
        }

        return entity;
    }

    public void update(T entity, String whereField) {
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = getConnection();
            String tableName = getTableName();
            StringBuilder updateQuery = new StringBuilder("UPDATE " + tableName + " SET ");

            Field[] fields = entity.getClass().getDeclaredFields();
            for (Field field : fields) {
                field.setAccessible(true);
                String fieldName = field.getName();

                // Evita actualizar el campo utilizado en la condición WHERE
                if (!fieldName.equals(whereField)) {
                    updateQuery.append(fieldName).append(" = ?, ");
                }
            }

            // Elimina la última coma y espacio
            updateQuery.setLength(updateQuery.length() - 2);

            updateQuery.append(" WHERE ").append(whereField).append(" = ?");

            statement = connection.prepareStatement(updateQuery.toString());

            // Configura los valores de los campos en la cláusula SET
            int parameterIndex = 1;
            for (Field field : fields) {
                field.setAccessible(true);
                String fieldName = field.getName();

                // Evita actualizar el campo utilizado en la condición WHERE
                if (!fieldName.equals(whereField)) {
                    Object value = field.get(entity);
                    statement.setObject(parameterIndex, value);
                    parameterIndex++;
                }
            }

            // Configura el valor del campo de la condición WHERE
            Field whereFieldObject = entity.getClass().getDeclaredField(whereField);
            whereFieldObject.setAccessible(true);
            Object whereValue = whereFieldObject.get(entity);
            statement.setObject(parameterIndex, whereValue);

            statement.executeUpdate();
        } catch (SQLException | IllegalAccessException | NoSuchFieldException e) {
            e.printStackTrace();
        } finally {
            closeResources(connection);
        }
    }

    public void delete(int id) {
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = getConnection();
            String tableName = getTableName();
            String deleteQuery = "DELETE FROM " + tableName + " WHERE id = ?";
            statement = connection.prepareStatement(deleteQuery);
            statement.setInt(1, id);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(connection);
        }
    }

    public List<T> findAll() {
        List<T> entities = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = getConnection();
            String tableName = getTableName();
            String selectQuery = "SELECT * FROM " + tableName;
            statement = connection.prepareStatement(selectQuery);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                T entity = buildEntityFromResultSet(resultSet);
                entities.add(entity);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(connection);
        }

        return entities;
    }

    public List<T> findByColumn(String columnName, String value) {
        List<T> entities = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = getConnection();
            String tableName = getTableName();
            String selectQuery = "SELECT * FROM " + tableName + " WHERE " + columnName + " = ?";
            statement = connection.prepareStatement(selectQuery);
            statement.setString(1, value);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                T entity = buildEntityFromResultSet(resultSet);
                entities.add(entity);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(connection);
        }

        return entities;
    }

    public T login(String email_, String password_) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        T entity = null;

        try {
            connection = getConnection();
            String tableName = getTableName();
            String loginQuery = "SELECT id,nombre,apellido, email, rol_id , password FROM " + tableName
                    + " WHERE email = ? AND password = ?";
            statement = connection.prepareStatement(loginQuery);
            statement.setString(1, email_);
            statement.setString(2, password_);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                entity = buildEntityFromResultSet(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(connection);
        }

        return entity;
    }
    
    public List<T> findByColums(String columName_, String value_ , String columName__ , String value__){
        List<T> entities = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = getConnection();
            String tableName = getTableName();
            String selectQuery = "SELECT * FROM " + tableName + " WHERE " + columName_ + " = ? AND " + columName__  + " = ?" ;
            statement = connection.prepareStatement(selectQuery);
            statement.setString(1, value_);
            statement.setString(2, value__);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                T entity = buildEntityFromResultSet(resultSet);
                entities.add(entity);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(connection);
        }

        return entities;
    }
}
