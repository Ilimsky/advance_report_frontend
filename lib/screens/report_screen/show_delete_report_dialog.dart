import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/report_provider.dart';

void showDeleteReportDialog(BuildContext context, int reportId) {
  final reportProvider = Provider.of<ReportProvider>(context, listen: false);

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Удалить отчет'),
      content: Text('Вы уверены, что хотите удалить этот отчет?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            reportProvider.deleteReport(reportId);
            Navigator.pop(context);
          },
          child: Text('Удалить', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}