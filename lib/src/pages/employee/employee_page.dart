import 'package:flutter/material.dart';
import 'package:loaner/src/models/employee/EmployeeModel.dart';
import 'package:loaner/src/pages/employee/add_employee_page.dart';
import 'package:loaner/src/utils/AppColors.dart';

class EmployeePage extends StatefulWidget {
  EmployeePage({Key? key}) : super(key: key);

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  TextEditingController editingController = TextEditingController();
  EmployeeModel _emp = EmployeeModel();

  List<EmployeeModel> employees = [
    EmployeeModel(username: 'user1', detail: '', isTrained: true),
    EmployeeModel(username: 'user2', detail: '', isTrained: false),
    EmployeeModel(username: 'user3', detail: '', isTrained: true),
  ];

  List<EmployeeModel> items = [];

  @override
  void initState() {
    items.clear();
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
      appBar: AppBar(),
      backgroundColor: AppColors.COLOR_GREY,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _searchBar(),
                _employeeList(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddEmployeePage())),
                      child: Text('เพิ่ม')),
                )
              ],
            ),
          ),
        ),
      ),
    );
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

  _employeeList() {
    // print(items.length);
    return Expanded(
      child: ListView(
        children: ListTile.divideTiles(
          color: Colors.blue,
          tiles: items.length != 0
              ? items.map(
                  (employee) => ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(employee.username!,
                          style: TextStyle(
                              fontSize: 10, color: AppColors.COLOR_WHITE)),
                    ),
                    title: Text(employee.username!),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Detail: ${employee.detail}',
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                              employee.isTrained!
                                  ? 'Trained: เคย'
                                  : 'Trained: ไม่เคย',
                              style: TextStyle(fontSize: 12))
                        ]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {},
                    ),
                  ),
                )
              : employees.map(
                  (employee) => ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(employee.username!,
                          style: TextStyle(
                              fontSize: 10, color: AppColors.COLOR_WHITE)),
                    ),
                    title: Text(employee.username!),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Detail: ${employee.detail}',
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                              employee.isTrained!
                                  ? 'Trained: เคย'
                                  : 'Trained: ไม่เคย',
                              style: TextStyle(fontSize: 12))
                        ]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {},
                    ),
                  ),
                ),
        ).toList(),
      ),
    );
  }
}
