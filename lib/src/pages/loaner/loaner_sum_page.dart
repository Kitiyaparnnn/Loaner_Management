import 'package:flutter/material.dart';
import 'package:loaner/src/models/loaner/LoanerModel.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/Constants.dart';

class LoanerSumPage extends StatefulWidget {
  LoanerSumPage({Key? key}) : super(key: key);

  @override
  State<LoanerSumPage> createState() => _LoanerSumPageState();
}

class _LoanerSumPageState extends State<LoanerSumPage> {
  List<LoanerModel> selectedLoaners = [
    LoanerModel(name: 'LoanerA', detail: '...', image: '', no: 12, note: ''),
    LoanerModel(name: 'LoanerB', detail: '...', image: '', no: 10, note: ''),
    LoanerModel(name: 'LoanerC', detail: '...', image: '', no: 2, note: ''),
    LoanerModel(name: 'LoanerD', detail: '...', image: '', no: 4, note: ''),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(centerTitle: true, title: Text(Constants.LOANER_SUM_TITLE)),
      body: ListView(
        children: ListTile.divideTiles(
                color: Colors.blue, tiles: _mapList(selectedLoaners))
            .toList(),
      ),
    );
  }

  _mapList(List<LoanerModel> object) {
    return object.map(
      (loaner) => ListTile(
        leading: SizedBox(
            child: loaner.image == null
                ? null
                : CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(loaner.name!,
                        style: TextStyle(
                            fontSize: 10, color: AppColors.COLOR_WHITE)),
                  ),
            height: 50,
            width: 50),
        title: Text(loaner.name!),
        subtitle:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Detail: ${loaner.detail}',
            style: TextStyle(fontSize: 12),
          ),
          Text(
            '${loaner.no} รายการ',
            style: TextStyle(fontSize: 12),
          ),
          Text(
            'หมายเหตุ: ${loaner.note}',
            style: TextStyle(fontSize: 12),
          ),
        ]),
      ),
    );
  }
}
