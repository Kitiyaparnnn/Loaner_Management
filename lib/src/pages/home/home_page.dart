import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:loaner/src/models/MenuChoice.dart';
import 'package:loaner/src/models/MenuModel.dart';
import 'package:loaner/src/models/appointment/AppointmentDataModel.dart';
import 'package:loaner/src/pages/appointment/appointment_page.dart';
import 'package:loaner/src/pages/employee/employee_page.dart';
import 'package:loaner/src/pages/fill_appointment/fill_appointment_page.dart';
import 'package:loaner/src/pages/loaner/loaner_page.dart';
import 'package:loaner/src/services/SharedPreferencesService.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/AskForConfirmToLogout.dart';
import 'package:loaner/src/utils/Constants.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.isSupplier}) : super(key: key);
  bool isSupplier;

  @override
  State<HomePage> createState() => _HomePageState();
}

List<MenuChoice> choices = const <MenuChoice>[
  MenuChoice(
      title: '${Constants.TEXT_PROFILE}',
      icon: Icons.person_outlined,
      key: "PROFILE"),
  MenuChoice(
      title: '${Constants.TEXT_SETTING}', icon: Icons.settings, key: "SETTING"),
  MenuChoice(
      title: '${Constants.TEXT_LOGOUT}',
      icon: Icons.exit_to_app,
      key: "LOGOUT"),
];

List<AppointmentData> appointmentsData = [
  AppointmentData(
      hospitalName: "โรงพยาบาล ก",
      organizeName: "บริษัท ก",
      appDate: "22-04-2022",
      appTime: "12:00",
      status: Constants.status[0]),
  AppointmentData(
      hospitalName: "โรงพยาบาล ก",
      organizeName: "บริษัท ก",
      appDate: "22-04-2022",
      appTime: "12:00",
      status: Constants.status[1])
];

class _HomePageState extends State<HomePage> {
  void _select(MenuChoice choice) {
    switch (choice.key) {
      case "SETTING":
        {
          break;
        }
      case "LOGOUT":
        {
          askForConfirmToLogout(context);
          break;
        }
    }
  }

  @override
  void initState() {
    loading();
    getFullName();
    generateMenu();
    super.initState();
  }

  Future<void> getMachine() async {
    await generateMenu();
    if (this.mounted) {
      setState(() {});
    }
  }

  Future<void> loading() async {
    BotToast.showLoading();
    await Future<void>.delayed(Duration(seconds: 1));
    BotToast.closeAllLoading();
  }

  String fullName = "";

  Future<void> getFullName() async {
    final _sharedPreferencesService = SharedPreferencesService();
    fullName = await _sharedPreferencesService.preferenceGetFullName();
  }

  List<MenuModel> menuList = [];

  Future<void> generateMenu() async {
    menuList.clear();
    var _menu = widget.isSupplier
        ? <MenuModel>[
            MenuModel(
              name: "${Constants.FILL_APPOINT_TITLE}",
              route: FillAppointmentPage(),
              color: AppColors.COLOR_WHITE,
              subName: "กรอกการนัดหมาย",
              // imgName: "menu_event.png",
              isShow: true,
            ),
            MenuModel(
              name: "${Constants.APPOINTMENT_TITLE}",
              route: AppointmentPage(),
              color: AppColors.COLOR_WHITE,
              subName: "การนัดหมายทั้งหมด",
              // imgName: "menu_water.png",
              isShow: true,
            ),
            MenuModel(
              name: "${Constants.LOANER_TITLE}",
              route: LoanerPage(),
              color: AppColors.COLOR_WHITE,
              subName: "จัดการข้อมูล Loaner",
              // imgName: "menu_setting.png",
              isShow: true,
            ),
            MenuModel(
              name: "${Constants.EMPLOYEE_TITLE}",
              route: EmployeePage(),
              color: AppColors.COLOR_WHITE,
              subName: "จัดการเจ้าหน้าที่บริษัท",
              // imgName: "menu_setting.png",
              isShow: true,
            ),
          ]
        : <MenuModel>[
            MenuModel(
              name: "${Constants.CONFIRM_APPOINT_TITLE}",
              route: EmployeePage(),
              color: AppColors.COLOR_WHITE,
              subName: "ยืนยันกับเจ้าหน้าที่บริษัท",
              // imgName: "menu_event.png",
              isShow: true,
            ),
            MenuModel(
              name: "${Constants.APPOINTMENT_TITLE}",
              route: EmployeePage(),
              color: AppColors.COLOR_WHITE,
              subName: "การนัดหมายทั้งหมด",
              // imgName: "menu_water.png",
              isShow: true,
            ),
          ];

    _menu.map((menu) {
      if (menu.isShow) {
        menuList.add(menu);
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Container(
              height: double.maxFinite,
              child: Column(
                children: [
                  _buildAppBar(),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 10, bottom: 30),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDescribe(),
                            SizedBox(height: 20),
                            Text(
                              "หมวดหมู่",
                              style: TextStyle(
                                  color: AppColors.COLOR_BLACK,
                                  fontSize: 21,
                                  fontWeight: FontWeight.w400),
                            ),
                            _buildMenu(),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  "นัดหมายเร็วๆ นี้",
                                  style: TextStyle(
                                      color: AppColors.COLOR_BLACK,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w400),
                                ),
                                Spacer(),
                                Text(
                                  "ดูทั้งหมด",
                                  style: TextStyle(
                                    color: AppColors.COLOR_PRIMARY,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            _buildList()
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      // margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(),
          SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "สวัสดี ! 🖐🏻",
                style: TextStyle(fontSize: 21, color: AppColors.COLOR_BLACK),
              ),
              Text(
                "คุณ $fullName",
                style: TextStyle(fontSize: 14, color: AppColors.COLOR_LIGHT),
              ),
            ],
          ),
          Expanded(child: SizedBox(height: 15)),
          PopupMenuButton(
            child: Icon(Icons.more_vert_outlined, size: 30),
            onSelected: _select,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            itemBuilder: (context) {
              return choices.map((MenuChoice choice) {
                return PopupMenuItem<MenuChoice>(
                  value: choice,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        choice.icon,
                        color: choice.key == "LOGOUT"
                            ? AppColors.COLOR_RED
                            : AppColors.COLOR_BLACK,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          choice.title,
                          style: TextStyle(
                            fontSize: 16,
                            color: choice.key == "LOGOUT"
                                ? AppColors.COLOR_RED
                                : AppColors.COLOR_BLACK,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }).toList();
            },
          )
        ],
      ),
    );
  }

  Widget _buildDescribe() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
              colors: [AppColors.COLOR_BLUE, AppColors.COLOR_BLUE2])),
      padding: EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Loaner \nManagement",
            style: TextStyle(
                fontSize: 21,
                color: AppColors.COLOR_WHITE,
                fontWeight: FontWeight.w700,
                letterSpacing: 2),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10),
          Text(
            Constants.DESCRIBE_TITLE,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.COLOR_WHITE,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildMenu() {
    return Container(
      child: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(0),
        mainAxisSpacing: 20,
        crossAxisSpacing: 15,
        controller: ScrollController(keepScrollOffset: false),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: List.generate(menuList.length, (index) {
          String _menuName = menuList[index].name;
          String _subtitle = menuList[index].subName;
          // String _imgName = menuList[index].imgName;
          Widget _route = menuList[index].route;
          // bool _isShow = menuList[index].isShow;
          Color _color = menuList[index].color;

          return Visibility(
            visible: true,
            child: _buildMenuCard(
              menuName: _menuName,
              // imageName: "$_imgName",
              subtitle: _subtitle,
              color: _color,
              page: _route,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildMenuCard(
      {required String menuName,
      required String subtitle,
      required Color color,
      //  required String imageName,
      required Widget page}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _menuRoute(page: page),
        child: Container(
          height: double.maxFinite,
          padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   child: Image.asset(
                //     "${Constants.IMAGE_DIR}/$imageName",
                //     width: 70,
                //     height: 70,
                //   ),
                // ),
                SizedBox(height: 10),
                Wrap(
                  children: [
                    Text(
                      menuName,
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColors.COLOR_BLACK,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.COLOR_BLACK,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _menuRoute({required Widget page}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    ).then((value) => getMachine());
  }

  Widget _buildList() {
    return Container(
      height: double.maxFinite,
      child: ListView.builder(
        itemCount: appointmentsData.length,
        itemBuilder: (context, index) => Card(
          child: Row(children: [
            SizedBox(height: 30, width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appointmentsData[index].hospitalName!),
                Text("หน่วยงาน: ${appointmentsData[index].organizeName}"),
                Row(
                  children: [
                    Icon(Icons.calendar_month_outlined),
                    Text("วันที่นัดหมาย: ${appointmentsData[index].appDate}"),
                    SizedBox(width: 10),
                    Text("เวลา: ${appointmentsData[index].appTime}")
                  ],
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
