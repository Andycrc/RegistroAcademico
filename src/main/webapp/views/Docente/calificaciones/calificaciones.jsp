<%@page import="org.apache.pdfbox.pdmodel.PDDocument"%>
<%@page import="org.apache.pdfbox.pdmodel.PDPage"%>
<%@page import="org.apache.pdfbox.pdmodel.PDPageContentStream"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="models.Materia"%>
<%@page import="java.util.List"%>
<%@page import="utils.ProjectConstants"%>
<%@page import="models.Usuario"%>
<%@page import="utils.SessionManager"%>
<%@page import="org.apache.pdfbox.pdmodel.font.PDType1Font"%>


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

    <link rel="stylesheet" href="<%= ProjectConstants.rutaBase %>assets/vendor/fonts/boxicons.css" />

    <!-- Core CSS -->
    <link rel="stylesheet" href="<%= ProjectConstants.rutaBase %>assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="<%= ProjectConstants.rutaBase %>assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="<%= ProjectConstants.rutaBase %>assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
     
    <!-- DataTables CSS -->
     <link rel="stylesheet" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.min.css" />

    <!-- Page CSS -->
    <!-- Page -->
    <link rel="stylesheet" href="<%= ProjectConstants.rutaBase %>assets/vendor/css/pages/page-auth.css" />

    <!-- Helpers -->
    <script src="<%= ProjectConstants.rutaBase %>assets/vendor/js/helpers.js"></script>
    <script src="<%= ProjectConstants.rutaBase %>assets/js/config.js"></script>
    
    <!-- pdf -->
    <!-- Agrega esto antes de tu script personalizado -->


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
                href="<%= application.getContextPath() %>/CalificacionesMateria?idMateria=<%= idMateria%>"
                class="menu-link">
                <i class="menu-icon tf-icons bx bx-book-bookmark"></i>
                <div>Ver Calificaciones</div>
               
              </a>
            </li>
                <li class="menu-item">
              <a
                 href="<%= application.getContextPath() %>/views/Docente/calificaciones/graficos.jsp"
                class="menu-link">
                <i class="menu-icon bx bx-bar-chart"></i>
                <div>Ver graficos</div>
               
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
                <!-- Mostrar las calificaciones en una tabla -->
                <h6 class="fw-bold mt-5 mb-4">Calificaciones:</h6>
                <%
                List<Object[]> datosCalificaciones = (List<Object[]>) request.getAttribute("datosCalificaciones");

                if (datosCalificaciones != null && !datosCalificaciones.isEmpty()) {
                    // Crear un mapa para almacenar las evaluaciones por usuario usando el identificador único
                    Map<String, List<Object[]>> evaluacionesPorUsuario = new HashMap<>();

                    // Llenar el mapa con las evaluaciones por usuario
                    for (Object[] calificacion : datosCalificaciones) {
                        int idUsuario = (int) calificacion[3]; // Utilizar el identificador único (int) en lugar del nombre de usuario
                        String idUsuarioStr = String.valueOf(idUsuario); // Convertir el int a String
                        List<Object[]> evaluacionesUsuario = evaluacionesPorUsuario.getOrDefault(idUsuarioStr, new ArrayList<>());
                        evaluacionesUsuario.add(calificacion);
                        evaluacionesPorUsuario.put(idUsuarioStr, evaluacionesUsuario);
                    }
                %>
            <div class="container mb-2">
            <div class="row">
                <div class="col-md-6">
                    <form method="post" action="<%= request.getContextPath() %>/CalificacionUsuario?accion=filtrarfecha">
                        <label for="fechaFiltro" class="form-label">Seleccionar fecha:</label>
                        <input type="date" class="form-control" id="fechaFiltro" name="fechaFiltro">
                        <input type="hidden" value="<%= idMateria%>" id="idMateria" name="idMateria">
                        <button class="mt-2 btn btn-primary" type="submit">Aplicar Filtro</button>
                    </form>
                </div>

                <div class="col-md-6">
                    <a class="mt-2 btn btn-primary" href="<%= application.getContextPath() %>/views/Docente/calificaciones/graficos.jsp">Ir a gráficos</a>
                </div>
            </div>
        </div>

                <div class="table-responsive mt-3">

                <table id="miTabla" class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th hidden>ID Usuario</th>
                            <th>Nombre Usuario</th>
                            <th>Apellido Usuario</th>
                            <%
                                // Crear las columnas para cada evaluación
                                Set<String> nombresEvaluaciones = new HashSet<>();
                                Map<String, Double> porcentajesEvaluacion = new HashMap<>(); // Mapa para almacenar porcentajes por nombre de evaluación

                                for (List<Object[]> evaluacionesUsuario : evaluacionesPorUsuario.values()) {
                                    for (Object[] calificacion : evaluacionesUsuario) {
                                        String nombreEvaluacion = (String) calificacion[1];
                                        double porcentaje = (double) calificacion[7];

                                        nombresEvaluaciones.add(nombreEvaluacion);
                                        porcentajesEvaluacion.put(nombreEvaluacion, porcentaje);
                                    }
                                }

                                for (String nombreEvaluacion : nombresEvaluaciones) {
                                    double porcentaje = porcentajesEvaluacion.get(nombreEvaluacion);
                            %>
                            <th><%= nombreEvaluacion %> (<%= porcentaje %>)% </th>
                            <%
                                }
                            %>
                            <th>Promedio</th>
                            <th>Fecha Calificación</th>
                        </tr>
                    </thead>

                    <tbody>
                        <%
                        // Iterar sobre los datos y llenar la tabla
                        for (String idUsuarioStr : evaluacionesPorUsuario.keySet()) {
                            List<Object[]> evaluacionesUsuario = evaluacionesPorUsuario.get(idUsuarioStr);

                            // Verificar si el usuario tiene todas sus notas
                            boolean tieneTodasLasNotas = true;
                            for (String nombreEvaluacion : nombresEvaluaciones) {
                                boolean tieneNota = false;
                                for (Object[] calificacion : evaluacionesUsuario) {
                                    if (nombreEvaluacion.equals(calificacion[1])) {
                                        tieneNota = true;
                                        break;
                                    }
                                }
                                if (!tieneNota) {
                                    tieneTodasLasNotas = false;
                                    break;
                                }
                            }

                            if (tieneTodasLasNotas) {
                        %>
                        <tr>
                            <td hidden><%= idUsuarioStr %></td>
                            <td><%= evaluacionesUsuario.get(0)[4] %></td> <!-- Mostrar el nombre de usuario correspondiente al identificador único -->
                            <td><%= evaluacionesUsuario.get(0)[5] %></td> <!-- Mostrar el apellido de usuario correspondiente al identificador único -->
                            <%
                                // Inicializar la variable para almacenar la suma de las notas multiplicadas por el porcentaje
                                double sumaPromedios = 0.0;

                                // Iterar sobre las evaluaciones y mostrar calificación, porcentaje y calcular el promedio
                                for (String nombreEvaluacion : nombresEvaluaciones) {
                                    for (Object[] calificacion : evaluacionesUsuario) {
                                        if (nombreEvaluacion.equals(calificacion[1])) {
                            %>
                            <td><%= calificacion[6] %></td>
                            <td hidden><%= calificacion[7] %></td>
                            <%
                                            // Calcular el promedio y sumarlo a la variable
                                            double nota = Double.parseDouble(calificacion[6].toString());
                                            double porcentaje = Double.parseDouble(calificacion[7].toString());
                                            double promedio = nota * (porcentaje / 100);
                                            sumaPromedios += promedio;
                                        }
                                    }
                                }
                            %>
                            <td><%= new DecimalFormat("0.00").format(sumaPromedios) %></td>
                            <td><%= evaluacionesUsuario.get(0)[8] %></td> <!-- Fecha de la primera calificación del usuario -->
                        </tr>
                        <%
                            } else {
                        %>
                        <tr>
                            <td colspan="<%= nombresEvaluaciones.size() + 4 %>">
                                 <%= evaluacionesUsuario.get(0)[4] %> <%= evaluacionesUsuario.get(0)[5] %> sin todas sus notas
                            </td>
                        </tr>
                        <%
                            }
                        }
                        %>
                    </tbody>
                </table>
                    </div>

                    <button class="mt-2 btn btn-primary" onclick="imprimirTabla()">Imprimir Tabla</button>
                <%
                    // Resto del código

                                            // Crear un ArrayList para almacenar los datos de la tabla
                                            List<Map<String, Object>> datosTabla = new ArrayList<>();

                                            // Verificar si hay datos en la tabla
                                            if (datosCalificaciones != null && !datosCalificaciones.isEmpty()) {
                                                for (String idUsuarioStr : evaluacionesPorUsuario.keySet()) {
                                                    List<Object[]> evaluacionesUsuario = evaluacionesPorUsuario.get(idUsuarioStr);

                                                    // Crear un mapa para almacenar los datos de cada fila
                                                    Map<String, Object> fila = new HashMap<>();
                                                    fila.put("idUsuario", idUsuarioStr);
                                                    fila.put("nombreUsuario", evaluacionesUsuario.get(0)[4]);
                                                    fila.put("apellidoUsuario", evaluacionesUsuario.get(0)[5]);

                                                    // Inicializar la variable para almacenar la suma de las notas multiplicadas por el porcentaje
                                                    double sumaPromedios = 0.0;

                                                    // Crear un mapa para almacenar las calificaciones por evaluación
                                                    Map<String, Double> calificacionesPorEvaluacion = new HashMap<>();

                                                    for (String nombreEvaluacion : nombresEvaluaciones) {
                                                        for (Object[] calificacion : evaluacionesUsuario) {
                                                            if (nombreEvaluacion.equals(calificacion[1])) {
                                                                // Agregar la calificación al mapa
                                                                calificacionesPorEvaluacion.put(nombreEvaluacion, Double.parseDouble(calificacion[6].toString()));

                                                                // Calcular el promedio y sumarlo a la variable
                                                                double nota = Double.parseDouble(calificacion[6].toString());
                                                                double porcentaje = Double.parseDouble(calificacion[7].toString());
                                                                double promedio = nota * (porcentaje / 100);
                                                                sumaPromedios += promedio;
                                                            }
                                                        }
                                                    }

                                                    // Agregar las calificaciones al mapa de la fila
                                                    fila.put("calificaciones", calificacionesPorEvaluacion);
                                                    fila.put("promedio", sumaPromedios);
                                                    fila.put("fechaCalificacion", evaluacionesUsuario.get(0)[8]);

                                                    // Agregar la fila al arreglo de datos de la tabla
                                                    datosTabla.add(fila);
                                                }
                                            }


                                            // Puedes usar el arreglo datosTabla en tu JavaScript o pasarlo a tu controlador
                                            // usando request.setAttribute("datosTabla", datosTabla) antes de redirigir a otra página
                                            // o procesar los datos en el mismo JSP.
                                            // Aquí puedes imprimir los datos para verificar:
                                            session.setAttribute("datosTabla", datosTabla);
                                            //out.println("Datos de la tabla: " + datosTabla);
                                            %>
                                            <a href="<%= ProjectConstants.rutaBase %>GenerarPDF" class="mt-2 btn btn-primary">Imprimir promedios</a>

                    <%

                } else {
                %>
        <p>No hay calificaciones disponibles.</p>
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






    
    <script src="<%= ProjectConstants.rutaBase %>assets/vendor/libs/jquery/jquery.js"></script>
    <script src="<%= ProjectConstants.rutaBase %>assets/vendor/libs/popper/popper.js"></script>
    <script src="<%= ProjectConstants.rutaBase %>assets/vendor/js/bootstrap.js"></script>
    <script src="<%= ProjectConstants.rutaBase %>assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
    <script src="<%= ProjectConstants.rutaBase %>assets/vendor/js/menu.js"></script>
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>

    <!-- Main JS -->
    <script src="<%= ProjectConstants.rutaBase %>assets/js/main.js"></script>

    <!-- Page JS -->

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <!-- Agrega esto al final del archivo HTML, antes del cierre del cuerpo -->
<!-- Agrega esto al final del archivo HTML, antes del cierre del cuerpo -->
<script>
    function imprimirTabla() {
        // Obtener los estilos de la página principal
        var styles = document.styleSheets;

        // Crear una cadena para almacenar los estilos
        var stylesString = '';

        for (var i = 0; i < styles.length; i++) {
            // Solo agregar estilos que no sean de medios impresos
            if (styles[i].media.mediaText !== 'print') {
                stylesString += styles[i].ownerNode.outerHTML;
            }
        }

        // Obtener la tabla
        var tabla = document.getElementById("miTabla").outerHTML;

        // Abrir una nueva ventana o pestaña con estilos y tabla
        var nuevaVentana = window.open('', '_blank');
        nuevaVentana.document.write('<html><head><title>Tabla para impresión</title>');
        nuevaVentana.document.write(stylesString);  // Agregar estilos
        nuevaVentana.document.write('</head><body>');
        nuevaVentana.document.write(tabla);
        nuevaVentana.document.write('</body></html>');
        nuevaVentana.document.close();

        // Esperar a que la ventana se cargue completamente antes de imprimir
        nuevaVentana.onload = function () {
            nuevaVentana.print();
            nuevaVentana.onafterprint = function () {
                nuevaVentana.close();
            };
        };
    }
</script>




   

  </body>
</html>

