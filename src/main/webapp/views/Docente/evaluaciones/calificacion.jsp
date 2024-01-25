<%@page import="java.util.ArrayList"%>
<%@page import="models.UsuarioMateria"%>
<%@page import="models.Evaluacion"%>
<%@page import="models.Materia"%>
<%@page import="models.CalificacionUsuario"%>
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
      String idMateria = (String) session.getAttribute("idMateria");

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
                 title="Ver evaluaciones de esta materia"
                  href="<%= application.getContextPath() %>/Evaluacion?idMateria=<%= idMateria%>"
                class="menu-link">
                <i class="menu-icon bx bx-show"></i>
                <div>Ver evaluaciones</div>
               
              </a>
            </li>
            
              <li class="menu-item">
              <a
                    title="Ver calificaciones de esta materia"

                  href="<%= application.getContextPath() %>/CalificacionesMateria?idMateria=<%= idMateria%>"
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
                        <%
                                Evaluacion evaluacion = (Evaluacion) request.getAttribute("evaluaciones");
                         %>
                        <h5 class="card-title mb-3">Calificaciones de evaluacion: <%= evaluacion.getNombre_evaluacion() %></h5>
                        


                        <!-- Mostrar las materias del docente -->
                        <!-- Sección de evaluaciones -->
                        <div class="row">
    
                            <div class="col-md-6">
                                <h6 class="fw-bold mt-5 mb-4">Calificaciones</h6>
                            </div>

                            
                      
                        </div>
                        
                       <%
                            List<Usuario> usuariosM = (List<Usuario>) request.getAttribute("usuariosM");

                            // Validar si la lista de usuarios está vacía
                            if (usuariosM == null || usuariosM.isEmpty()) {
                        %>
                            <p>No tienes materias creadas.</p>

                        <%
                            } else {
                                List<CalificacionUsuario> calificacionesUsuarios = (List<CalificacionUsuario>) request.getAttribute("calificacionesUsuariosc");
                                List<Usuario> usuariosSinCalificacion = new ArrayList<>();

                                // Verificar si hay usuarios sin calificación
                                if (calificacionesUsuarios != null) {
                                    for (Usuario usuarioM : usuariosM) {
                                        boolean tieneCalificacion = false;
                                        for (CalificacionUsuario cu : calificacionesUsuarios) {
                                            if (cu.getUsuario_id() == usuarioM.getId()) {
                                                tieneCalificacion = true;
                                                break;  // Termina el bucle cuando se encuentra la calificación
                                            }
                                        }

                                        if (!tieneCalificacion) {
                                            usuariosSinCalificacion.add(usuarioM);
                                        }
                                    }
                                }

                                // Ahora procedemos a generar la tabla con la información
                        %>
                                <table class="table table-striped table-hover" id="miTabla">
                                    <thead>
                                        <tr>
                                            <th class="fw-bold" scope="col" hidden>UsuarioID</th>
                                            <th class="fw-bold" scope="col">Nombre</th>
                                            <th class="fw-bold" scope="col">Calificacion</th>
                                            <th class="fw-bold" scope="col" hidden>Porcentaje</th>
                                            <th class="fw-bold" scope="col" hidden>MateriaID</th>
                                            <th class="fw-bold" scope="col" hidden>EvaluacionID</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                                // Si todos los usuarios tienen calificación, llenar la tabla normalmente
                                                if (usuariosSinCalificacion.isEmpty()) {
                                                    for (Usuario usuarioM : usuariosM) {
                                                        CalificacionUsuario calificacionUsuario = null;
                                                        // Encuentra la calificación del usuario si existe
                                                        if (calificacionesUsuarios != null) {
                                                            for (CalificacionUsuario cu : calificacionesUsuarios) {
                                                                if (cu.getUsuario_id() == usuarioM.getId()) {
                                                                    calificacionUsuario = cu;
                                                                    break;  // Termina el bucle cuando se encuentra la calificación
                                                                }
                                                            }
                                                        }

                                                        double calificacionValue = (calificacionUsuario != null) ? calificacionUsuario.getCalificacion() : 0.0;
                                    %>
                                        <tr>
                                            <td hidden><%= usuarioM.getId() %></td>
                                            <td><%= usuarioM.getNombre() %> <%= usuarioM.getApellido()%></td>
                                            <td>
                                                <input type="number" step="0.01" min="1" max="10" name="calificacion" 
                                                    class="form-control" placeholder="Ingrese calificación" 
                                                    required pattern="^\d+(\.\d{1,2})?$" title="Ingrese un número válido con hasta dos decimales."
                                                    value="<%= calificacionValue %>" />
                                            </td>
                                            <td hidden><%= evaluacion.getPorcentajeCalificacion() %></td>
                                            <td hidden><%= evaluacion.getMateria_id() %></td>
                                            <td hidden><%= evaluacion.getId() %></td>
                                        </tr>
                        <%
                                        }
                                    } else {
                                        // Si hay usuarios sin calificación, llenar la tabla solo con esos usuarios
                                        for (Usuario usuarioSinCalificacion : usuariosSinCalificacion) {
                        %>
                
                        <tr>
                                            <td hidden><%= usuarioSinCalificacion.getId() %></td>
                                            <td><%= usuarioSinCalificacion.getNombre() %> <%= usuarioSinCalificacion.getApellido()%></td>
                                            <td>
                                                <input type="number" step="0.01" min="1" max="10" name="calificacion" 
                                                    class="form-control" placeholder="Ingrese calificación" 
                                                    required pattern="^\d+(\.\d{1,2})?$" title="Ingrese un número válido con hasta dos decimales."
                                                    value="0.0" /> <!-- Valor predeterminado de 0.0 para usuarios sin calificación -->
                                            </td>
                                            <td hidden></td> <!-- Puedes ajustar esto según tus necesidades -->
                                            <td hidden></td>
                                            <td hidden></td>
                                        </tr>
                        <%
                                        }
                                    }
                        %>
                                    </tbody>
                                </table>
                                <div class="col-md-6 mt-5 text-end">
                        <%
                                if (calificacionesUsuarios == null || calificacionesUsuarios.isEmpty()) {
                        %>
                                    <!-- Escenario 1: Ningún usuario ha sido calificado -->
                                    <button type="button" id="btnGenerarCalificaciones" class="btn btn-primary">
                                        <i class="bx bx-plus"></i> Calificar evaluación
                                    </button>
                        <%
                                } else {
                                    boolean todosCalificados = calificacionesUsuarios.size() == usuariosM.size();
                                    if (todosCalificados) {
                        %>
                                        <!-- Escenario 2: Todos los usuarios han sido calificados -->
                                        <button type="button" id="btnActualizarCalificaciones" class="btn btn-primary">
                                            <i class="bx bx-plus"></i> Actualizar evaluación
                                        </button>
                        <%
                                    } else {
                        %>
                                        <p>Existen nuevos alumnos ponte al dia con sus notas antes de continuar..</p>

                                        <!-- Escenario 3: Al menos un usuario no ha sido calificado -->
                                        <button type="button" id="btnGenerarCalificaciones" class="btn btn-primary">
                                            <i class="bx bx-plus"></i> Calificar nuevos usuarios
                                        </button>
                        <%
                                    }
                                }
                        %>
                                </div>
                        <%
                            }
                        %>


     
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
        $('#btnGenerarCalificaciones').click(function () {
            var calificacionesUsuarios = [];
            var hayErrores = false; // Variable para rastrear si se encontraron errores durante la validación

            // Obtén la fecha actual en el formato deseado (por ejemplo, YYYY-MM-DD)
            var today = new Date();
            var formattedDate = today.toISOString().split('T')[0];

            // Recorre las filas de la tabla
            $('#miTabla tbody tr').each(function () {
                var idUsuario = $(this).find('td:eq(0)').text();
                var calificacionInput = $(this).find('input[name="calificacion"]');
                var calificacion = calificacionInput.val();

                // Usa una expresión regular para validar que la calificación sea un número entre 0 y 10
                if (/^\d+(\.\d{1,2})?$/.test(calificacion) && parseFloat(calificacion) >= 0.1 && parseFloat(calificacion) <= 10) {
                    // Crea un objeto con la información y agrégalo a la lista
                    var calificacionUsuario = {
                        usuario_id: idUsuario,
                        materia_id: '<%= evaluacion.getMateria_id() %>',
                        calificacion: parseFloat(calificacion),
                        fecha_calificacion: formattedDate, // Agrega la fecha actual
                        id_evaluacion: '<%= evaluacion.getId() %>'
                    };
                    calificacionesUsuarios.push(calificacionUsuario);
                } else {
                    // Se encontró un error de validación
                    hayErrores = true;
                    // Muestra un mensaje de error o realiza otra acción en caso de validación fallida
                     Swal.fire({
                        icon: 'error',
                        title: 'Error de validación',
                        text: 'La calificación debe ser un número entre 0.1 y 10 y no puede estar vacía.',
                        position: 'top-center',
                        timerProgressBar: true,
                        showConfirmButton: false,
                        timer: 2500,
                        customClass: {
                            popup: 'custom-popup-class'
                        },
                        onOpen: (toast) => {
                            toast.style.width = '300px'; // Ajusta el ancho según tus necesidades
                            toast.style.height = '50px'; // Ajusta la altura según tus necesidades
                        }
                    });
                    // Puedes detener el bucle u otra lógica según tu necesidad
                    return false;
                }
            });

            // Verifica si hay errores antes de realizar la solicitud AJAX
            if (!hayErrores) {
                // Envia la lista de calificaciones al servidor mediante Ajax
                $.ajax({
                    type: 'POST',
                    url: '<%= request.getContextPath() %>/CalificacionUsuario?accion=agregarCalificacion',
                    contentType: 'application/json',
                    data: JSON.stringify(calificacionesUsuarios),
                    success: function (data) {
                        if (data.success) {
                            // Utilizar SweetAlert para éxito
                            Swal.fire({
                                icon: 'success',
                                title: 'Calificaciones guardadas exitosamente',
                                position: 'top-center',  // Colocar en la esquina superior izquierda
                                showConfirmButton: false,
                                timerProgressBar: true,

                                timer: 1500
                            });
                             setTimeout(function () {
                                location.reload();
                            }, 1600);
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error al guardar calificaciones',
                                position: 'top-start',  // Colocar en la esquina superior izquierda
                                showConfirmButton: false,
                                                            timerProgressBar: true,

                                timer: 1500
                            });
                        }
                    },
                    error: function () {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error en la solicitud Ajax.',
                            position: 'top-center',  // Colocar en la esquina superior izquierda
                            showConfirmButton: false,
                            timerProgressBar: true,
                            timer: 1500
                        });
                    }
                });
            }
        });
    });


    </script>
      <script>
        $(document).ready(function () {
            $('#btnActualizarCalificaciones').click(function () {
                var calificacionesUsuarios = [];
                var hayErrores = false; // Variable para rastrear si se encontraron errores durante la validación

                // Obtén la fecha actual en el formato deseado (por ejemplo, YYYY-MM-DD)
                var today = new Date();
                var formattedDate = today.toISOString().split('T')[0];

                // Recorre las filas de la tabla
                $('#miTabla tbody tr').each(function () {
                    var idUsuario = $(this).find('td:eq(0)').text();
                    var calificacionInput = $(this).find('input[name="calificacion"]');
                    var calificacion = calificacionInput.val();

                    // Usa una expresión regular para validar que la calificación sea un número entre 0 y 10
                    if (/^\d+(\.\d{1,2})?$/.test(calificacion) && parseFloat(calificacion) >= 0.1 && parseFloat(calificacion) <= 10) {
                        // Crea un objeto con la información y agrégalo a la lista
                        var calificacionUsuario = {
                            usuario_id: idUsuario,
                            materia_id: '<%= evaluacion.getMateria_id() %>',
                            calificacion: parseFloat(calificacion),
                            fecha_calificacion: formattedDate, // Agrega la fecha actual
                            id_evaluacion: '<%= evaluacion.getId() %>'
                        };
                        calificacionesUsuarios.push(calificacionUsuario);
                    } else {
                        // Se encontró un error de validación
                        hayErrores = true;
                        // Muestra un mensaje de error o realiza otra acción en caso de validación fallida
                         Swal.fire({
                            icon: 'error',
                            title: 'Error de validación',
                            text: 'La calificación debe ser un número entre 0.1 y 10 y no puede estar vacía.',
                            position: 'top-center',
                            timerProgressBar: true,
                            showConfirmButton: false,
                            timer: 2500,
                            customClass: {
                                popup: 'custom-popup-class'
                            },
                            onOpen: (toast) => {
                                toast.style.width = '300px'; // Ajusta el ancho según tus necesidades
                                toast.style.height = '50px'; // Ajusta la altura según tus necesidades
                            }
                        });
                        // Puedes detener el bucle u otra lógica según tu necesidad
                        return false;
                    }
                });

                // Verifica si hay errores antes de realizar la solicitud AJAX
                if (!hayErrores) {
                    // Envia la lista de calificaciones al servidor mediante Ajax
                    $.ajax({
                        type: 'POST',
                        url: '<%= request.getContextPath() %>/CalificacionUsuario?accion=actualizarCalificacion',
                        contentType: 'application/json',
                        data: JSON.stringify(calificacionesUsuarios),
                        success: function (data) {
                            if (data.success) {
                                // Utilizar SweetAlert para éxito
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Calificaciones actualizadas exitosamente',
                                    position: 'top-center',  // Colocar en la esquina superior izquierda
                                    showConfirmButton: false,
                                    timerProgressBar: true,

                                    timer: 1500
                                });
                                 setTimeout(function () {
                                        location.reload();
                                    }, 1600);
                            } else {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Error al guardar calificaciones',
                                    position: 'top-start',  // Colocar en la esquina superior izquierda
                                    showConfirmButton: false,
                                                                timerProgressBar: true,

                                    timer: 1500
                                });
                            }
                        },
                        error: function () {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error en la solicitud Ajax.',
                                position: 'top-center',  // Colocar en la esquina superior izquierda
                                showConfirmButton: false,
                                timerProgressBar: true,
                                timer: 1500
                            });
                        }
                    });
                }
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

