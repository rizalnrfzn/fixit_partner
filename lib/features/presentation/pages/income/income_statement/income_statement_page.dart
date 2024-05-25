import 'dart:io';

import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';
import 'package:fixit_partner/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class IncomeStatementPage extends StatefulWidget {
  const IncomeStatementPage({super.key});

  @override
  State<IncomeStatementPage> createState() => _IncomeStatementPageState();
}

class _IncomeStatementPageState extends State<IncomeStatementPage> {
  late GlobalKey<FormState> formKey;
  late TextEditingController conFrom;
  late TextEditingController conTo;
  DateTime from = DateTime.now().subtract(const Duration(days: 30));
  DateTime to = DateTime.now();

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    conFrom = TextEditingController(text: DateFormat('dd/MM/yy').format(from));
    conTo = TextEditingController(text: DateFormat('dd/MM/yy').format(to));
    super.initState();
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    conFrom.dispose();
    conTo.dispose();
    super.dispose();
  }

  Future<void> getFromDate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: to,
      initialDate: from,
    );

    if (date != null) {
      setState(() {
        conFrom.text = DateFormat('dd/MM/yy').format(date);
        from = date;
      });
    }
  }

  Future<void> getToDate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: from,
      lastDate: DateTime.now(),
      initialDate: to,
    );

    if (date != null) {
      setState(() {
        conTo.text = DateFormat('dd/MM/yy').format(date);
        to = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Parent(
      appBar: MyAppBar(context, title: 'Download laporan pendapatan').call(),
      floatingButton: FilledButton(
        onPressed: _downloadPDF,
        style: FilledButton.styleFrom(
          foregroundColor: Palette.background,
          minimumSize: Size(400.w, 50.w),
        ),
        child: const Text('Download'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Text(
                  'Pilih periode',
                  style: textTheme.titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const Text('Rentang periode maksimum 1 tahun.'),
                const SizedBox(height: 24),
                const Text('Dari'),
                TextField(
                  controller: conFrom,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).hintColor),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).hintColor),
                    ),
                  ),
                  readOnly: true,
                  onTap: getFromDate,
                ),
                const SizedBox(height: 24),
                const Text('Sampai'),
                TextField(
                  controller: conTo,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).hintColor),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).hintColor),
                    ),
                  ),
                  readOnly: true,
                  onTap: getToDate,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _downloadPDF() async {
    final List<RepairOrder> orders = [];

    final filteredOrders = context
        .read<OrderCubit>()
        .orders
        .where((element) =>
            (element.status == 'pesananSelesai' ||
                element.status == 'beriUlasan') &&
            element.dateTime!.isAfter(from) &&
            element.dateTime!.isBefore(to))
        .toList();
    if (filteredOrders.isNotEmpty) {
      orders.addAll(filteredOrders);
      _generatePDF(orders);
    } else {
      'Tidak ada pendapatan'.toToastError(context);
    }
  }

  Future<void> _generatePDF(List<RepairOrder> orders) async {
    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();
    //Draw rectangle
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(PdfColor(142, 170, 219)));
    //Generate PDF grid.
    final PdfGrid grid = _getGrid(orders);
    //Draw the header section by creating text element
    final PdfLayoutResult result = _drawHeader(orders, page, pageSize, grid);
    //Draw grid
    _drawGrid(page, grid, result);

    //Save and dispose the document.
    final List<int> bytes = await document.save();
    document.dispose();

    //Get external storage directory
    final directory = await getApplicationSupportDirectory();

    final fileName = 'Income-${DateTime.now().toString()}';

    //Get directory path
    final path = directory.path;
    //Launch file.
    final File file = File('$path/$fileName.pdf');
    await file.writeAsBytes(bytes, flush: true);

    //Open the PDF document in mobile
    OpenFile.open('$path/$fileName.pdf');
  }

  //Draws the invoice header
  PdfLayoutResult _drawHeader(
      List<RepairOrder> orders, PdfPage page, Size pageSize, PdfGrid grid) {
    //Draw rectangle
    page.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(91, 126, 215)),
      bounds: Rect.fromLTWH(0, 0, pageSize.width, 60),
    );

    //Draw string
    page.graphics.drawString(
      'FixIt Partner',
      PdfStandardFont(PdfFontFamily.helvetica, 24),
      brush: PdfBrushes.white,
      bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 60),
      format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle),
    );

    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);

    final String periode =
        '${convertDateTimeToIndo(from)} - ${convertDateTimeToIndo(to)}';
    final Size contentSize = contentFont.measureString(periode);

    PdfTextElement(
            text: '${context.read<AuthCubit>().authUser?.name}',
            font: PdfStandardFont(PdfFontFamily.helvetica, 14,
                style: PdfFontStyle.bold))
        .draw(
      page: page,
      bounds: Rect.fromLTWH(
        30,
        90,
        pageSize.width - (contentSize.width + 30),
        pageSize.height - 120,
      ),
    );
    PdfTextElement(
            text: '${context.read<AuthCubit>().authUser?.phoneNumber}',
            font: contentFont)
        .draw(
      page: page,
      bounds: Rect.fromLTWH(
        30,
        110,
        pageSize.width - (contentSize.width + 30),
        pageSize.height - 120,
      ),
    );
    PdfTextElement(
            text: '${context.read<AuthCubit>().authUser?.email}',
            font: contentFont)
        .draw(
      page: page,
      bounds: Rect.fromLTWH(
        30,
        125,
        pageSize.width - (contentSize.width + 30),
        pageSize.height - 120,
      ),
    );

    PdfTextElement(text: 'Periode: ', font: contentFont).draw(
      page: page,
      bounds: Rect.fromLTWH(
        pageSize.width - (contentSize.width + 120),
        90,
        contentSize.width + 30,
        pageSize.height - 120,
      ),
    );

    PdfTextElement(
            text: periode, font: PdfStandardFont(PdfFontFamily.helvetica, 10))
        .draw(
      page: page,
      bounds: Rect.fromLTWH(
        pageSize.width - (contentSize.width + 120),
        105,
        contentSize.width + 30,
        pageSize.height - 120,
      ),
    );

    PdfTextElement(text: 'Total pendapatan:', font: contentFont).draw(
      page: page,
      bounds: Rect.fromLTWH(
        pageSize.width - (contentSize.width + 120),
        130,
        contentSize.width + 30,
        pageSize.height - 120,
      ),
    );
    return PdfTextElement(
            text: 'Rp${toThousand(_getTotalAmount(orders, grid))}',
            font: PdfStandardFont(PdfFontFamily.helvetica, 12,
                style: PdfFontStyle.bold))
        .draw(
      page: page,
      bounds: Rect.fromLTWH(
        pageSize.width - (contentSize.width + 120),
        145,
        contentSize.width + 30,
        pageSize.height - 120,
      ),
    )!;
  }

  //Draws the grid
  void _drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0))!;
  }

  //Create PDF grid and return
  PdfGrid _getGrid(List<RepairOrder> orders) {
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 8);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = 'Tanggal';
    headerRow.cells[1].value = 'ID Pesanan';
    headerRow.cells[2].value = 'Layanan';
    headerRow.cells[3].value = 'Elektronik';
    headerRow.cells[4].value = 'Alamat Pelanggan';
    headerRow.cells[5].value = 'Biaya Pengecekan';
    headerRow.cells[6].value = 'Biaya Perbaikan';
    headerRow.cells[7].value = 'Total Dibayar';

    // headerRow.cells[5].stringFormat.alignment = PdfTextAlignment.center;
    // headerRow.cells[6].stringFormat.alignment = PdfTextAlignment.center;
    // headerRow.cells[7].stringFormat.alignment = PdfTextAlignment.center;

    for (var order in orders) {
      _addOrder(order, grid);
    }

    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
    grid.columns[0].width = 50;
    grid.columns[1].width = 60;
    grid.columns[2].width = 48;
    grid.columns[4].width = 120;
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
  void _addOrder(RepairOrder order, PdfGrid grid) {
    final PdfGridRow row = grid.rows.add();
    row.cells[0].value =
        DateFormat('dd/MM/yyyy\nHH:mm:ss').format(order.dateTime!);
    row.cells[1].value = order.id;
    row.cells[2].value = 'Perbaikan Elektronik';
    row.cells[3].value = context
        .read<ElectronicCubit>()
        .electronics
        .firstWhere((element) => element.id == order.electronicId)
        .name;
    row.cells[4].value = order.clientAddress;
    row.cells[5].value = 'Rp${toThousand(order.checkingCost!)}';
    row.cells[6].value = 'Rp${toThousand(order.repairCost!)}';
    row.cells[7].value = 'Rp${toThousand(order.totalCost!)}';

    // row.cells[5].stringFormat.alignment = PdfTextAlignment.right;
    // row.cells[6].stringFormat.alignment = PdfTextAlignment.right;
    // row.cells[7].stringFormat.alignment = PdfTextAlignment.right;
  }

  //Get the total amount.
  int _getTotalAmount(List<RepairOrder> orders, PdfGrid grid) {
    int total = 0;

    for (var i = 0; i < orders.length; i++) {
      total += orders[i].totalCost!;
    }
    return total;
  }
}
