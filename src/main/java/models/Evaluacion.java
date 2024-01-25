/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

/**
 *
 * @author EternoNR
 */
public class Evaluacion {
    private int id;
    private String nombre_evaluacion;
    private double porcentajeCalificacion;
    private int materia_id;

    public Evaluacion() {
    }

    public Evaluacion(int id, String nombre_evaluacion,double porcentajeCalificacion, int materia_id) {
        this.id = id;
        this.nombre_evaluacion = nombre_evaluacion;
        this.porcentajeCalificacion = porcentajeCalificacion;
        this.materia_id = materia_id;
    }

   //setters

    public void setId(int id) {
        this.id = id;
    }

    public void setNombre_evaluacion(String nombre_evaluacion) {
        this.nombre_evaluacion = nombre_evaluacion;
    }

    public void setPorcentajeCalificacion(double porcentajeCalificacion) {
        this.porcentajeCalificacion = porcentajeCalificacion;
    }
    
    public void setMateria_id(int materia_id) {
        this.materia_id = materia_id;
    }
    
    //geters

    public int getId() {
        return id;
    }

    public String getNombre_evaluacion() {
        return nombre_evaluacion;
    }

    public double getPorcentajeCalificacion() {
        return porcentajeCalificacion;
    }
    
    public int getMateria_id() {
        return materia_id;
    }
    
    
    
}
