<%@page import="com.mysql.cj.util.StringUtils"%>
<%@page import="models.Materia"%>
<%@page import="java.util.List"%>
<%@page import="utils.ProjectConstants"%>
<%@page import="models.Usuario"%>
<%@page import="utils.SessionManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
  Usuario usuario = (Usuario) SessionManager.getAttribute(request, "Usuario");
  String nombreUsuario = "";
  String apellidoUsuario = "";
  String correoUsuario = "";
    int idDocente = 0;  
    
  if (usuario != null) {
    nombreUsuario = usuario.getNombre();
    apellidoUsuario = usuario.getApellido();
    correoUsuario = usuario.getEmail();
    idDocente = usuario.getId();
  }// Suponiendo que "getNombre()" es el método para obtener el nombre de usuario en el objeto Usuario
%>
<!DOCTYPE html>
<html
  lang="es"
  class="light-style layout-wide customizer-hide">
  <head>
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

    <title>Dashboard</title>

    <meta name="description" content="" />

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="../assets/img/favicon/favicon.ico" />

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
      rel="stylesheet" />

    <link rel="stylesheet" href="./assets/vendor/fonts/boxicons.css" />

    <!-- Core CSS -->
    <link rel="stylesheet" href="./assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="./assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="./assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

    <!-- Page CSS -->
    <!-- Page -->
    <link rel="stylesheet" href="./assets/vendor/css/pages/page-auth.css" />

    <!-- Helpers -->
    <script src="./assets/vendor/js/helpers.js"></script>
    <script src="./assets/js/config.js"></script>
    
    <!-- Jquery -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>

  </head>
  <body>
    
          <!-- Layout wrapper -->
    <div class="layout-wrapper layout-content-navbar">
      <div class="layout-container">
        <!-- Menu -->

        <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
          <div class="menu-inner-shadow"></div>

          <ul class="menu-inner py-1">

            <li class="menu-header small text-uppercase">
            
                <a href="<%= ProjectConstants.rutaBase %>" class="menu-header-text">Dashboard</a>

            </li>
            <!-- Apps -->
            <li class="menu-item">
              <a
                title="Crea materias"
                href="<%= ProjectConstants.rutaBase %>views/Docente/agregarMateria.jsp"
                class="menu-link">
                <i class="menu-icon bx bx-add-to-queue"></i>
                <div>Agregar materia</div>
               
              </a>
            </li>
            
          
            
          </ul>
        </aside>
        <!-- / Menu -->

        <!-- Layout container -->
        <div class="layout-page">
          <!-- Navbar -->

          <nav
            class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme"
            id="layout-navbar">
            <div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
              <a class="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)">
                <i class="bx bx-menu bx-sm"></i>
              </a>
            </div>

            <div class="navbar-nav-right d-flex align-items-center" id="navbar-collapse">
              <!-- Search -->
              <div class="navbar-nav align-items-center">
                <div class="nav-item d-flex align-items-center">
                    <span class="text-muted">Bienvenido, <%= nombreUsuario %></span>
                </div>
              </div>
              <!-- /Search -->

              <ul class="navbar-nav flex-row align-items-center ms-auto">
                <!-- User -->
                <li class="nav-item navbar-dropdown dropdown-user dropdown">
                  <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown">
                      <%= nombreUsuario %>
                  </a>
                  <ul class="dropdown-menu dropdown-menu-end">
                    <li>
                      <a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#editarPerfilModal">
                        <i class="bx bx-user me-2"></i>
                        <span class="align-middle">Mi perfil</span>
                      </a>
                    </li>
                    <li>
                      <div class="dropdown-divider"></div>
                    </li>
                    <li>
                      <a class="dropdown-item" href="<%= application.getContextPath() %>/Logout">
                        <i class="bx bx-power-off me-2"></i>
                        <span class="align-middle">Cerrar sesion</span>
                      </a>
                    </li>
                  </ul>
                </li>
                <!--/ User -->
              </ul>
            </div>
          </nav>

          <!-- / Navbar -->

          <!-- Content wrapper -->
          <div class="content-wrapper">
            <!-- Content -->
            <div class="container-xxl flex-grow-1 container-p-y">
                <div class="card h-100">
        <div class="card-body">
        <h5 class="card-title mb-3">Dashboard</h5>
           
        <!-- Mostrar las materias del docente -->
        <h6 class="fw-bold mt-5 mb-4">Materias creadas:</h6>

        <%
            List<Materia> materias = (List<Materia>) request.getAttribute("materias");

            if (materias != null && !materias.isEmpty()) {
        %>
        <table class="table table-striped table-hover" id="miTabla">
            <thead>
                <tr>
                    <th class="fw-bold" scope="col">Nombre</th>
                    <th class="fw-bold" scope="col">Codigo de acceso</th>
                    <th class="fw-bold" scope="col">Descripcion</th>
                    <th class="fw-bold" scope="col">Acciones</th>

                </tr>
            </thead>
            <tbody>
                <% for (Materia materia : materias) { %>
                    <tr>
                        <td><%= materia.getNombre_materia()%></td>
                        <td><%= materia.getCodigo_acceso()%></td>
                        <td><%= materia.getDescripcion()%></td>
                        <td class="text-center ">
                            <div class="btn-group">
                                <a class="btn btn-primary btn-ver btn-sm" href="<%= application.getContextPath() %>/Evaluacion?idMateria=<%= materia.getId()%>" title="Crear evaluaciones de esta materia">
                                        <i class="text-white bx bx-add-to-queue"></i> 
                                </a>
                                <a class="btn btn-success btn-ver btn-sm" href="<%= application.getContextPath() %>/CalificacionesMateria?idMateria=<%= materia.getId()%>" title="Ver calificaciones de esta materia">
                                        <i class="text-white tf-icons bx bx-book-bookmark"></i>
                                </a>
                                </a>   
                                <a class="btn btn-warning btn-edit btn-sm" data-id="<%= materia.getId()%>" data-nombre="<%= materia.getNombre_materia()%>" data-codigo="<%= materia.getCodigo_acceso()%>" data-descipcion="<%= materia.getDescripcion()%>" title="Editar materia">
                                    <i class="text-white bx bx-edit-alt"></i>
                                </a>                                
                                <a class="btn btn-danger btn-delete btn-sm" data-id="<%= materia.getId()%>" title="Borrar esta materia">
                                    <i class="text-white bx bx-trash-alt"></i>
                                </a>
                         
                            </div>
                        </td>

                    </tr>
                <% } %>
            </tbody>
        </table>
        <%
            } else {
        %>
                <p>No tienes materias creadas.</p>
                <a class="btn btn-primary" href="./views/Docente/agregarMateria.jsp"><i class="bx bx-edit-alt me-2"></i> Crea una</a>
        <%
            }
        %>

    </div>
</div>

            </div>
            <!-- / Content -->

            <!-- Footer -->
            <footer class="content-footer footer bg-footer-theme">
              <div class="container-xxl d-flex flex-wrap justify-content-between py-2 flex-md-row flex-column">
                <div class="mb-2 mb-md-0">
                  ©
                  <script>
                    document.write(new Date().getFullYear());
                  </script>
                  UNICAES
                </div>
              </div>
            </footer>
            <!-- / Footer -->

            <div class="content-backdrop fade"></div>
          </div>
          <!-- Content wrapper -->
        </div>
        <!-- / Layout page -->
      </div>

      <!-- Overlay -->
      <div class="layout-overlay layout-menu-toggle"></div>
    </div>
    <!-- / Layout wrapper -->
    
    
 
    <!-- Modal para editar materia -->
<div class="modal fade" id="editarMateriaModal" tabindex="-1" aria-labelledby="editarMateriaModalLabel" aria-hidden="true" data-bs-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="editarMateriaModalLabel">Editar Materia</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <!-- Formulario de edición de materia -->
        <form id="editarMateriaForm">
          <div class="mb-3">
            <label for="nombreMateria" class="form-label">Nombre de la Materia</label>
            <input type="text" class="form-control mb-2" id="nombreMateria" name="nombreMateria">
            
            <label for="codigoMateria" class="form-label">Codigo de acceso </label>
            <input type="text" class="form-control mb-2" id="codigoMateria" name="codigoMateria">
            
            <label for="descripcionMateria" class="form-label">Descripcion</label>
            <input type="text" class="form-control mb-2" id="descripcionMateria" name="descripcionMateria">
            
           
            <input type="hidden" class="form-control mb-2" id="id" name="id">
           
            
          </div>
            
            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                <button type="submit" class="btn btn-primary mt-3">Guardar cambios</button>         
            </div>

        </form>
      </div>
    </div>
  </div>
</div>
    
    
    
    
    <!-- Modal para editar el perfil -->
<div class="modal fade" id="editarPerfilModal" tabindex="-1" role="dialog" aria-labelledby="editarPerfilModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="editarPerfilModalLabel">Editar Perfil</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
          <form id="editarPerfilForm">
          <div class="mb-3">
            <label for="nombre" class="form-label">Nombre:</label>
            <input type="text" class="form-control" id="nombre" name="nombre" value="<%= nombreUsuario %>" required>
          </div>
          <div class="mb-3">
            <label for="apellido" class="form-label">Apellido:</label>
            <input type="text" class="form-control" id="apellido" name="apellido" value="<%= usuario.getApellido() %>" required>
          </div>
          <div class="mb-3">
            <label for="email" class="form-label">Email:</label>
            <input type="email" class="form-control" id="email" name="email" value="<%= usuario.getEmail() %>" required>
          </div>
          
          <div class="mb-3">
            <label for="email" class="form-label">Nueva contraseña:</label>
            <input type="password" class="form-control" id="nuevo-password" name="nuevo-password">
          </div>
          
            <input type="hidden" class="form-control" id="password" name="password" value="<%= usuario.getPassword()%>">
            
           <input type="hidden" name="idEstudiante" value="<%= idDocente %>">

          <div class="d-grid gap-2 d-md-flex justify-content-md-end">
           <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            <button type="submit" class="btn btn-primary">Guardar cambios</button>
          </div>
        </form>
        
      </div>
    </div>
  </div>
</div>

      

    <script src="./assets/vendor/libs/jquery/jquery.js"></script>
    <script src="./assets/vendor/libs/popper/popper.js"></script>
    <script src="./assets/vendor/js/bootstrap.js"></script>
    <script src="./assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
    <script src="./assets/vendor/js/menu.js"></script>

    <!-- Main JS -->
    <script src="./assets/js/main.js"></script>

    <!-- Page JS -->

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
       $(document).ready(function () {
           // Verifica si hay un mensaje de error en la sesión
   <% 
    String errorMessage = (String) session.getAttribute("errorMessage");
    if (errorMessage != null && !errorMessage.trim().isEmpty()) {
        session.removeAttribute("errorMessage");
%>
    // Muestra el SweetAlert con el mensaje de error
    Swal.fire({
        title: 'Error',
        text: '<%= errorMessage.replaceAll("'", "\\\\'") %>',
        icon: 'error'
    });
<% } 

%>

       });
   </script>
    <script>
        $(document).ready(function () {

            $('.btn-delete').click(function () {
                var materiaId = $(this).data('id');


                Swal.fire({
                    title: '¿Estás seguro?',
                    text: 'Esta acción no se puede deshacer.',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#d33',
                    cancelButtonColor: '#3085d6',
                    confirmButtonText: 'Sí, eliminar'
                }).then((result) => {

                    if (result.isConfirmed) {
                        $.ajax({
                            type: 'POST',
                            url: '/RegistroAcademico/Materia?accion=eliminarMateria', 
                            data: { materiaId: materiaId },
                            success: function (data) {

                                if (data.success) {   
                                } else {

                                    Swal.fire("Hecho!", "Materia eliminada correctamente", "success");


                                    setTimeout(function () {
                                        location.reload();
                                    }, 2000);

                                }
                            },
                            error: function () {

                                Swal.fire('Error', 'Error en la solicitud Ajax.', 'error');
                            }
                        });
                    }
                });
            });
        });
    </script>

    <!-- Script para manejar el modal y Ajax -->
    <script>
      $(document).ready(function () {

        $('.btn-edit').click(function () {


          var materiaId = $(this).data('id');
          var nombreMateria = $(this).data('nombre');
          var codigoMateria = $(this).data('codigo');
          var descripcionMateria = $(this).data('descipcion');


          $('#nombreMateria').val(nombreMateria);
          $('#codigoMateria').val(codigoMateria);
          $('#descripcionMateria').val(descripcionMateria);
          $('#id').val(materiaId);




          // Abre el modal de editar materia
          $('#editarMateriaModal').modal('show');


          $('#editarMateriaForm').submit(function (event) {
            event.preventDefault();


            $.ajax({
              type: 'POST',
              url: '/RegistroAcademico/Materia?accion=editarMateria', 
              data: $('#editarMateriaForm').serialize() + '&materiaId=' + materiaId,
              success: function (data) {

                if (data.success) {                
                } else {
                  $('#editarMateriaModal').modal('hide');

                  Swal.fire("Hecho!", "Materia actualizada correctamente", "success");


                    setTimeout(function () {
                        location.reload();
                    }, 2000);
                }
              },
              error: function () {
                Swal.fire('Error', 'Error en la solicitud Ajax.', 'error');
              }
            });
          });
        });
      });
    </script>
    
    
    
    
    <!-- Script para manejar el modal y Ajax para editar el perfil -->
<script>
$(document).ready(function () {
    $('#editarPerfilForm').submit(function (event) {
        event.preventDefault();

        
        var formData = {
            nombre: $('#nombre').val(),
            apellido: $('#apellido').val(),
            email: $('#email').val(),
            nuevoPassword: $('#nuevo-password').val(),
            password: ($('#nuevo-password').val() === '') ? $('#password').val() : '',
            idEstudiante: <%= idDocente %>
        };

        $('#editarPerfilModal').modal('hide');

        $.ajax({
            type: 'POST',
            url: '/RegistroAcademico/Perfil?accion=editarPerfil',
            data: formData,
            success: function (data, textStatus, xhr) {
                if (textStatus === 'success') {
                    // Operación exitosa
                    Swal.fire("Hecho!", data, "success");
                    setTimeout(function () {
                        location.reload();
                    }, 2000);
                } else {
                    // Error
                    Swal.fire("Opps!", data, "error");
                    setTimeout(function () {
                        location.reload();
                    }, 2000);
                }
            },
            error: function (xhr, textStatus, errorThrown) {
                Swal.fire('Error', xhr.responseText, 'error');
            }
        });
    });
});

</script>

  </body>
</html>

