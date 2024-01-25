package models;

public class CalificacionUsuario {

    private int id;
    private int usuario_id;
    private int materia_id;
    private double calificacion;
    private String fecha_calificacion;
    private int id_evaluacion;


    // Constructor vacío
    public CalificacionUsuario() {
    }

    // Constructor con parámetros
    public CalificacionUsuario(int id, int usuario_id, int materia_id, double calificacion, String fecha_calificacion, int id_evaluacion) {
        this.id = id;
        this.usuario_id = usuario_id;
        this.materia_id = materia_id;
        this.calificacion = calificacion;
        this.fecha_calificacion = fecha_calificacion;
        this.id_evaluacion = id_evaluacion;
    }
    
    public CalificacionUsuario(int usuarioId, int materiaId, double calificacion) {
        // Asignar campos
        this.usuario_id = usuarioId;
        this.materia_id = materiaId;
        this.calificacion = calificacion;
    }

    // Getters and setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUsuario_id() {
        return usuario_id;
    }

    public void setUsuario_id(int usuario_id) {
        this.usuario_id = usuario_id;
    }

    public int getMateria_id() {
        return materia_id;
    }

    public void setMateria_id(int materia_id) {
        this.materia_id = materia_id;
    }

    public double getCalificacion() {
        return calificacion;
    }

    public void setCalificacion(double calificacion) {
        this.calificacion = calificacion;
    }

    public String getFecha_calificacion() {
        return fecha_calificacion;
    }

    public void setFecha_calificacion(String fecha_calificacion) {
        this.fecha_calificacion = fecha_calificacion;
    }

    public int getId_evaluacion() {
        return id_evaluacion;
    }

    public void setId_evaluacion(int id_evaluacion) {
        this.id_evaluacion = id_evaluacion;
    }

}
