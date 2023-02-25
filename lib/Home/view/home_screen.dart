import 'dart:typed_data';
import 'package:auto_print_app/Home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos_printer_platform/flutter_pos_printer_platform.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart' as pppp;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> items = [];
  String dropdownvalue = '';
  var devices = [];
  late Future _future;

  scan(PrinterType type, {bool isBle = false}) {
    devices = [];
    items = [];
    dropdownvalue = '';
    // Find printers
    PrinterManager.instance
        .discovery(type: type, isBle: isBle)
        .listen((device) {
      devices.add(device);
    });
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   scan(PrinterType.usb);
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text("Printing Demo"),centerTitle: true),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: height * .1),
            ElevatedButton(
                onPressed: ()  async {
                  scan(PrinterType.usb);
                  await 500.milliseconds.delay;
                  if(devices.isNotEmpty){
                    setState(() {
                      for (var e in devices) {
                        items.add(e.name);
                      }
                      print(items);
                      dropdownvalue = items.first;
                    });
                  }
                },
                child: const Text("Get Devices")),
            SizedBox(height: height * .1),
            Visibility(
              visible: items.isNotEmpty,
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 15,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: DropdownButton(
                        isExpanded: true,
                        isDense: false,
                        underline: const SizedBox(),
                        value: dropdownvalue,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (newValue) {
                          setState(() {
                            dropdownvalue = newValue.toString();
                            print(dropdownvalue);
                          });
                        },
                      ),
                    ),
                  )),
            ),
            SizedBox(height: height * .1),
            ElevatedButton(
                onPressed: () async {
                  if(items.isNotEmpty){
                    await pppp.Printing.directPrintPdf(
                        printer:  pppp.Printer(url: '$dropdownvalue'),
                        onLayout: (format) =>
                            _generatePdf(format: format, title: "Abdoo Hossam"));
                  }
                },
                child: const Text("Print")),
          ],
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(
      {required PdfPageFormat format, required String title}) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await pppp.PdfGoogleFonts.nunitoExtraLight();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.SizedBox(height: 60),
              pw.SizedBox(
                width: double.infinity,
                child: pw.FittedBox(
                  child: pw.Text(title, style: pw.TextStyle(font: font)),
                ),
              ),
              // pw.SizedBox(height: 20),
              // pw.Flexible(child: pw.FlutterLogo())
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
