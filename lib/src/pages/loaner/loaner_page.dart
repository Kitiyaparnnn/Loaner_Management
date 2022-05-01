import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loaner/src/blocs/appointment/bloc/appointment_bloc.dart';
import 'package:loaner/src/models/loaner/LoanerModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/pages/loaner/loaner_create_page.dart';
import 'package:loaner/src/pages/loaner/loaner_detail_page.dart';
import 'package:loaner/src/pages/loaner/loaner_sum_page.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/Constants.dart';
import 'package:loaner/src/utils/MyAppBar.dart';

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
  TextEditingController editingController = TextEditingController(text: "");
  LoanerModel _loaner = LoanerModel();
  bool isSearch = false;

  List<LoanerModel> loaners = [
    LoanerModel(
        name: 'LoanerA',
        detail: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
        rent: 0,
        note: ''),
    LoanerModel(
        name: 'LoanerB',
        detail: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
        image: '',
        rent: 0,
        note: ''),
    LoanerModel(
        name: 'LoanerC',
        detail: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
        image: '',
        rent: 0,
        note: ''),
    LoanerModel(
        name: 'LoanerD',
        detail: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
        image: '',
        rent: 0,
        note: ''),
  ];

  List<LoanerModel> items = [];
  int loanerCount = 0;

  @override
  void initState() {
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
                              builder: (context) => LoanerCreatePage()))),
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
    return TextField(
      onChanged: (value) {
        isSearch = !isSearch;
        filterSearchResults(value);
      },
      controller: editingController,
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(left: 10, top: 8, bottom: 8, right: 10),
          hintText: Constants.TEXT_SEARCH,
          hintStyle: TextStyle(fontSize: 16),
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          suffixIcon: editingController.text.isNotEmpty
              ? GestureDetector(
                  child: Icon(Icons.cancel_outlined),
                  onTap: () {
                    setState(() {
                      editingController.text = "";
                      items.clear();
                      items.addAll(loaners);
                    });
                  })
              : null),
    );
  }

  _loanerList() {
    return Expanded(
      child: loaners.isEmpty
          ? Center(
              child: Text(Constants.TEXT_DATA_NOT_FOUND),
            )
          : ListView.builder(
              itemCount: items.isNotEmpty ? items.length : loaners.length,
              itemBuilder: ((context, index) => items.isNotEmpty
                  ? _mapList(items, index)
                  : _mapList(loaners, index)),
            ),
    );
  }

  _mapList(List<LoanerModel> object, int index) {
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
              child: object[index].image != null ? null : Icon(Icons.image),
            ),
          ),
          title: Text(object[index].name!, style: TextStyle(fontSize: 16)),
          subtitle: Text(
            object[index].detail!,
            style: TextStyle(fontSize: 14, color: AppColors.COLOR_LIGHT),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () => widget.isFillForm
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoanerDetailPage(
                            loaner: object[index],
                          ))).then((value) => context
                  .read<AppointmentBloc>()
                  .add(AppointmentCountLoaner())) //bloc count selectedLoaners
              : null),
    );
  }
}
