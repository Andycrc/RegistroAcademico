<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Map"%>
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

    <!-- Page CSS -->
    <!-- Page -->
    <link rel="stylesheet" href="<%= ProjectConstants.rutaBase %>assets/vendor/css/pages/page-auth.css" />

    <!-- Helpers -->
    <script src="<%= ProjectConstants.rutaBase %>assets/vendor/js/helpers.js"></script>
    <script src="<%= ProjectConstants.rutaBase %>assets/js/config.js"></script>
    
    <!-- Jquery -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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
                <div>Calificaciones</div>
               
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
        // Recupera los datos de la sesión
        List<Map<String, Object>> datosTabla = (List<Map<String, Object>>) session.getAttribute("datosTabla");

        // Verifica si los datos existen y no están vacíos
        if (datosTabla != null && !datosTabla.isEmpty()) {
    %>
        <!-- Gráfico de Promedios -->
        <div>
              
            <h2>Datos globales</h2>
             <select id="tipoGrafico"  class="form-select" onchange="actualizarGrafico()">
                    <option value="bar">Gráfico de Barras</option>
                    <option value="line">Gráfico de linea</option>
                    <option value="doughnut">Gráfico de Dona</option>
                    <option value="radar">Gráfico Radar</option>
                </select>
            <canvas id="graficoCalificaciones" width="400" height="200"></canvas>

        </div>
        <div>
             <h2>Gráfico de Promedios</h2>
             <canvas id="graficoPromedios" width="400" height="100"></canvas> 
        </div>
      
       
        <div class="row">
            <div class="col-md-6">
                  <h2>5 Mejores Promedios</h2>
                  <canvas id="graficoMejoresPromedios" width="400" height="200"></canvas> 
            </div>
             <div class="col-md-6">
                <h2>5 Peores Promedios</h2>
                <canvas id="graficoPeoresPromedios" width="400" height="200"></canvas>
            </div>
              
        </div>
    
<script>
    // Variables globales para almacenar referencias a los gráficos
    var myChartCalificaciones;

   // Extrae los datos de calificaciones para el gráfico
    var datosCalificaciones = <%= new Gson().toJson(datosTabla) %>;
    
    // Ordena los datos por promedio de menor a mayor
    datosCalificaciones.sort(function(a, b) {
        return a.promedio - b.promedio;
    });
    // Extrae los nombres de usuario
    var nombresUsuarios = datosCalificaciones.map(function(item) {
        return item.nombreUsuario + " " + item.apellidoUsuario;
    });

    // Extrae las categorías de calificaciones y ordénalas
    var categoriasCalificaciones = Object.keys(datosCalificaciones[0].calificaciones).sort();

    // Prepara los datos para el gráfico
    var datosGrafico = categoriasCalificaciones.map(function(categoria) {
        return {
            label: categoria,
            data: datosCalificaciones.map(function(item) {
                return item.calificaciones[categoria];
            }),
        };
    });
    
    function actualizarGrafico() {
        // Destruye el gráfico anterior si existe
        if (myChartCalificaciones) {
            myChartCalificaciones.destroy();
        }

        var tipoSeleccionado = document.getElementById('tipoGrafico').value;

        // Lógica para actualizar el tipo de gráfico
        if (tipoSeleccionado === 'bar') {
            // Crea un gráfico de barras
            crearGraficoBarras();
        } else if (tipoSeleccionado === 'line') {
            // Crea un gráfico de pastel
            crearGraficoPastel();
        } else if (tipoSeleccionado === 'doughnut') {
            // Crea un gráfico de dona
            crearGraficoDona();
        } else if (tipoSeleccionado === 'radar') {
            // Crea un gráfico radar
            crearGraficoRadar();
        }
    }

    // Aquí puedes definir las funciones para crear diferentes tipos de gráficos
    function crearGraficoBarras() {
        // Crea un gráfico de barras agrupadas usando Chart.js
        var ctxCalificaciones = document.getElementById('graficoCalificaciones').getContext('2d');
        myChartCalificaciones = new Chart(ctxCalificaciones, {
            type: 'bar',
            data: {
                labels: nombresUsuarios,
                datasets: datosGrafico,
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true,
                    },
                },
            },
        });
    }

    function crearGraficoPastel() {
        // Crea un gráfico de pastel usando Chart.js
        var ctxCalificaciones = document.getElementById('graficoCalificaciones').getContext('2d');
        myChartCalificaciones = new Chart(ctxCalificaciones, {
            type: 'line',
            data: {
                labels: nombresUsuarios,
                datasets: datosGrafico,
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true,
                    },
                },
            },
        });
    }

    function crearGraficoDona() {
        // Implementa la lógica para el gráfico de dona
          var ctxCalificaciones = document.getElementById('graficoCalificaciones').getContext('2d');
        myChartCalificaciones = new Chart(ctxCalificaciones, {
            type: 'doughnut',
            data: {
                labels: nombresUsuarios,
                datasets: datosGrafico,
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true,
                    },
                },
            },
        });
    }

    function crearGraficoRadar() {
        // Implementa la lógica para el gráfico radar
          var ctxCalificaciones = document.getElementById('graficoCalificaciones').getContext('2d');
        myChartCalificaciones = new Chart(ctxCalificaciones, {
            type: 'radar',
            data: {
                labels: nombresUsuarios,
                datasets: datosGrafico,
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true,
                    },
                },
            },
        });
    }

    // Llama a la función inicialmente para crear el gráfico inicial
    actualizarGrafico();
</script>



      

        <script>
            // Extrae los nombres completos de usuario y promedios para el gráfico
            var nombresCompletos = [<%
                for (int i = 0; i < datosTabla.size(); i++) {
                    Map<String, Object> fila = datosTabla.get(i);
                    out.print("'" + fila.get("nombreUsuario") + " " + fila.get("apellidoUsuario") + "'");
                    if (i < datosTabla.size() - 1) {
                        out.print(", ");
                    }
                }
            %>];

            var promedios = [<%
                for (Map<String, Object> fila : datosTabla) {
                    out.print(fila.get("promedio") + ", ");
                }
            %>];

            // Crea un gráfico de barras usando Chart.js
            var ctx = document.getElementById('graficoPromedios').getContext('2d');
            var myChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: nombresCompletos,
                    datasets: [{
                        label: 'Promedio',
                        data: promedios,
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
       </script>
       <!-- Gráfico de los 5 Mejores Promedios -->
       

        <script>
        // Ordena los datos por promedio de mayor a menor
            var datosOrdenados = <%= new Gson().toJson(datosTabla) %>;
            datosOrdenados.sort(function(a, b) {
                return b.promedio - a.promedio;
            });

            // Extrae los nombres completos de usuario y los 5 mejores promedios
            var nombresCompletosMejores = [];
            var mejoresPromedios = [];

            for (var i = 0; i < Math.min(5, datosOrdenados.length); i++) {
                nombresCompletosMejores.push("'" + datosOrdenados[i].nombreUsuario + " " + datosOrdenados[i].apellidoUsuario + "'");
                mejoresPromedios.push(datosOrdenados[i].promedio);
            }

        // Crea un gráfico de barras para los 5 mejores promedios usando Chart.js
        var ctxMejores = document.getElementById('graficoMejoresPromedios').getContext('2d');
        var myChartMejores = new Chart(ctxMejores, {
            type: 'bar',
            data: {
                labels: nombresCompletosMejores,
                datasets: [{
                    label: 'Promedio',
                    data: mejoresPromedios,
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',  // Green-like color
                    borderColor: 'rgba(75, 192, 192, 1)', 
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>


        <!-- Gráfico de los 5 Peores Promedios -->

    <script>
        // Ordena los datos por promedio de menor a mayor
        var datosOrdenadosPeores = <%= new Gson().toJson(datosTabla) %>;
        datosOrdenadosPeores.sort(function(a, b) {
            return a.promedio - b.promedio;
        });

        // Extrae los nombres completos de usuario y los 5 peores promedios
        var nombresCompletosPeores = [];
        var peoresPromedios = [];

        for (var i = 0; i < Math.min(5, datosOrdenadosPeores.length); i++) {
            nombresCompletosPeores.push("'" + datosOrdenadosPeores[i].nombreUsuario + " " + datosOrdenadosPeores[i].apellidoUsuario + "'");
            peoresPromedios.push(datosOrdenadosPeores[i].promedio);
        }

        // Crea un gráfico de barras para los 5 peores promedios usando Chart.js
        var ctxPeores = document.getElementById('graficoPeoresPromedios').getContext('2d');
        var myChartPeores = new Chart(ctxPeores, {
            type: 'bar',
            data: {
                labels: nombresCompletosPeores,
                datasets: [{
                    label: 'Promedio',
                    data: peoresPromedios,
                    backgroundColor: 'rgba(255, 99, 132, 0.2)',
                    borderColor: 'rgba(255, 99, 132, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
 
    




     

    <%
        } else {
    %>
        <p>No hay datos disponibles en la sesión.</p>
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



