import 'package:flutter/material.dart';

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
        body: ShoppingDataTable(),
      ),
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
          cells: <DataCell> [
            DataCell(Text("Lasagne")),
            DataCell(Text("Intermarché")),
            DataCell(Text("2"))
          ]
        )
      ],
    );
  }
}
