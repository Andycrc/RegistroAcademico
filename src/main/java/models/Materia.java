package models;

public class Materia {
    
    private int id;
    private String nombre_materia;
    private String codigo_acceso;
    private String descripcion;
    private int idDocente;
    
    private String nombreDocente;
   
    // constructor
    public Materia() {
    }

    public Materia(int id, String nombre_materia, String codigo_acceso, String descripcion, int idDocente) {
        this.id = id;
        this.nombre_materia = nombre_materia;
        this.codigo_acceso = codigo_acceso;
        this.descripcion = descripcion;
        this.idDocente = idDocente;
    }
    
    // SETTER 
    public void setId(int id) {
        this.id = id;
    }

    public void setNombre_materia(String nombre_materia) {
        this.nombre_materia = nombre_materia;
    }

    public void setCodigo_acceso(String codigo_acceso) {
        this.codigo_acceso = codigo_acceso;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

   
    public void setIdDocente(int idDocente) {
        this.idDocente = idDocente;
    }

    

    public void setNombreDocente(String nombreDocente) {
        this.nombreDocente = nombreDocente;
    }
    
    
    
    
    // GETTER 

    public int getId() {
        return id;
    }

    public String getNombre_materia() {
        return nombre_materia;
    }

    public String getCodigo_acceso() {
        return codigo_acceso;
    }

    public String getDescripcion() {
        return descripcion;
    }
    
    public int getIdDocente() {
        return idDocente;
    }
    
    public String getNombreDocente() {
        return nombreDocente;
    }
    
    
}
