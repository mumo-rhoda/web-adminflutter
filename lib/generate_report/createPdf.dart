import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_web_dashboard/models/dispatch.dart';
import 'package:flutter_web_dashboard/models/emegercies.dart';
import 'package:flutter_web_dashboard/models/users.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter_web_dashboard/generate_report/mobile.dart' if (dart.library.html) 'package:flutter_web_dashboard/generate_report/web.dart';


Future<void> createPDF(List<Emergencies> Emergencies, List<Users> clients, List<Dispatch> rescues) async {


  //Create a PDF document.
  final PdfDocument document = PdfDocument();
  //Add page to the PDF
  final PdfPage page = document.pages.add();
  //Get page client size
  final Size pageSize = page.getClientSize();
  //Draw rectangle
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
      pen: PdfPen(PdfColor(250, 83, 71, 255)));
  //Generate PDF grid.
  final PdfGrid grid = getGrid(Emergencies, rescues, clients);
  //Draw the header section by creating text element
  final PdfLayoutResult result = drawHeader(page, pageSize, grid, Emergencies);
  //Draw grid
  drawGrid(page, grid, result);
  //Save the PDF document
  final List<int> bytes = document.save();
  //Dispose the document.
  document.dispose();
  //Save and launch the file.
  await saveAndLaunchFile(bytes, 'report.pdf');
}

//Draws the invoice header
PdfLayoutResult drawHeader(PdfPage page, Size pageSize, PdfGrid grid, List<Emergencies> Emergencies) {
  //Draw rectangle
  page.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(250, 83, 71, 255)),
      bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));

  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
      brush: PdfSolidBrush(PdfColor(250, 83, 71)));

  page.graphics.drawString(
      'Report', PdfStandardFont(PdfFontFamily.helvetica, 30),
      brush: PdfBrushes.white,
      bounds: Rect.fromLTWH(25, 0, pageSize.width - 50, 90),
      format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

  final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 12);



  //Create data format and convert it to text.
  final DateFormat format = DateFormat.yMMMMd('en_US');
  final String date = '' +
      format.format(DateTime.now());

  //Draw string
  page.graphics.drawString('$date', contentFont,
      brush: PdfBrushes.white,
      bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.bottom));

  // ignore: leading_newlines_in_multiline_strings
   String totalNumber = '''Total: ${Emergencies.length.toString()} Emergencies ''';
  final Size contentSize = contentFont.measureString(totalNumber);
  return PdfTextElement(text: totalNumber, font: contentFont).draw(
      page: page,
      bounds: Rect.fromLTWH(30, 120,
          pageSize.width - (contentSize.width + 30), pageSize.height));


}
void drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
  Rect totalPriceCellBounds;
  Rect quantityCellBounds;
  //Invoke the beginCellLayout event.
  grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
    final PdfGrid grid = sender as PdfGrid;
    if (args.cellIndex == grid.columns.count - 1) {
      totalPriceCellBounds = args.bounds;
    } else if (args.cellIndex == grid.columns.count - 2) {
      quantityCellBounds = args.bounds;
    }
  };
  //Draw the PDF grid and get the result.
  result = grid.draw(
      page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0));


}



//Create PDF grid and return
PdfGrid getGrid(List<Emergencies> emergencies, List<Dispatch> rescues, List<Users> clients) {
  //Create a PDF grid
  final PdfGrid grid = PdfGrid();
  //Secify the columns count to the grid.
  grid.columns.add(count: 6);
  //Create the header row of the grid.
  final PdfGridRow headerRow = grid.headers.add(1)[0];
  //Set style
  headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(250, 83, 71));
  headerRow.style.textBrush = PdfBrushes.white;
  headerRow.cells[0].value = 'No';
  headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
  headerRow.cells[1].value = "Victim\'s Name";
  headerRow.cells[2].value = 'Type';
  headerRow.cells[3].value = 'Description';
  headerRow.cells[4].value = 'Responder';
  headerRow.cells[5].value = 'Date';




  emergencies.forEach((request) {
    int id = emergencies.indexOf(request)+1;
    Dispatch mDispatch = new Dispatch();
    Users mClient = new Users();


    if(clients.where((client) => client.uid == request.VictimID).toList().isNotEmpty){
      mClient = clients.where((client) => client.uid == request.VictimID).toList().first;
    }

    addProducts(
        id.toString(),
        "${mClient.username} ${mClient.fullname}",
       "${request.ReportType} ",
       "${request.Description}",
        "${mDispatch.Name}",
        getDateTime(request.dateTime),
        grid);

  });
  //Apply the table built-in style
  //gridTable1LightAccent1
  grid.applyBuiltInStyle(PdfGridBuiltInStyle.gridTable1Light);
  //Set gird columns width
  grid.columns[1].width = 200;
  for (int i = 0; i < headerRow.cells.count; i++) {
    headerRow.cells[i].style.cellPadding =
        PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
  }
  for (int i = 0; i < grid.rows.count; i++) {
    final PdfGridRow row = grid.rows[i];
    for (int j = 0; j < row.cells.count; j++) {
      final PdfGridCell cell = row.cells[j];
      if (j == 0) {
        cell.stringFormat.alignment = PdfTextAlignment.center;
      }
      cell.style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
  }
  return grid;
}

//Create and row for the grid.
void addProducts(String no, String names, String reportType, String description, String responder,String date, PdfGrid grid) {
  final PdfGridRow row = grid.rows.add();
  row.cells[0].value = no;
  row.cells[1].value = names;
  row.cells[2].value = reportType;
  row.cells[3].value = description;
  row.cells[4].value = responder;
  row.cells[5].value = date;
}







Future<Uint8List> _readImageData(String name) async {
  final data = await rootBundle.load('assets/images/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}
String getDateTime(DateTime dateTime){
  return DateFormat('dd-MM-yyyy HH:mm:ss').format(dateTime);
}