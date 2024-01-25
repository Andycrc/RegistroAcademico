<%@page import="models.Usuario"%>
<%@page import="utils.SessionManager"%>
<%@page import="utils.ProjectConstants"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
  Usuario usuario = (Usuario) SessionManager.getAttribute(request, "Usuario");
  String nombreUsuario = "";
  int idDocente = 0;
  if (usuario != null) {
    nombreUsuario = usuario.getNombre();
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

    <title>Agregar Materia</title>

    <meta name="description" content="" />

    <!-- Favicon -->
    <a href="../../assets/img/favicon/favicon.ico"></a>
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
      rel="stylesheet" />

    <link href="../../assets/vendor/fonts/boxicons.css" rel="stylesheet" type="text/css"/>
    <!-- Core CSS -->
 
    <link href="../../assets/vendor/css/core.css" rel="stylesheet" type="text/css"/>
    <link href="../../assets/vendor/css/theme-default.css" rel="stylesheet" type="text/css"/>
    <!-- Vendors CSS -->
    <link href="../../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" rel="stylesheet" type="text/css"/>
    <!-- Page CSS -->
    <!-- Page -->
    <link href="../../assets/vendor/css/pages/page-auth.css" rel="stylesheet" type="text/css"/>
    <!-- Helpers -->
    <script src="../../assets/vendor/js/helpers.js" type="text/javascript"></script>
    <a href="../../assets/js/config.js"></a>
  </head>
  <body>
      
      
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
                title="Mira todas tus materias"
                href="<%= ProjectConstants.rutaBase %>"
                class="menu-link">
                <i class="menu-icon  bx bx-show"></i>
                <div>ver materias</div>
               
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
                <div class="row">
                <div class="col-md-12">
                  <div class="card mb-4">
                    <div class="card-header d-flex justify-content-between align-items-center">
                      <h5 class="mb-0">Agregar Materia</h5>
                      <small class="text-muted float-end">Llena los campos que se te piden</small>
                    </div>
                    <div class="card-body">
                      <form action="<%= ProjectConstants.rutaBase %>Materia?accion=agregarMateria" method="POST">
                        <div class="mb-3">
                          <label class="form-label" for="basic-icon-default-fullname">Nombre de la materia</label>
                          <div class="input-group input-group-merge">
                            <span id="basic-icon-default-fullname2" class="input-group-text"
                              ><i class="bx bx-task"></i></span>
                            <input
                              type="text"
                              class="form-control"
                              id="txtNombreMateria"
                              name="txtNombreMateria"
                              placeholder="Nombre de la materia"
                              aria-label="Nombre de la materia"
                              required
                              />
                          </div>
                        </div>
                       
                        <div class="mb-3">
                          <label class="form-label" for="basic-icon-default-email">Codigo de acceso</label>
                          <div class="input-group input-group-merge">
                            <span class="input-group-text"><i class="bx bx-link-alt"></i></span>
                            <input
                              type="text"
                              id="txtCodigo"
                              name="txtCodigo"
                              class="form-control"
                              placeholder="Codigo de acceso"
                              aria-label="Codigo de acceso"
                              required
                               />
                          </div>
                          <div class="form-text">Puedes usar numeros o letras</div>
                        </div>
                       
                        <div class="mb-3">
                          <label class="form-label" for="basic-icon-default-message">Descripcion</label>
                          <div class="input-group input-group-merge">
                            <span id="basic-icon-default-message2" class="input-group-text"
                              ><i class="bx bx-notepad"></i
                            ></span>
                            <textarea
                              id="txtDescripcion"
                              name="txtDescripcion"
                              class="form-control"
                              placeholder="Decripcion de la materia"
                              aria-label="Descripcion de la materia"
                              required
                              ></textarea>
                          </div>
                        </div>
                          
                         <input type="hidden" name="idDocente" value="<%= idDocente %>">

                          <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                              
                               <button type="submit" class="btn btn-primary">Agregar</button>
                          </div>
                       
                      </form>
                    </div>
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
      
    


    <!-- build:js assets/vendor/js/core.js -->

    <script src="../../assets/vendor/libs/jquery/jquery.js"></script>
    <script src="../../assets/vendor/libs/popper/popper.js"></script>
    <script src="../../assets/vendor/js/bootstrap.js"></script>
    <script src="../../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
    <script src="../../assets/vendor/js/menu.js"></script>
    
    <!-- endbuild -->

    <!-- Vendors JS -->

    <!-- Main JS -->
    <script src="../../assets/js/main.js"></script>

    <!-- Page JS -->

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
  </body>
</html>


