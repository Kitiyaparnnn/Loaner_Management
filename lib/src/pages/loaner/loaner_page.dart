import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loaner/src/blocs/appointment/bloc/appointment_bloc.dart';
import 'package:loaner/src/blocs/loaner/bloc/loaner_bloc.dart';
import 'package:loaner/src/models/loaner/LoanerModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/pages/loaner/loaner_create_page.dart';
import 'package:loaner/src/pages/loaner/loaner_detail_page.dart';
import 'package:loaner/src/pages/loaner/loaner_sum_page.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/Constants.dart';
import 'package:loaner/src/utils/MyAppBar.dart';
import 'package:path_provider/path_provider.dart';

class LoanerPage extends StatefulWidget {
  LoanerPage(
      {required this.isFillForm,
      required this.selectedLoaner,
      required this.isEdit});
  bool isFillForm;
  List<LoanerModel> selectedLoaner;
  bool isEdit;
  @override
  State<LoanerPage> createState() => _LoanerPageState();
}

class _LoanerPageState extends State<LoanerPage> {
  TextEditingController searchController = TextEditingController(text: "");

  List<LoanerModel> loaners = [
    LoanerModel(
        name: 'LoanerA',
        detail: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
        rent: 0,
        note: '')
  ];

  List<LoanerModel> items = [];
  int loanerCount = 0;

  @override
  void initState() {
    context.read<LoanerBloc>().add(LoanerGetAll());
    context.read<AppointmentBloc>().add(AppointmentCountLoaner());
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
    print(items.toList());
  }

  @override
  Widget build(BuildContext context) {
    // logger.d(widget.selectedLoaner);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.COLOR_SWATCH,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined, color: AppColors.COLOR_BLACK),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Column(
            children: [
              Text(
                Constants.LOANER_SUM_TITLE,
                style: TextStyle(
                  color: AppColors.COLOR_BLACK,
                ),
              )
            ],
          ),
          actions: widget.isFillForm
              ? null
              : [
                  IconButton(
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: AppColors.COLOR_BLACK,
                        size: 30,
                      ),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoanerCreatePage(
                                    isEdit: false,
                                    loanerId: '',
                                  ))).then((value) =>
                          context.read<LoanerBloc>().add(LoanerGetAll()))),
                ],
          centerTitle: true,
        ),
        floatingActionButton: widget.isFillForm
            ? BlocBuilder<AppointmentBloc, AppointmentState>(
                builder: (context, state) {
                  if (state is AppointmentStateCountLoaner) {
                    loanerCount = state.loanerCount;
                  }
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: const EdgeInsets.all(15.0)),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoanerSumPage(
                                  isEdit: widget.isEdit,
                                ))),
                    child: loanerCount != 0
                        ? Image.asset(
                            '${Constants.IMAGE_DIR}/basket-notemt.png')
                        : Image.asset('${Constants.IMAGE_DIR}/basket-emt.png'),
                  );
                },
              )
            : null,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Center(
                  child: Column(
                children: [
                  _searchBar(),
                  SizedBox(height: 20),
                  _loanerList(),
                ],
              )),
            ),
          ),
        ));
  }

  _searchBar() {
    return BlocBuilder<LoanerBloc, LoanerState>(
      builder: (context, state) {
        return TextField(
          onChanged: (value) {
            // filterSearchResults(value);
            context.read<LoanerBloc>().add(LoanerSearchType(textSearch: value));
          },
          controller: searchController,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(left: 10, top: 8, bottom: 8, right: 10),
              hintText: Constants.TEXT_SEARCH,
              hintStyle: TextStyle(fontSize: 16),
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              suffixIcon: searchController.text != ""
                  ? GestureDetector(
                      child: Icon(Icons.cancel_outlined),
                      onTap: () {
                        searchController.text = "";
                        context
                            .read<LoanerBloc>()
                            .add(LoanerSearchType(textSearch: ""));
                      })
                  : null),
        );
      },
    );
  }

  _loanerList() {
    return BlocBuilder<LoanerBloc, LoanerState>(
      builder: (context, state) {
        List<LoanerModel> loaner = [];
        if (state is LoanerStateGetAll) {
          loaner = state.data;
        }
        return Expanded(
          child: loaners.isEmpty
              ? Center(
                  child: Text(Constants.TEXT_DATA_NOT_FOUND),
                )
              : ListView.builder(
                  itemCount: loaner.length,
                  itemBuilder: ((context, index) => _mapList(loaner, index)),
                ),
        );
      },
    );
  }

  late File imageFile;
  _mapList(List<LoanerModel> object, int index) {
    if (object[index].image != "") {
      // decodeImage(object[index].image!);
      // print(imageFile.path);
      // logger.w(object[index].image!);
    }

    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: AppColors.COLOR_WHITE,
        elevation: 0.0,
        child: ListTile(
          leading: SizedBox(
            height: 60,
            width: 60,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.COLOR_GREY,
                  border: Border.all(color: AppColors.COLOR_GREY, width: 2.0)),
              child: object[index].image != ""
                  ?
                  // Image.memory(base64.decode("object[index].image!"))
                  // Image.file(File(imageFile.path))
                  null
                  : Icon(Icons.image),
            ),
          ),
          title: Text(object[index].name!, style: TextStyle(fontSize: 16)),
          subtitle: Text(
            object[index].detail!,
            style: TextStyle(fontSize: 14, color: AppColors.COLOR_LIGHT),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            if (widget.isFillForm) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoanerDetailPage(
                            loaner: object[index],
                          ))).then((value) => context
                  .read<AppointmentBloc>()
                  .add(AppointmentCountLoaner()));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoanerCreatePage(
                          isEdit: true, loanerId: object[index].id!))).then(
                  (value) => context.read<LoanerBloc>().add(LoanerGetAll()));
            }
            //bloc count selectedLoaners
          },
        ));
  }

  decodeImage(String img64) async {
    Uint8List byte = base64Decode(img64);
    String dir = (await getApplicationDocumentsDirectory()).path;
    imageFile = File('$dir/testImage.png');
    imageFile.writeAsBytesSync(byte);
    setState(() {});
    // print(imageFile.path);
  }
}
