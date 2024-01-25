<%@page import="org.apache.pdfbox.pdmodel.font.PDType1Font"%>
<%@ page import="org.apache.pdfbox.pdmodel.PDDocument" %>
<%@ page import="org.apache.pdfbox.pdmodel.PDPage" %>
<%@ page import="org.apache.pdfbox.pdmodel.PDPageContentStream" %>

<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>

<%@ page contentType="application/pdf" language="java" pageEncoding="UTF-8"%>
<%
    // Obtén los datos de la sesión
    List<Map<String, Object>> datosTabla = (List<Map<String, Object>>) session.getAttribute("datosTabla");

    // Define la ruta del servidor donde se guardará el PDF
    String pdfFilePath = getServletContext().getRealPath("/") + "calificaciones.pdf";

    // Crear un nuevo documento PDF
    try (PDDocument document = new PDDocument()) {
        PDPage page1= new PDPage();
        document.addPage(page1);

        try (PDPageContentStream contentStream = new PDPageContentStream(document, page1)) {
            // Configura la fuente y el tamaño del texto
            contentStream.setFont(PDType1Font.HELVETICA_BOLD, 12);
            contentStream.newLineAtOffset(20, 700);

            // Agrega un título al PDF
            contentStream.showText("Calificaciones");

            // Configura la fuente y el tamaño del texto para el contenido de la tabla
            contentStream.setFont(PDType1Font.HELVETICA, 10);
            contentStream.newLineAtOffset(0, -20);

            // Agrega los datos de la tabla al PDF
            for (Map<String, Object> fila : datosTabla) {
                contentStream.newLineAtOffset(0, -15);

                for (Object valor : fila.values()) {
                    contentStream.showText(valor.toString());
                    contentStream.newLineAtOffset(100, 0); // Espaciado entre columnas
                }
            }
        }

        // Guarda el documento PDF en el servidor
        document.save(pdfFilePath);
    }

    // Proporciona el enlace para descargar el PDF
    out.println("<a href='" + request.getContextPath() + "/calificaciones.pdf' download>Descargar PDF</a>");
%>
