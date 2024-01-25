/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject;

/**
 *
 * @author EternoNR
 */
@WebServlet(name = "GenerarPDFServlet", urlPatterns = {"/GenerarPDF"})
public class GenerarPDFServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Obtén la lista de datos de la sesión
        List<Map<String, Object>> datosTabla = (List<Map<String, Object>>) request.getSession().getAttribute("datosTabla");

        // Configura la respuesta para generar un archivo PDF
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=calificaciones.pdf");

        try (PDDocument document = new PDDocument()) {
            // Crea una nueva página en el documento
            PDPage page = new PDPage();
            document.addPage(page);

            // Configura las dimensiones y márgenes de la página
            float margin = 20;
            float yStart = page.getMediaBox().getHeight() - margin;
            float tableWidth = page.getMediaBox().getWidth() - 2 * margin;
            float yPosition = yStart;
            float bottomMargin = 70;
            float yPositionNew = yPosition;

            // Configura las columnas y sus anchos
            float[] columnWidths = { 120f, 120f, 120f, 120f }; // Modifica según tus necesidades
            float tableHeight = 30f; // Altura de cada fila
            float cellMargin = 2f;

            boolean drawContent = true;
            int cols = columnWidths.length;

            try (PDPageContentStream contentStream = new PDPageContentStream(document, page)) {
                contentStream.setFont(PDType1Font.HELVETICA_BOLD, 12);

                // Agregar texto "Informe de Notas" en la parte superior izquierda
                contentStream.beginText();
                contentStream.newLineAtOffset(margin, yStart);
                contentStream.showText("Informe de Notas");
                contentStream.endText();

                // Agregar imagen en la parte superior derecha
                //PDImageXObject logo = PDImageXObject.createFromFile("ruta/a/tu/imagen.jpg", document);
                //contentStream.drawImage(logo, page.getMediaBox().getWidth() - 100, yStart - 20, 80, 40);

                // Mover el cursor a la posición inicial de la tabla
                yPositionNew -= 50; // Espacio entre el texto y la tabla

                // Encabezados de las columnas
                List<String> headers = Arrays.asList( "Nombre", "Apellido","Promedio", "Fecha");
                for (int col = 0; col < cols; col++) {
                    String headerText = headers.get(col);
                    float cellWidth = columnWidths[col];
                    float cellHeight = tableHeight;
                    contentStream.beginText();
                    contentStream.newLineAtOffset(margin + cellMargin + col * cellWidth, yPositionNew - cellMargin);
                    contentStream.showText(headerText);
                    contentStream.endText();
                }

                yPositionNew -= tableHeight; // Actualizar yPositionNew para la siguiente fila

          

                // Itera sobre los datos y dibuja la tabla en el PDF
                for (int i = 0; i < datosTabla.size() && drawContent; i++) {
                    Map<String, Object> fila = datosTabla.get(i);
                    List<String> rowContent = Arrays.asList(
                            fila.get("nombreUsuario").toString(),
                            fila.get("apellidoUsuario").toString(),
                            fila.get("promedio").toString(),
                            fila.get("fechaCalificacion").toString()
                    );

                    // Dibujar datos de calificaciones
                    float califMargin = 5f;
                    float califYPosition = yPositionNew - tableHeight - califMargin;
                    contentStream.beginText();
                    contentStream.setFont(PDType1Font.HELVETICA, 10);
                    contentStream.newLineAtOffset(margin + califMargin, califYPosition);

                  

                    contentStream.endText();

                    // Dibujar datos de la fila principal
                    for (int col = 0; col < cols; col++) {
                        String text = rowContent.get(col);
                        float cellWidth = columnWidths[col];
                        float cellHeight = tableHeight;
                        contentStream.beginText();
                        contentStream.newLineAtOffset(margin + cellMargin + col * cellWidth, yPositionNew - cellMargin);
                        contentStream.showText(text);
                        contentStream.endText();
                    }

                    yPosition = yPositionNew;
                    yPositionNew -= (tableHeight + califMargin); // Actualizar yPositionNew para la siguiente fila
                }
            }

            // Guarda el documento y envía el PDF al navegador
            document.save(response.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}






