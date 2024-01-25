<%@page import="utils.ProjectConstants"%>
<%@page import="utils.SessionManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    // Verificar si la sesión existe
    if (SessionManager.getAttribute(request, "isLogged") != null) {
        // Si la sesión existe, redirigir al usuario a la página "/Usuario"
        response.sendRedirect(ProjectConstants.rutaBase +"Usuario");
    }
%>
<!DOCTYPE html>

<html
  lang="en"
  class="light-style layout-wide customizer-hide">
  <head>
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

    <title>Login</title>

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
    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="./assets/js/config.js"></script>
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.9.0/dist/sweetalert2.min.css">
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
  </head>

    <div class="container-xxl">
      <div class="authentication-wrapper authentication-basic container-p-y">
        <div class="authentication-inner">
          <!-- Register -->
          <div class="card">
            <div class="card-body">
              <!-- Logo -->
              <div class="app-brand justify-content-center">
                  
              </div>
              <!-- /Logo -->
              <form action="<%= ProjectConstants.rutaBase %>LoginServlet" method="POST">
                <div class="mb-3">
                  <label for="email" class="form-label">Correo</label>
                  <input
                    type="email"
                    class="form-control"
                    id="email"
                    name="email"
                    placeholder="Enter your email"
                    required />
                </div>
                <div class="mb-3 form-password-toggle">
                  <div class="d-flex justify-content-between">
                    <label class="form-label" for="password">Contraseña</label>
                  </div>
                  <div class="input-group input-group-merge">
                    <input
                      type="password"
                      id="password"
                      class="form-control"
                      name="password"
                      required />
                    <span class="input-group-text cursor-pointer"><i class="bx bx-hide"></i></span>
                  </div>
                </div>
                  
                <c:if test="${not empty mensajeError}">
                    <div class="alert alert-danger">
                        <c:out value="${mensajeError}" />
                    </div>
                </c:if>
                  
                <div class="mb-3">
                    <button class="btn btn-primary d-grid w-100" type="submit" >Iniciar sesion</button>
                </div>
              </form>

              <p class="text-center">
                <span>Nuevo en la plataforma?</span>
                 <a href="<%= ProjectConstants.rutaBase %>Register">
                  <span>Crea una cuenta</span>
                </a>
              </p>
            </div>
          </div>
          <!-- /Register -->
        </div>
      </div>
    </div>
  
    <!-- Modal -->
    <div class="modal fade" id="modalTop" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
      <div class="modal-dialog">
        <form class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="modalTopTitle">Archivo Sql</h5>
          </div>
          <div class="modal-body">
                <form action="ProcesarSQLServlet" method="post" enctype="multipart/form-data">
                  <label for="database">Archivo SQL:</label>
                  <input type="file" class="form-control" id="database" accept=".sql" name="archivoSQL" required>
                  <div class="mt-2">
                      <p class="text-muted">
                          La base de datos aún no ha sido creada. Ingresa el script para crear la base de datos.
                      </p>
                  </div>
                  <div class="mt-2">
                      <button type="button" id="submitBtn" class="btn btn-primary">
                          Ejecutar SQL
                      </button>
                  </div>
                </form>
          </div>
        </form>
      </div>
    </div>
  
    <script src="./assets/vendor/libs/jquery/jquery.js"></script>
    <script src="./assets/vendor/libs/popper/popper.js"></script>
    <script src="./assets/vendor/js/bootstrap.js"></script>
    <script src="./assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
    <script src="./assets/vendor/js/menu.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.9.0/dist/sweetalert2.all.min.js"></script>
       <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
    <!-- Vendors JS -->


    <!-- Main JS -->
    <script src="./assets/js/main.js"></script>

    <script>
        $(document).ready(function () {
            $.get("<%= ProjectConstants.rutaBase %>checkDatabase", function (data) {
                if (!data.databaseExists) {
                  $('#modalTop').modal('show'); // Mostrar el modal automáticamente
                }
            });

            // Manejar la carga y ejecución del archivo SQL
            $('#submitBtn').click(function () {
                let fileInput = document.getElementById('database');
                let sqlFile = fileInput.files[0];

                if (sqlFile) {
                    // Crear un objeto FormData para enviar el archivo al servidor
                    let formData = new FormData();
                    formData.append('archivoSQL', sqlFile);

                    // Realizar una llamada AJAX para cargar y ejecutar el archivo SQL en el servidor
                    $.ajax({
                        type: "POST",
                        url: "<%= ProjectConstants.rutaBase %>ProcesarSQLServlet", // Asegúrate de que la URL sea correcta
                        data: formData,
                        processData: false,
                        contentType: false,
                        success: function(response) {
                            if (response.status === "success") {
                                
                                $('#modalTop').modal('hide');

                                // Muestra un SweetAlert de éxito
                                Swal.fire("Éxito", response.message, "success");
                                
                            } else {
                                // Muestra un SweetAlert de error
                                Swal.fire("Error", response.message, "error");
                            }
                        },
                        error: function() {
                            // Muestra un SweetAlert en caso de error de la solicitud
                            Swal.fire("Error", "Error en la solicitud al servidor", "error");
                        }
                    });
                }
            });
        });
    </script>

  </body>
</html>

