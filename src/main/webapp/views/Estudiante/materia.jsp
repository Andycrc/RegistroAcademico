<%@page import="models.Evaluacion"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="models.CalificacionUsuario"%>
<%@page import="models.UsuarioMateria"%>
<%@page import="java.util.List"%>
<%@page import="utils.ProjectConstants"%>
<%@page import="models.Usuario"%>
<%@page import="utils.SessionManager"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
  Usuario usuario = (Usuario) SessionManager.getAttribute(request, "Usuario");
  String nombreUsuario = "";
  int idEstudiante = 0;
  if (usuario != null) {
    nombreUsuario = usuario.getNombre() +" "+ usuario.getApellido();
    idEstudiante = usuario.getId();
  }// Suponiendo que "getNombre()" es el método para obtener el nombre de usuario en el objeto Usuario
%>
<%-- Obtener el nombre de la materia desde el atributo de la solicitud --%>
<%
  String nombreMateria = (String) request.getAttribute("nombreMateria");
%>

<%-- Declaración de la variable calificaciones --%>
<% List<Evaluacion> evaluaciones = (List<Evaluacion>) request.getAttribute("evaluaciones"); %>
<% List<CalificacionUsuario> calificaciones = (List<CalificacionUsuario>) request.getAttribute("calificaciones"); %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            #miTablaN{
                 max-height: 100vh; 
                 overflow-y: auto;
            }
        </style>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.2/html2pdf.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/pdf-lib@1.10.0/dist/pdf-lib.js"></script>


    </head>
    <body>
        <!-- Layout wrapper -->
        <div class="layout-wrapper layout-content-navbar">
            <div class="layout-container">
                <!-- Layout container -->
                <div class="layout-page">
                    <div class="content-wrapper">
                        <div class="container-xxl flex-grow-1 container-p-y">
                            <div class="card">
                                <div class="card-body" id="miTablaN">
                                    <h4 class="card-title mb-3"><%= nombreMateria %></h4>
                                    
                                    <button onclick="generarPDF()" type="button" class="btn btn-danger mb-3">
                                        <i class="far fa-file-pdf"></i>  Boleta de notas
                                    </button>
                                    
                                    <!-- ... -->
                                    <div class="table-responsive p-4" id="notas-container">
                                        
                                        <div class="row mb-3">
                                            <div class="col-md-12">
                                                <b>Materia:</b> <%= nombreMateria %>
                                            </div>
                                            <div class="col-md-12">
                                                <b>Alumno: </b> <%= nombreUsuario %>
                                            </div>
                                        </div>
                                        
                                        <table class="table mt-2 table-bordered table-striped table-condensed cf table-hover" id="notas-tabla">
                                            <thead class="cf">
                                                <tr>
                                                    <td></td>
                                                    <c:forEach var="evaluacion" items="${evaluaciones}">
                                                        <td class="text-center">
                                                            ${evaluacion.getNombre_evaluacion()}
                                                        </td>
                                                    </c:forEach>
                                                        <td class="text-center"></td>



                                                </tr>
                                            </thead>
                                            <tbody>

                                                <!-- PRIMERA COLUMNA -->
                                                <td>
                                                    <table style="width:100%; text-align:center;">
                                                        <tbody>
                                                            <tr style="border-bottom:0.5px solid;">
                                                                <th class="numeric" style="text-align:center">% </th>
                                                            </tr>
                                                            <tr style="">
                                                                <th class="numeric" style="text-align:center">Nota</th>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <!-- FIN PRIMERA COLUMNA -->  

                                                <c:forEach var="evaluacion" items="${evaluaciones}" varStatus="loopStatus">
                                                <td>
                                                    <table style="width:100%; text-align:center;">
                                                        <tbody>
                                                            <tr style="border-bottom:0.5px solid;">
                                                                <th class="numeric" style="text-align:center">${evaluacion.getPorcentajeCalificacion()}%</th>
                                                            </tr>
                                                            <tr style="">
                                                                <th class="numeric" style="text-align:center">
                                                                    ${calificaciones[loopStatus.index].getCalificacion() ne null ? calificaciones[loopStatus.index].getCalificacion() : '0.0'}
                                                                </th>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </c:forEach>
                                                    <!-- Total de la multiplicación del porcentaje con la nota -->
                                                    <td>
                                                        <table style="width:100%; text-align:center;">
                                                            <thead>
                                                                <tr>
                                                                    <td></td>
                                                                    <td></td>
                                                                    <td></td>
                                                                </tr>
                                                            </thead>
                                                            <tbody class="text-center">
                                                                <tr >
                                                                    <td class="border-end" style="vertical-align:middle; text-align:center; padding-right: 20px">
                                                                        <%
                                                                            double total = 0;
                                                                            for (int i = 0; i < calificaciones.size(); i++) {
                                                                                total += (evaluaciones.get(i).getPorcentajeCalificacion() / 100) * calificaciones.get(i).getCalificacion();
                                                                            }
                                                                            out.print(total);
                                                                        %>
                                                                    </td>

                                                                    <!-- Estado de Aprobación/Reprobación -->
                                                                    <td c style="vertical-align:middle; text-align:center;">
                                                                        <%
                                                                            // Verifica si el total es mayor o igual a 7 y muestra "Aprobado" o "Reprobado"
                                                                            if (total >= 7) {
                                                                                out.print("Aprobado");
                                                                            } else {
                                                                                out.print("Reprobado");
                                                                            }
                                                                        %>
                                                                    </td>



                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                            </tbody>
                                        </table>
                                    </div>
                                    <!-- ... -->
                                </div>
                            </div>
                            <!-- Footer -->
                            <footer class="content-footer footer bg-footer-theme">
                                <div class="container-xxl d-flex flex-wrap justify-content-between py-2 flex-md-row flex-column">
                                    <div id="year" class="mb-2 mb-md-0">
                                        © <span id="currentYear"></span> UNICAES
                                    </div>
                                </div>
                            </footer>
                           


                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js" integrity="sha512-GsLlZN/3F2ErC5ifS5QtgpiJtWd43JWSuIgh7mbzZ8zBps+dvLusV+eNQATqgA/HdeKFVgA5v3S/cIrLF7QnIg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script>
        // Obtén el elemento span por su id
        var yearSpan = document.getElementById("currentYear");

        // Obtiene el año actual
        var currentYear = new Date().getFullYear();

        // Actualiza el contenido del span con el año actual
        yearSpan.innerHTML = currentYear;
    </script>
    <script>
        
        function generarPDF(){
            const notasTabla = document.getElementById("notas-container");
            
            const fileName = "NOTAS_<%= nombreUsuario %>";

            var opt = {
                margin:       1,
                filename:     fileName,
              };

            html2pdf().set(opt).from(notasTabla).save();

        }
        
    </script>
 
</html>
