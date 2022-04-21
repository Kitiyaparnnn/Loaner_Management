import 'package:flutter/material.dart';
import 'package:loaner/src/models/loaner/LoanerModel.dart';
import 'package:loaner/src/pages/loaner/loaner_detail_page.dart';
import 'package:loaner/src/pages/loaner/loaner_sum_page.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/Constants.dart';

class LoanerPage extends StatefulWidget {
  LoanerPage({Key? key}) : super(key: key);

  @override
  State<LoanerPage> createState() => _LoanerPageState();
}

class _LoanerPageState extends State<LoanerPage> {
  TextEditingController editingController = TextEditingController();
  LoanerModel _loaner = LoanerModel();
  List<LoanerModel> selectedLoaner = [];

  List<LoanerModel> loaners = [
    LoanerModel(name: 'LoanerA', detail: '...', image: '', no: 0, note: ''),
    LoanerModel(name: 'LoanerB', detail: '...', image: '', no: 0, note: ''),
    LoanerModel(name: 'LoanerC', detail: '...', image: '', no: 0, note: ''),
    LoanerModel(name: 'LoanerD', detail: '...', image: '', no: 0, note: ''),
  ];

  List<LoanerModel> items = [];

  @override
  void initState() {
    items.clear();
    super.initState();
  }

  void filterSearchResults(String query) {
    List<LoanerModel> dummyListData = [];
    if (query.isNotEmpty) {
      loaners.forEach((item) {
        if (item.name!.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(loaners);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Column(
                children: [
                  _searchBar(),
                  _loanerList(),
                  // Align(
                  //   alignment: Alignment.bottomLeft,
                  //   child: ElevatedButton(
                  //       onPressed: () => Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => LoanerSumPage())),
                  //       child: Text('รายการ')),
                  // )
                ],
              )),
            ),
          ),
        ));
  }

  _searchBar() {
    return TextField(
      onChanged: (value) {
        filterSearchResults(value);
      },
      controller: editingController,
      decoration: InputDecoration(
          labelText: "Search",
          hintText: "Search",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)))),
    );
  }

  _loanerList() {
    return Expanded(
      child: ListView(
        children: ListTile.divideTiles(
                color: Colors.blue,
                tiles: items.length != 0 ? _mapList(items) : _mapList(loaners))
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
        ]),
        trailing: IconButton(
          icon: Icon(Icons.arrow_forward_ios_outlined),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoanerDetailPage(
                        loaner: loaner,
                        selectedLoaner: selectedLoaner,
                      ))),
        ),
      ),
    );
  }
}
