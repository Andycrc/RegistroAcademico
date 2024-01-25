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

    <title>Buscar Materia</title>

    <meta name="description" content="" />

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="../assets/img/favicon/favicon.ico" />

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
      rel="stylesheet" />

    <link href="../../assets/vendor/fonts/boxicons.css" rel="stylesheet" type="text/css"/>
    <!-- Core CSS -->
    <link rel="stylesheet" href="../../assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="../../assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="../../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

    <!-- Page CSS -->
    <!-- Page -->
    <link rel="stylesheet" href="../../assets/vendor/css/pages/page-auth.css" />

    <!-- Helpers -->
    <script src="../../assets/vendor/js/helpers.js"></script>
    <script src="../../assets/js/config.js"></script>
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
                      <a class="dropdown-item" href="#">
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
                       <h5 class="card-title mb-3">Busqueda de materias</h5>
                       <p class="text-center">Bievenido a la busqueda de materias, ingresa el nombre de la materia que quieras buscar y  a la que quieras unirte,  
                           luego pon el codigo que te proporciono tu docente para ingresar.
                       </p>
                       <div class="text-center mt-4">
                           
                           <form id="searchForm">
                        <label class="ms-5 mt-2 ms-5" for="nombreBusqueda">Nombre de la materia: </label>
                        <input class="ms-1 mt-3" type="text" id="nombreBusqueda" name="nombreBusqueda">
                         <button class="btn btn-primary ms-2 mb-1 me-5" type="submit">Buscar</button>
                        </form>
                           
                           
                        </div>
                       
                        <div class="row mt-3" id="materiasContainer">
                            
                        
                        </div>
                       
                       
                      
                        
                       

                      
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

      

    <script src="../../assets/vendor/libs/jquery/jquery.js"></script>
    <script src="../../assets/vendor/libs/popper/popper.js"></script>
    <script src="../../assets/vendor/js/bootstrap.js"></script>
    <script src="../../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
    <script src="../../assets/vendor/js/menu.js"></script>

    <!-- Main JS -->
    <script src="../../assets/js/main.js"></script>

    <!-- Page JS -->

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
    
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    
<script>
    $(document).ready(function () {
        $('#searchForm').submit(function (event) {
            event.preventDefault();

            var nombreBusqueda = $('#nombreBusqueda').val();

            $.ajax({
                type: 'POST',
                url: '/RegistroAcademico/Materia?accion=buscarPorNombre',
                data: { nombreBusqueda: nombreBusqueda },
                success: function (data) {
                    
                    $('#materiasContainer').empty();

                    
                    if (data.hasOwnProperty('error')) {
                        console.error('Error al buscar materias:', data.error);
                        alert('Error al buscar materias. Por favor, inténtelo de nuevo.');
                    } else {
                        
                        
                        if (data.length === 0) {
                        // No se encontraron materias
                        Swal.fire("Oops!", "La materia no existe.", "error");
                        } else {
                        
                        data.forEach(function (materia) {
                            var cardHtml = '<div class="col-md-6 mb-4 mt-3">';
                            cardHtml += '<div class="card">';
                            cardHtml += '<div class="card-header bg-dark"></div>';
                            cardHtml += '<div class="card-body">';
                            cardHtml += '<h4 class="card-title text-primary mt-3">' + materia.nombre_materia + '</h4>';
                            cardHtml += '<h5 class="text-dark"> Docente: ' + materia.nombreDocente + '</h5>';
                            cardHtml += '<p class="card-text mb-3">' + materia.descripcion + '</p>';
                            
                            cardHtml += ' <a id="btnUnirse" class="btn btn-info text-white">Unirse</a>';
                            cardHtml += '</div></div></div>';
                            
                            
                           
                            $('#materiasContainer').append(cardHtml);
                        });
                    }      
                }
                
                },
                error: function (xhr, textStatus, errorThrown) {
                    console.error('Error al buscar materias:', errorThrown);
                    alert('Error al buscar materias. Por favor, inténtelo de nuevo.');
                }
            });
        });
    });
</script>

    
    
    
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
    
    
    
    
    // Script para manejar el clic del botón "Ingresar" y ejecutar el otro script
    $('#materiasContainer').on('click', '#btnUnirse', function () {
      // Ejecutar el script cuando se presiona el botón "Ingresar"
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
              Swal.fire("Hecho!", data, "success");
              setTimeout(function () {
                location.reload();
              }, 2000);
            } else {
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



  </body>
</html>


