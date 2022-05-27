import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loaner/src/blocs/employee/bloc/employee_bloc.dart';
import 'package:loaner/src/models/employee/EmployeeModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/pages/employee/add_employee_page.dart';
import 'package:loaner/src/services/Urls.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/Constants.dart';
import 'package:loaner/src/utils/DefaultImage.dart';
import 'package:transparent_image/transparent_image.dart';

class EmployeePage extends StatefulWidget {
  EmployeePage({Key? key}) : super(key: key);

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  TextEditingController searchController = TextEditingController(text: "");

  @override
  void initState() {
    context.read<EmployeeBloc>().add(EmployeeGetAll());
    super.initState();
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
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddEmployeePage(
                            isEdit: false,
                            empId: "",
                          )))),
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
            context
                .read<EmployeeBloc>()
                .add(EmployeeSearchType(textSearch: value));
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
                            .read<EmployeeBloc>()
                            .add(EmployeeSearchType(textSearch: ""));
                      })
                  : null),
        );
      },
    );
  }

  _employeeList() {
    return BlocBuilder<EmployeeBloc, EmployeeState>(
      builder: (context, state) {
        List<EmployeeModel> employee = [];
        bool isLoading = false;
        if (state is EmployeeStateGetAll) {
          employee = state.data;
        }
        if (state is EmployeeStateLoading) {
          isLoading = true;
        }

        return isLoading
            ? CircularProgressIndicator()
            : Expanded(
                child: employee.isEmpty
                    ? Center(
                        child: Text(Constants.TEXT_DATA_NOT_FOUND),
                      )
                    : ListView.builder(
                        itemCount: employee.length,
                        itemBuilder: ((context, index) =>
                            _mapList(employee, index)),
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
      color: object[index].isActive == null
          ? AppColors.COLOR_GREY
          : object[index].isActive == "0"
              ? AppColors.COLOR_WHITE
              : AppColors.COLOR_GREY,
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
              child: object[index].image != ''
                  ? FadeInImage.memoryNetwork(
                      imageErrorBuilder: ((context, error, stackTrace) =>
                          defaultImage()),
                      placeholderErrorBuilder: (context, error, stackTrace) =>
                          defaultImage(),
                      fit: BoxFit.cover,
                      placeholder: kTransparentImage,
                      image: '${Urls.imageEmployeeUrl}/${object[index].image!}')
                  : Icon(Icons.image),
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
                    style:
                        TextStyle(fontSize: 14, color: AppColors.COLOR_LIGHT),
                  ),
            object[index].isTrained == "0"
                ? Text('• ผ่านการอบรม',
                    style:
                        TextStyle(fontSize: 12, color: AppColors.COLOR_GREEN2))
                : Text('• ไม่ผ่านการอบรม',
                    style: TextStyle(fontSize: 12, color: AppColors.COLOR_RED))
          ]),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddEmployeePage(
                        isEdit: true, empId: object[index].id!))).then(
                (value) => context.read<EmployeeBloc>().add(EmployeeGetAll()));
          }),
    );
  }
}
