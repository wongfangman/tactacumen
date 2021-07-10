import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ECatalogue extends StatefulWidget {
  @override
  _ECatalogueState createState() => _ECatalogueState();
}

class _ECatalogueState extends State<ECatalogue> {
  PDFDocument document;

  changePDF(value) async {
    if (value == 1) {
      document = await PDFDocument.fromAsset('assets/pdf/tacumen1.pdf');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (content) => ECatalogue2(document: document)));
    } else if (value == 2) {
      document = await PDFDocument.fromAsset('assets/pdf/tacumen2.pdf');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (content) => ECatalogue2(document: document)));
    } else if (value == 3) {
      document = await PDFDocument.fromAsset('assets/pdf/malcomair.pdf');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (content) => ECatalogue2(document: document)));
    }
    // else if (value == 4) {
    //   document = await PDFDocument.fromURL(
    //     "http://conorlastowka.com/book/CitationNeededBook-Sample.pdf",
    //   );
    // }
    else {
      document = await PDFDocument.fromAsset('assets/pdf/tacumen1.pdf');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('E-CATALOGUE',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
          ],
        ),
        backgroundColor: Colors.blue[100],
        iconTheme: IconThemeData(color: Colors.black),
        toolbarHeight: 88,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          ListTile(
            title: Text('TACUMEN Screw Compressor'),
            leading: Icon(AntDesign.pdffile1),
            onTap: () {
              changePDF(1);
            },
          ),
          ListTile(
            title: Text('TACUMEN Piston Compressor'),
            leading: Icon(AntDesign.pdffile1),
            onTap: () {
              changePDF(2);
            },
          ),
          ListTile(
            title: Text('MALCOMAIR Air Compressor'),
            leading: Icon(AntDesign.pdffile1),
            onTap: () {
              changePDF(3);
            },
          ),
        ],
      ),
    );
  }
}

class ECatalogue2 extends StatefulWidget {
  final PDFDocument document;
  const ECatalogue2({Key key, this.document}) : super(key: key);
  @override
  _ECatalogueState2 createState() => _ECatalogueState2();
}

class _ECatalogueState2 extends State<ECatalogue2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('E-CATALOGUE',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold))
            ],
          ),
          backgroundColor: Colors.blue[100],
          iconTheme: IconThemeData(color: Colors.black),
          toolbarHeight: 88,
        ),
        body: Center(
          child: PDFViewer(
            document: widget.document,
            zoomSteps: 1,
          ),
        ),
      ),
    );
  }
}
