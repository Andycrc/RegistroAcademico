<%@page import="models.UsuarioMateria"%>
<%@page import="java.util.List"%>
<%@page import="utils.ProjectConstants"%>
<%@page import="models.Usuario"%>
<%@page import="utils.SessionManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
  Usuario usuario = (Usuario) SessionManager.getAttribute(request, "Usuario");
  String nombreUsuario = "";
  int idEstudiante = 0;
  if (usuario != null) {
    nombreUsuario = usuario.getNombre();
    idEstudiante = usuario.getId();
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
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>


    <!-- Helpers -->
    <script src="./assets/vendor/js/helpers.js"></script>
    <script src="./assets/js/config.js"></script>
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
                href="<%= ProjectConstants.rutaBase %>views/Estudiante/buscarMateria.jsp"
                class="menu-link">
                <i class="menu-icon tf-icons bx bx-search-alt-2"></i>
                <div>Buscar Materia</div>
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
                       
                       
                         
                         
                        <div class="container">
                            <div class="row">
                                <div class="col">
                                    <a class="btn btn-danger btn-add text-white" href="#">Ingresa a una materia</a>
                                </div>
                            </div>
                        </div>

                       
                        <!-- Mostrar las materias del estudiante -->
        <h6 class="fw-bold mt-5 mb-4">Materias inscritas</h6>
        
        
        
        <%
            
            
            
    List<UsuarioMateria> materias = (List<UsuarioMateria>) request.getAttribute("materias_usuario");

    if (materias != null && !materias.isEmpty()) {
        int count = 0;
        for (UsuarioMateria materia : materias) {
            // Verifica si es la primera tarjeta de la fila
            if (count % 2 == 0) {
%>
                <div class="row">
<%
            }
%>
                   <div class="col-md-6">
                        <div class="card mb-3 mt-2">
                            <div class="card-header bg-dark text-white" style="max-height: 10px;">
                            
                            </div>
                            <div class="card-body">
                                <h4 class="fw-bold mt-3 mb-3"><%= materia.getNombreMateria()%></h4>
                                <h5 class="card-title">Docente: <%= materia.getNombreDocente()%></h5>
                                <p class="card-text">Fecha de inscripción: <%= materia.getFechaInscripcion()%></p>
                            </div>
                            <div class="card-footer text-muted">
                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                    <button class="btn btn-info btn-entrar-materia" type="button" data-materia-id="<%= materia.getIdMateria() %>" data-estudiante-id="<%=idEstudiante%>" data-materia-nombre="<%= materia.getNombreMateria() %>">Entrar</button>
                                </div>     
                            </div>
                        </div>
                    </div>

<%
            // Verifica si es la última tarjeta de la fila
            if ((count + 1) % 2 == 0 || count == materias.size() - 1) {
%>
                </div>
<%
            }
            count++;
        }
    } else {
%>
     <div class="card mb-3 mt-2">
            <div class="card-body">
                <p class="card-text">No tienes materias inscritas.</p>
            </div>
        </div>
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
    
    
    
    <!-- Modal para unirse a una materia -->
<div class="modal fade" id="unirseMateriaModal" tabindex="-1" role="dialog" aria-labelledby="unirseMateriaModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="unirseMateriaModalLabel">Unirse a una materia</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="unirseMateriaForm">
          <div class="mb-3">
            <label for="codigoAcceso" class="form-label">Código de Acceso:</label>
            <input type="text" class="form-control" id="codigoAcceso" name="codigoAcceso" required>
          </div>
            
           <input type="hidden" name="idEstudiante" value="<%= idEstudiante %>">
           
           <div class="d-grid gap-2 d-md-flex justify-content-md-end">
               
            <button type="submit" class="btn btn-primary">Unirse</button>
            
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
            
           <input type="hidden" name="idEstudiante" value="<%= idEstudiante %>">

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
    
    <!-- Script para manejar el modal y Ajax para unirse a una materia -->
<script>
  $(document).ready(function () {
    
    $('.btn-add').click(function () {
      
      $('#unirseMateriaModal').modal('show');

     
      $('#unirseMateriaForm').submit(function (event) {
        event.preventDefault();
        
        $('#unirseMateriaModal').modal('hide');

       
        $.ajax({
          type: 'POST',
          url: '/RegistroAcademico/Materia?accion=unirseMateria', 
          data: $('#unirseMateriaForm').serialize(),
          success: function (data, textStatus, xhr) {
              
         
              
            if (textStatus === 'success') {
              // Operación exitosa
              Swal.fire("Hecho!", data, "success");

              setTimeout(function () {
                location.reload();
              }, 2000);
              
            } else {
                
                //error
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
            idEstudiante: <%= idEstudiante %>
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

<script>
  $(document).ready(function () {
    // Usa la delegación de eventos para manejar botones agregados dinámicamente
    $('.content-wrapper').on('click', '.btn-entrar-materia', function () {
      // Extrae el ID y el nombre de la materia del atributo de datos
      var materiaId = $(this).data('materia-id');
      var materiaNombre = $(this).data('materia-nombre');
      var estudianteId = $(this).data('estudiante-id')

      // Realiza una solicitud AJAX para cargar la nueva vista basada en materiaId y materiaNombre
      $.ajax({
        type: 'POST',
        url: 'EntrarMateriaController',
        data: { materiaId: materiaId, materiaNombre: materiaNombre, estudianteId: estudianteId }, // Envía ambos valores
        success: function (data) {
          // Reemplaza el contenido actual con el contenido de la nueva vista
          $('.content-wrapper').html(data);
        },
        error: function (xhr, textStatus, errorThrown) {
          // Maneja errores
          console.error(xhr.statusText);
        }
      });
    });
  });
</script>
<!-- Incluye jsPDF antes de tu script -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>


  </body>
</html>

