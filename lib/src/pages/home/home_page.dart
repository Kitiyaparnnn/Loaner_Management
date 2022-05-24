import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:loaner/src/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:loaner/src/models/MenuChoice.dart';
import 'package:loaner/src/models/MenuModel.dart';
import 'package:loaner/src/models/appointment/AppointmentDataModel.dart';
import 'package:loaner/src/my_app.dart';
import 'package:loaner/src/pages/appointment/appointment_page.dart';
import 'package:loaner/src/pages/confirm_appointment/confirm_appointment_page.dart';
import 'package:loaner/src/pages/confirm_appointment/detail_appointment_page.dart';
import 'package:loaner/src/pages/employee/employee_page.dart';
import 'package:loaner/src/pages/fill_appointment/fill_appointment_page.dart';
import 'package:loaner/src/pages/loaner/loaner_page.dart';
import 'package:loaner/src/pages/splash/splash_page.dart';
import 'package:loaner/src/services/AppointmentService.dart';
import 'package:loaner/src/services/SharedPreferencesService.dart';
import 'package:loaner/src/services/Urls.dart';
import 'package:loaner/src/utils/AppColors.dart';
import 'package:loaner/src/utils/AskForConfirmToLogout.dart';
import 'package:loaner/src/utils/Constants.dart';
import 'package:loaner/src/utils/DefaultImage.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  HomePage();

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

List<AppointmentDataModel> appointmentsData = [
  AppointmentDataModel(
      hospitalId: "โรงพยาบาล ก",
      hosDeptId: "บริษัท ก",
      appDate: "22-04-2022",
      appTime: "12:00",
      status: Constants.status[0],
      loaners: []),
  AppointmentDataModel(
      hospitalId: "โรงพยาบาล ก",
      hosDeptId: "บริษัท ก",
      appDate: "28-04-2022",
      appTime: "12:00",
      status: Constants.status[1],
      loaners: [])
];

class _HomePageState extends State<HomePage> {
  final _sharedPreferencesService = SharedPreferencesService();

  String isSupplier = "";
  String fullName = "";
  String image = "";
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
    // loading2();
    loading();
    getUserData();
    super.initState();
  }

  String _convertToDay(String date) {
    final dateDatetime = DateFormat('dd-MM-yyyy').parse(date);

    String day = DateFormat('EEEE').format(dateDatetime);

    return day;
  }

  List<AppointmentDataModel> appointList = [];

  Future<void> getMachine() async {
    // logger.w("setMenuList");
    // final _appointmentService = AppointmentService();

    // appointList =
    //     await _appointmentService.getAppointments(status: Constants.status[2]);
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

  Widget loading2() {
    return Container(
        color: AppColors.COLOR_PRIMARY,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("${Constants.IMAGE_DIR}/logo.png"),
            SizedBox(
              height: 10,
            ),
            SpinKitThreeBounce(
              itemBuilder: ((context, index) {
                return DecoratedBox(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index.isEven
                            ? AppColors.COLOR_GREEN_LIGHT
                            : AppColors.COLOR_WHITE));
              }),
              duration: Duration(seconds: 2),
              size: 25.0,
            )
          ],
        ));
  }

  Future<void> getUserData() async {
    // logger.w("set Menu");
    isSupplier = await _sharedPreferencesService.preferenceGetType();
    fullName = await _sharedPreferencesService.preferenceGetFullName();
    image = await _sharedPreferencesService.preferenceGetImage();
    getMachine();
  }

  List<MenuModel> menuList = [];

  Future<void> generateMenu() async {
    menuList.clear();
    var _menu = isSupplier == "2"
        ? <MenuModel>[
            MenuModel(
              name: "${Constants.FILL_APPOINT_TITLE}",
              route: FillAppointmentPage(isSupplier: true, appointStatus: "0"),
              color: AppColors.COLOR_WHITE,
              subName: "กรอกการนัดหมาย",
              image: "${Constants.IMAGE_DIR}/menu-fill.png",
              isShow: true,
            ),
            MenuModel(
              name: "${Constants.APPOINTMENT_TITLE}",
              route: AppointmentPage(isSupplier: true),
              color: AppColors.COLOR_WHITE,
              subName: "การนัดหมายทั้งหมด",
              image: "${Constants.IMAGE_DIR}/menu-app.png",
              isShow: true,
            ),
            MenuModel(
              name: "${Constants.LOANER_TITLE}",
              route: LoanerPage(
                  isFillForm: false, selectedLoaner: [], isEdit: false),
              color: AppColors.COLOR_WHITE,
              subName: "จัดการข้อมูล Loaner",
              image: "${Constants.IMAGE_DIR}/menu-loaner.png",
              isShow: true,
            ),
            MenuModel(
              name: "${Constants.EMPLOYEE_TITLE}",
              route: EmployeePage(),
              color: AppColors.COLOR_WHITE,
              subName: "จัดการเจ้าหน้าที่บริษัท",
              image: "${Constants.IMAGE_DIR}/menu-person.png",
              isShow: true,
            ),
          ]
        : isSupplier == "1"
            ? <MenuModel>[
                MenuModel(
                  name: "${Constants.CONFIRM_APPOINT_TITLE}",
                  route: ConfirmAppointmentPage(),
                  color: AppColors.COLOR_WHITE,
                  subName: "ยืนยันกับเจ้าหน้าที่บริษัท",
                  image: "${Constants.IMAGE_DIR}/menu-fill.png",
                  isShow: true,
                ),
                MenuModel(
                  name: "${Constants.APPOINTMENT_TITLE}",
                  route: AppointmentPage(isSupplier: false),
                  color: AppColors.COLOR_WHITE,
                  subName: "การนัดหมายทั้งหมด",
                  image: "${Constants.IMAGE_DIR}/menu-app.png",
                  isShow: true,
                ),
              ]
            : [];

    _menu.map((menu) {
      menuList.add(menu);
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
                    SizedBox(height: 15),
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
                                    fontWeight: FontWeight.bold),
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
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  TextButton(
                                    child: Text("ดูทั้งหมด",
                                        style: TextStyle(
                                          color: AppColors.COLOR_PRIMARY,
                                          fontSize: 12,
                                        )),
                                    onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              isSupplier == "2"
                                                  ? AppointmentPage(
                                                      isSupplier: true)
                                                  : ConfirmAppointmentPage(),
                                        )),
                                  ),
                                ],
                              ),
                              _buildList()
                            ]),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    // logger.w(image);
    return Container(
      // margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.only(left: 20, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
              child: image == ""
                  ? Image.asset(
                      '${Constants.IMAGE_DIR}/Group 120.png',
                      fit: BoxFit.cover,
                    )
                  : FadeInImage.memoryNetwork(
                      imageErrorBuilder: ((context, error, stackTrace) =>
                          defaultImage()),
                      placeholderErrorBuilder: (context, error, stackTrace) =>
                          defaultImage(),
                      placeholder: kTransparentImage,
                      image: '${Urls.imageEmployeeUrl}/$image')),
          SizedBox(
            width: 5,
          ),
          Container(
            height: 50,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "สวัสดี ! 🖐🏻",
                    style: TextStyle(
                        fontSize: 21,
                        color: AppColors.COLOR_BLACK,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "คุณ $fullName",
                    style:
                        TextStyle(fontSize: 14, color: AppColors.COLOR_LIGHT),
                  ),
                ),
              ],
            ),
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
        child: Image.asset("${Constants.IMAGE_DIR}/loaner-ad.png",
            fit: BoxFit.cover));
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
          String _image = menuList[index].image;
          Widget _route = menuList[index].route;
          Color _color = menuList[index].color;

          return Visibility(
            visible: true,
            child: _buildMenuCard(
              menuName: _menuName,
              image: _image,
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
      required String image,
      required Widget page}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0.2,
      color: AppColors.COLOR_WHITE,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _menuRoute(page: page),
        child: Container(
          height: double.maxFinite,
          padding: EdgeInsets.only(top: 10, right: 10, bottom: 10),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  image,
                  width: 60,
                  height: 60,
                ),
                SizedBox(height: 20),
                Wrap(
                  children: [
                    Text(
                      menuName,
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColors.COLOR_BLACK,
                          fontWeight: FontWeight.bold),
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
    );
  }

  Widget _buildList() {
    return Container(
      height: double.maxFinite,
      child: ListView.builder(
        itemCount: appointmentsData.length,
        itemBuilder: (context, index) {
          String day = _convertToDay(appointmentsData[index].appDate!);
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: AppColors.COLOR_WHITE,
            elevation: 1.0,
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          padding: EdgeInsets.all(2.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: AppColors.COLOR_PRIMARY,
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Center(
                            child: Text(
                                "${appointmentsData[index].appDate![0]}${appointmentsData[index].appDate![1]}",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.COLOR_WHITE)),
                          )),
                      Container(
                          padding: EdgeInsets.all(2.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: AppColors.COLOR_GREY,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8.0),
                                  bottomRight: Radius.circular(8.0))),
                          child: Center(
                            child: Text(day,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.COLOR_BLACK)),
                          ))
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(appointmentsData[index].hospitalId!,
                      style: TextStyle(fontSize: 14)),
                  Text("${appointmentsData[index].hosDeptId}",
                      style: TextStyle(
                          fontSize: 14, color: AppColors.COLOR_LIGHT)),
                  Row(
                    children: [
                      Icon(Icons.calendar_month_outlined,
                          color: AppColors.COLOR_PRIMARY, size: 14),
                      Text(" วันที่นัดหมาย: ${appointmentsData[index].appDate}",
                          style: TextStyle(
                              fontSize: 12, color: AppColors.COLOR_PRIMARY)),
                      SizedBox(width: 10),
                      Text("เวลา: ${appointmentsData[index].appTime} น.",
                          style: TextStyle(
                              fontSize: 12, color: AppColors.COLOR_PRIMARY))
                    ],
                  ),
                ],
              )
            ]),
          );
        },
      ),
    );
  }
}
