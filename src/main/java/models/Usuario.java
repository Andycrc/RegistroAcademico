package models;

public class Usuario {
    
    private int id;
    private String nombre;
    private String apellido;
    private String email;
    private String password;
    private int rol_id;
        
    // CONSTRUCTOR 
    public Usuario() {
    }
    
     public Usuario(String nombre, String apellido, String email, String password, int rol_id) {
        this.nombre = nombre;
        this.apellido = apellido;
        this.email = email;
        this.password = password;
        this.rol_id = rol_id;
    }
    
    
    public Usuario(int id, String nombre, String apellido, String email, String password, int rol_id) {
        this.id = id;
        this.nombre = nombre;
        this.apellido = apellido;
        this.email = email;
        this.password = password;
        this.rol_id = rol_id;
    }
    
    // SETTER 
    public void setId(int id) {
        this.id = id;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setRol_id(int rol_id) {
        this.rol_id = rol_id;
    }

    
    
    // GETTER
    public int getId() {
        return id;
    }

    public String getNombre() {
        return nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public int getRol_id() {
        return rol_id;
    }

    
    
}
