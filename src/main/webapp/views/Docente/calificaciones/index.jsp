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

    <link rel="stylesheet" href="<%= ProjectConstants.rutaBase %>assets/vendor/fonts/boxicons.css" />

    <!-- Core CSS -->
    <link rel="stylesheet" href="<%= ProjectConstants.rutaBase %>assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="<%= ProjectConstants.rutaBase %>assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="<%= ProjectConstants.rutaBase %>assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

    <!-- Page CSS -->
    <!-- Page -->
    <link rel="stylesheet" href="<%= ProjectConstants.rutaBase %>assets/vendor/css/pages/page-auth.css" />

    <!-- Helpers -->
    <script src="<%= ProjectConstants.rutaBase %>assets/vendor/js/helpers.js"></script>
    <script src="<%= ProjectConstants.rutaBase %>assets/js/config.js"></script>
    
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
                  href="<%= ProjectConstants.rutaBase %>views/Docente/agregarMateria.jsp"
                class="menu-link">
                <i class="menu-icon tf-icons bx bx-book-bookmark"></i>
                <div>Agregar Evaluacion</div>
               
              </a>
            </li>
            <li class="menu-item">
              <a
                href="<%= ProjectConstants.rutaBase %>views/Docente/calificaciones/index.jsp"
                class="menu-link">
                <i class="menu-icon tf-icons bx bx-book-bookmark"></i>
                <div>Ver Calificaciones</div>
               
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
                                            <a class="btn btn-primary btn-ver btn-sm" href="<%= application.getContextPath() %>/CalificacionesMateria?idMateria=<%= materia.getId()%>">
                                                    <i class="text-white bx bx-show"></i>
                                            </a>

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
    
    
    <script src="<%= ProjectConstants.rutaBase %>assets/vendor/libs/jquery/jquery.js"></script>
    <script src="<%= ProjectConstants.rutaBase %>assets/vendor/libs/popper/popper.js"></script>
    <script src="<%= ProjectConstants.rutaBase %>assets/vendor/js/bootstrap.js"></script>
    <script src="<%= ProjectConstants.rutaBase %>assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
    <script src="<%= ProjectConstants.rutaBase %>assets/vendor/js/menu.js"></script>

    <!-- Main JS -->
    <script src="<%= ProjectConstants.rutaBase %>assets/js/main.js"></script>

    <!-- Page JS -->

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

  </body>
</html>

