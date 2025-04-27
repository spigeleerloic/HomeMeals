import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key});

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Shopping list")),
        body: EditableDataTable(),
      ),
    );
  }
}

class EditableDataTable extends StatefulWidget {
  const EditableDataTable({super.key});

  @override
  State<EditableDataTable> createState() => _EditableDataTableState();
}

class _EditableDataTableState extends State<EditableDataTable> {
  List<Map<String, dynamic>> data = [
    {'Item': "Poulet", 'Shop': "Delhaize", 'Quantity': "2"},
    {'Item': "Lasagne", 'Shop': "Intermarche", 'Quantity': "2"},
  ];

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text("Item")),
        DataColumn(label: Text("Shop")),
        DataColumn(label: Text("Quantity")),
      ],
      rows:
          data
              .asMap()
              .entries
              .map(
                (entry) => DataRow(
                  cells: [
                    DataCell(
                      TextField(
                        controller: TextEditingController(
                          text: entry.value['Item'],
                        ),
                        onChanged: (val) {
                          data[entry.key]['Item'] = val;
                        },
                      ),
                    ),
                    DataCell(
                      TextField(
                        controller: TextEditingController(
                          text: entry.value['Shop'],
                        ),
                        onChanged: (val) {
                          data[entry.key]['Shop'] = val;
                        },
                      ),
                    ),
                    DataCell(
                      TextField(
                        controller: TextEditingController(
                          text: entry.value['Quantity'],
                        ),
                        onChanged: (val) {
                          data[entry.key]['Quantity'] = val;
                        },
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
    );
  }
}

class ShoppingDataTable2 extends StatelessWidget {
  const ShoppingDataTable2({super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columns: const <DataColumn2>[
        DataColumn2(label: Expanded(child: Text("Item"))),
        DataColumn2(label: Expanded(child: Text("Shop"))),
        DataColumn2(label: Expanded(child: Text("Quantity"))),
      ],
      rows: <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text("Poulet")),
            DataCell(tagCell(["Delhaize, Colruyt", "Intermarche"])),
            DataCell(Text("2")),
          ],
        ),

        DataRow(
          cells: <DataCell>[
            DataCell(Text("Lasagne")),
            DataCell(Text("Intermarché")),
            DataCell(Text("2")),
          ],
        ),
      ],
    );
  }

  Widget tagCell(List<String> tags) {
    return Wrap(
      spacing: 6.0,
      children: tags.map((tag) => Chip(label: Text(tag))).toList(),
    );
  }
}

class ShoppingDataTable extends StatelessWidget {
  const ShoppingDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(label: Expanded(child: Text("Item"))),
        DataColumn(label: Expanded(child: Text("Shop"))),
        DataColumn(label: Expanded(child: Text("Quantity"))),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text("Poulet")),
            DataCell(Text("Delhaize")),
            DataCell(Text("2")),
          ],
        ),

        DataRow(
          cells: <DataCell>[
            DataCell(Text("Lasagne")),
            DataCell(Text("Intermarché")),
            DataCell(Text("2")),
          ],
        ),
      ],
    );
  }
}
