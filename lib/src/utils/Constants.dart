import 'package:flutter/material.dart';

class Constants {
  //app name
  static const String APP_NAME = "Loaner Management";
  static const String CREATE_BY =
      "Pose intelligence Co.,Ltd. Professional \n Prevention Infection Control.";
  static const String LOADING_TEXT = "waiting...";

  //title
  static const String FILL_APPOINT_TITLE = "กรอกนัดหมาย";
  static const String CONFIRM_APPOINT_TITLE = "ยืนยันนัดหมาย";
  static const String APPOINTMENT_TITLE = "นัดหมาย";
  static const String LOANER_TITLE = "Loaner";
  static const String EMPLOYEE_TITLE = "เจ้าหน้าที่";

  //app font
  static const String APP_FONT = "sans_thai";

  //routes
  static const String HOME_ROUTE = "/home";
  static const String LOGIN_ROUTE = "/login";

  static const String IMAGE_DIR = "lib/src/assets/images";

  //login
  static const String LOGO_IMAGE = "$IMAGE_DIR/logo_pose.png";
  static const String SPLASH_IMAGE = "$IMAGE_DIR/splash.png";

  //ตั้งค่า
  static const String TEXT_SETTING_ROUND = "ตั้งค่าจำนวนรอบ";

  static const String TEXT_ROOM = "Room";
  static const String TEXT_TEMPERATURE = "Temperature";
  static const String TEXT_HUMIDITY = "Humidity";

  //water
  static const String WATER_TEXT_CLEANER = "Cleaner";
  static const String WATER_TEXT_TESTER = "ผู้ทดสอบ :";
  static const String WATER_TEXT_REGENERATE =
      "Regenerate salt (ล้างด้วยน้ำเกลือ)";
  static const String WATER_TEXT_HARDNESS_BLUE = "สีความกระด้าง (น้ำเงิน)";
  static const String WATER_TEXT_HARDNESS_VIOLET = "สีความกระด้าง (ม่วง)";
  static const String WATER_TEXT_HARDNESS_TITLE = "ค่าน้ำก่อนกรอง\n(TDS)";
  static const String WATER_TEXT_HARDNESS_RANGE = "(0-200ppm)";
  static const String WATER_TEXT_PH_TITLE = "ค่าความเป็น\nกรด/ด่าง";
  static const String WATER_TEXT_PH_RANGE = "(7-8PH)";
  static const String WATER_TEXT_TEMPERATURE_TITLE = "อุณหภูมิน้ำ\n(°C)";
  static const String WATER_TEXT_TEMPERATURE_RANGE = "";

  static const String TEXT_CONFIRM = "ตกลง";
  static const String TEXT_CANCEL = "ยกเลิก";
  static const String TEXT_SEARCH = "ค้นหา";
  static const String TEXT_DATA_NOT_FOUND = "ไม่พบข้อมูล";
  static const String TEXT_LOGIN_FAILED =
      "ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง กรุณาลองใหม่";
  static const String TEXT_LOGIN_SCAN_FAILED =
      "รหัสที่สแกนไม่มีอยู่ในระบบ กรุณาติดต่อเจ้าหน้านี้";
  static const String TEXT_FAILED = "ผิดพลาด";
  static const String TEXT_SUCCESS = "สำเร็จ";
  static const String TEXT_LOGOUT = "ออกจากระบบ";
  static const String TEXT_SETTING = "ตั้งค่า";
  static const String TEXT_LOGOUT_MESSAGE = "คุณต้องการออกจากระบบใช่หรือไม่?";
  static const String TEXT_SAVE = "บันทึก";
  static const String TEXT_SOME_THING_WRONG =
      "มีบางอย่างผิดพลาด กรุณาลองใหม่อีกครั้ง";
  static const String TEXT_FORM_FIELD =
      "กรุณาตรวจกรอกข้อมูลให้ครบ";
}
