import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:loaner/src/models/MenuChoice.dart';
import 'package:loaner/src/models/MenuModel.dart';
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
  const MenuChoice(
      title: '${Constants.TEXT_LOGOUT}',
      icon: Icons.exit_to_app,
      key: "LOGOUT"),
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
              color: AppColors.COLOR_PRIMARY,
              // imgName: "menu_event.png",
              isShow: true,
            ),
            MenuModel(
              name: "${Constants.APPOINTMENT_TITLE}",
              route: EmployeePage(),
              color: AppColors.COLOR_PRIMARY,
              // imgName: "menu_water.png",
              isShow: true,
            ),
            MenuModel(
              name: "${Constants.LOANER_TITLE}",
              route: LoanerPage(),
              color: AppColors.COLOR_PRIMARY,
              // imgName: "menu_setting.png",
              isShow: true,
            ),
            MenuModel(
              name: "${Constants.EMPLOYEE_TITLE}",
              route: EmployeePage(),
              color: AppColors.COLOR_PRIMARY,
              // imgName: "menu_setting.png",
              isShow: true,
            ),
          ]
        : <MenuModel>[
            MenuModel(
              name: "${Constants.CONFIRM_APPOINT_TITLE}",
              route: EmployeePage(),
              color: AppColors.COLOR_PRIMARY,
              // imgName: "menu_event.png",
              isShow: true,
            ),
            MenuModel(
              name: "${Constants.APPOINTMENT_TITLE}",
              route: EmployeePage(),
              color: AppColors.COLOR_PRIMARY,
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
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(top: 30, bottom: 30),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: _buildMenu(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ยินดีต้อนรับ $fullName",
                  style: TextStyle(fontSize: 16, color: Colors.black45),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 15),
                Text(
                  "เลือกเครื่องมือที่คุณ \nต้องการใช้งาน",
                  style: TextStyle(
                      fontSize: 20,
                      color: AppColors.COLOR_DARK,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          PopupMenuButton(
            child: Icon(Icons.more_horiz_outlined),
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
                        color: AppColors.COLOR_RED,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          choice.title,
                          style: TextStyle(
                              fontSize: 16, color: AppColors.COLOR_RED),
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
          // String _imgName = menuList[index].imgName;
          Widget _route = menuList[index].route;
          bool _isShow = menuList[index].isShow;

          return Visibility(
            visible: true,
            child: _buildMenuCard(
              menuName: "$_menuName",
              // imageName: "$_imgName",
              page: _route,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildMenuCard(
      {required String menuName,
      //  required String imageName,
      required Widget page}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: AppColors.COLOR_GREY),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => _menuRoute(page: page),
        child: Container(
          height: double.maxFinite,
          padding: EdgeInsets.only(left: 12, top: 10, right: 10, bottom: 10),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                      "$menuName",
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColors.COLOR_DARK,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
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
}
