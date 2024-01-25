package models;


public class HistorialAcceso {
    
    private int id;
    private String usuario_id;
    private String fecha_acceso;
    private String tipo_acceso;
    
    // constructor

    public HistorialAcceso() {
    }

    public HistorialAcceso(int id, String usuario_id, String fecha_acceso, String tipo_acceso) {
        this.id = id;
        this.usuario_id = usuario_id;
        this.fecha_acceso = fecha_acceso;
        this.tipo_acceso = tipo_acceso;
    }
    
     public HistorialAcceso(String usuario_id, String fecha_acceso, String tipo_acceso) {
        this.usuario_id = usuario_id;
        this.fecha_acceso = fecha_acceso;
        this.tipo_acceso = tipo_acceso;
    }
    
    // SETTER

    public void setId(int id) {
        this.id = id;
    }

    public void setUsuario_id(String usuario_id) {
        this.usuario_id = usuario_id;
    }

    public void setFecha_acceso(String fecha_acceso) {
        this.fecha_acceso = fecha_acceso;
    }

    public void setTipo_acceso(String tipo_acceso) {
        this.tipo_acceso = tipo_acceso;
    }

    
    
    // GETTER 

    public int getId() {
        return id;
    }

    public String getUsuario_id() {
        return usuario_id;
    }

    public String getFecha_acceso() {
        return fecha_acceso;
    }

    public String getTipo_acceso() {
        return tipo_acceso;
    }
    
    
}
