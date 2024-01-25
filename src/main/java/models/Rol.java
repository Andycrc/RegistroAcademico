/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author luis
 */
public class Rol {
    
    private int id;
    private String nombre;

    // CONSTRUCTOR 

    public Rol() {
    }

    public Rol(int id, String nombre) {
        this.id = id;
        this.nombre = nombre;
    }

    public Rol(String nombre) {
        this.nombre = nombre;
    }
    
    
    // SETTER

    public void setId(int id) {
        this.id = id;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    
    // GETTER 

    public int getId() {
        return id;
    }

    public String getNombre() {
        return nombre;
    }
    
    
}
