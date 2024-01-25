package models;

import java.sql.Date;


public class UsuarioMateria {
    
    private int id;
    private int usuario_id;
    private int materia_id;
    private Date fechaInscripcion;
    
    
    private String nombreMateria;
    private String nombreDocente;
    private int idMateria;
    
    // Constructor 

    public UsuarioMateria(int id, int usuario_id, int materia_id, Date fechaInscripcion) {
        this.id = id;
        this.usuario_id = usuario_id;
        this.materia_id = materia_id;
        this.fechaInscripcion = fechaInscripcion;
    }

    public UsuarioMateria() {
    }
    
    // SETTER

    public void setId(int id) {
        this.id = id;
    }

    public void setUsuario_id(int usuario_id) {
        this.usuario_id = usuario_id;
    }

    public void setMateria_id(int materia_id) {
        this.materia_id = materia_id;
    }



    
    public void setFechaInscripcion(Date fechaInscripcion) {
        this.fechaInscripcion = fechaInscripcion;
    }
    
    public void setNombreMateria(String nombreMateria) {
        this.nombreMateria = nombreMateria;
    }
    public void setNombreDocente(String nombreDocente) {
        this.nombreDocente = nombreDocente;
    }

    

    public void setIdMateria(int idMateria) {
        this.idMateria = idMateria;
    }
    
    
    
    
    // GETTER 

    public int getId() {
        return id;
    }

    public int getUsuario_id() {
        return usuario_id;
    }

    public int getMateria_id() {
        return materia_id;
    }



    public Date getFechaInscripcion() {
        return fechaInscripcion;
    }

    public String getNombreMateria() {
        return nombreMateria;
    }


    public String getNombreDocente() {
        return nombreDocente;
    }
 
    public int getIdMateria() {
        return idMateria;
    }
    
    
}
