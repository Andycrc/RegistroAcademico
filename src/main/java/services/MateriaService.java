package services;

import dao.MateriaDAO;
import java.util.List;
import models.Materia;


public class MateriaService {
    
    private final MateriaDAO materiaDao = new MateriaDAO();
     
    public List<Materia> listarRoles() {
        return materiaDao.findAll();
    }
    
    public void crearMateria(Materia materia_) {
        materiaDao.insert(materia_);
    }

    public Materia obtenerMateriaPorId(int id_) {
        return materiaDao.findById(id_);
    }

    public void actualizarMateria(Materia materia_) {
        materiaDao.update(materia_, "id");
    }

    public void eliminarMateria(int id_) {
        materiaDao.delete(id_);
    }
      public boolean existeCodigoAcceso(String codigoAcceso) {
        return materiaDao.existeCodigoAcceso(codigoAcceso);
    }
}
