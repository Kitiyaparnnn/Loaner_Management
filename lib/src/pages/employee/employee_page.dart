import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loaner/src/blocs/employee/bloc/employee_bloc.dart';
import 'package:loaner/src/models/employee/EmployeeModel.dart';
import 'package:loaner/src/pages/employee/add_employee_page.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/Constants.dart';

class EmployeePage extends StatefulWidget {
  EmployeePage({Key? key}) : super(key: key);

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  TextEditingController searchController = TextEditingController();
  EmployeeModel _emp = EmployeeModel();

  List<EmployeeModel> employees = [
    EmployeeModel(
        username: 'user1',
        detail: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
        isTrained: true),
    EmployeeModel(username: 'user2', detail: '', isTrained: false),
    EmployeeModel(
        username: 'user3',
        detail: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
        isTrained: true),
  ];

  List<EmployeeModel> items = [];

  @override
  void initState() {
    items.clear();
    context.read<EmployeeBloc>().add(EmployeeGetAll());
    super.initState();
  }

  void filterSearchResults(String query) {
    List<EmployeeModel> dummyListData = [];
    if (query.isNotEmpty) {
      employees.forEach((item) {
        if (item.username!.contains(query)) {
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
        items.addAll(employees);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.COLOR_SWATCH,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined, color: AppColors.COLOR_BLACK),
          onPressed: () {
           
            Navigator.of(context).pop();
          },
        ),
        title: Column(
          children: [
            Text(
              Constants.EMPLOYEE_TITLE,
              style: TextStyle(
                color: AppColors.COLOR_BLACK,
              ),
            )
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.person_add_alt_1_outlined,
                  color: AppColors.COLOR_BLACK, size: 30),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddEmployeePage()))),
        ],
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _searchBar(),
                SizedBox(height: 20),
                Text("เจ้าหน้าที่ของบริษัท",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                _employeeList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _searchBar() {
    return BlocBuilder<EmployeeBloc, EmployeeState>(
      builder: (context, state) {
        return TextField(
          onChanged: (value) {
            // filterSearchResults(value);
            context.read<EmployeeBloc>().add(EmployeeSearch(textSearch: value));
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
              suffixIcon: searchController.text.isNotEmpty
                  ? GestureDetector(
                      child: Icon(Icons.cancel_outlined),
                      onTap: () {
                        setState(() {
                          searchController.text = "";
                          items.clear();
                        });
                      })
                  : null),
        );
      },
    );
  }

  _employeeList() {
    return BlocBuilder<EmployeeBloc, EmployeeState>(
      builder: (context, state) {
        if (state is EmployeeStateGetAll) {
          employees = state.data;
        }

        return Expanded(
          child: employees.isEmpty
              ? Center(
                  child: Text(Constants.TEXT_DATA_NOT_FOUND),
                )
              : ListView.builder(
                  itemCount: employees.length,
                  itemBuilder: ((context, index) => _mapList(employees, index)),
                ),
        );
      },
    );
  }

  _mapList(List<EmployeeModel> object, int index) {
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
        title: Text(object[index].username!, style: TextStyle(fontSize: 16)),
        subtitle:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          object[index].detail == ""
              ? SizedBox(
                  height: 1,
                )
              : Text(
                  object[index].detail!,
                  style: TextStyle(fontSize: 14, color: AppColors.COLOR_LIGHT),
                ),
          object[index].isTrained!
              ? Text('• ผ่านการอบรม',
                  style: TextStyle(fontSize: 12, color: AppColors.COLOR_GREEN2))
              : Text('• ไม่ผ่านการอบรม',
                  style: TextStyle(fontSize: 12, color: AppColors.COLOR_RED))
        ]),
      ),
    );
  }
}
