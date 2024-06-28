import 'package:adir_web_app/pages/questions_page/questions_page.dart';
import 'package:flutter/material.dart';

class CoversInfoWidget extends StatelessWidget {
  const CoversInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cover Tables'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            ScenarioTable(
              title: 'Scenario 1: Cars with model years between 2021 and 2024',
              rows: const [
                DataRow(cells: [
                  DataCell(Text('Valet Parking')),
                  DataCell(Text('Yes')),
                  DataCell(Text('No')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Partial theft')),
                  DataCell(Text('Yes')),
                  DataCell(Text('No')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Vehicle Agency Repair')),
                  DataCell(Text('Yes')),
                  DataCell(Text('No')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Depreciation on new spare parts')),
                  DataCell(Text('No')),
                  DataCell(Text('Yes')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Earthquake')),
                  DataCell(Text('Yes')),
                  DataCell(Text('No')),
                ]),
                DataRow(cells: [
                  DataCell(Text('SRCC')),
                  DataCell(Text('Yes')),
                  DataCell(Text('No')),
                ]),
                DataRow(cells: [
                  DataCell(Text(
                      'Registration Car in case of Accident or Total Loss')),
                  DataCell(Text('Yes')),
                  DataCell(Text('Optional')),
                ]),
              ],
            ),
            ScenarioTable(
              title: 'Scenario 2: Cars with model years 2019 & 2020',
              rows: const [
                DataRow(cells: [
                  DataCell(Text('Valet Parking')),
                  DataCell(Text('Yes')),
                  DataCell(Text('No')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Partial theft')),
                  DataCell(Text('Yes')),
                  DataCell(Text('No')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Vehicle Agency Repair')),
                  DataCell(Text('Yes')),
                  DataCell(Text('No')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Depreciation on new spare parts')),
                  DataCell(Text('No')),
                  DataCell(Text('Yes')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Earthquake')),
                  DataCell(Text('Yes')),
                  DataCell(Text('No')),
                ]),
                DataRow(cells: [
                  DataCell(Text('SRCC')),
                  DataCell(Text('Yes')),
                  DataCell(Text('No')),
                ]),
                DataRow(cells: [
                  DataCell(Text(
                      'Registration Car in case of Accident or Total Loss')),
                  DataCell(Text('Yes')),
                  DataCell(Text('Optional')),
                ]),
              ],
            ),
            ScenarioTable(
              title: 'Scenario 3: Cars with model years between 2009 & 2018',
              rows: const [
                DataRow(cells: [
                  DataCell(Text('Valet Parking')),
                  DataCell(Text('Yes')),
                  DataCell(Text('No')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Partial theft')),
                  DataCell(Text('Yes')),
                  DataCell(Text('No')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Vehicle Agency Repair')),
                  DataCell(Text('Yes')),
                  DataCell(Text('No')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Depreciation on new spare parts')),
                  DataCell(Text('No')),
                  DataCell(Text('Yes')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Earthquake')),
                  DataCell(Text('Yes')),
                  DataCell(Text('No')),
                ]),
                DataRow(cells: [
                  DataCell(Text('SRCC')),
                  DataCell(Text('Yes')),
                  DataCell(Text('No')),
                ]),
                DataRow(cells: [
                  DataCell(Text(
                      'Registration Car in case of Accident or Total Loss')),
                  DataCell(Text('Yes')),
                  DataCell(Text('Optional')),
                ]),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Back'),
                    ),
                    const SizedBox(width: 50),
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        QuestionsPage(
                                          index: 4,
                                        ),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero));
                      },
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

class ScenarioTable extends StatelessWidget {
  final String title;
  final List<DataRow> rows;

  ScenarioTable({required this.title, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          DataTable(
            columns: const [
              DataColumn(label: Text('Coverage & Benefits')),
              DataColumn(label: Text('MPF')),
              DataColumn(label: Text('MRF')),
            ],
            rows: rows,
          ),
        ],
      ),
    );
  }
}
