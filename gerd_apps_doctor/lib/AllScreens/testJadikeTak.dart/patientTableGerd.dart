import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//firebase

class PatientTable extends StatefulWidget {
  PatientTable({Key key}) : super(key: key);

  @override
  _PatientTableState createState() => _PatientTableState();
}

class Record {
  final String dietplan;
  final String scaleofpain;
  //final String timestamp;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['Diet Plan'] != null),
        assert(map['Scale of Pain'] != null),
        assert(map['timestamp'] != null),
        dietplan = map['Diet Plan'],
        scaleofpain = map['Scale of Pain'];
  //timestamp = map['timestamp'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  /*:$timestamp> */
  @override
  String toString() => "Record<$scaleofpain:$dietplan";
}

class _PatientTableState extends State<PatientTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient GERD Record'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: _tableBody(context),
      ),
    );
  }

  Widget _tableBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('gerdScaleOfPain').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        //return _buildList(context, snapshot.data.docs);
        return DataTable(
            headingRowColor:
                MaterialStateColor.resolveWith((states) => Colors.blue),
            columns: [
              //DataColumn(label: Text('Date')),
              DataColumn(label: Text('Diet Plan')),
              DataColumn(label: Text('GERD Scale of Pain')),
            ],
            rows: _buildList(context, snapshot.data.docs));
      },
    );
  }

  List<DataRow> _buildList(
      BuildContext context, List<DocumentSnapshot> snapshot) {
    return snapshot.map((data) => _buildListItem(context, data)).toList();
  }

  DataRow _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return DataRow(cells: [
      //DataCell(Text(record.timestamp.toDate())),
      DataCell(Text(record.dietplan)),
      DataCell(Text(record.scaleofpain)),
    ]);
  }
}
