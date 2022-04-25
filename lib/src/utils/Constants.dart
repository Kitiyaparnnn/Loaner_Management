import 'package:flutter/material.dart';

class Constants {
  //app name
  static const String APP_NAME = "เข้าสู่ระบบ";
  static const String APP_SUBTITLE = "ลงชื่อเข้าใช้บัญชีของคุณ";
  static const String CREATE_BY =
      "Copyright © 2022 - Pose Intelligence Limited";
  static const String LOADING_TEXT = "waiting...";

  //title
  static const String DESCRIBE_TITLE =
      "ซอร์ฟแวร์ที่มีประสิทธิภาพซึ่งสร้างขึ้น \nสำหรับนัดหมาย และ ยืนยันการนัดหมาย\nระหว่าง Supplier และ เจ้าหน้าที่โรงพยาบาล";
  static const String FILL_APPOINT_TITLE = "กรอกนัดหมาย";
  static const String CONFIRM_APPOINT_TITLE = "ยืนยันนัดหมาย";
  static const String APPOINTMENT_TITLE = "นัดหมาย";
  static const String LOANER_TITLE = "Loaner";
  static const String EMPLOYEE_TITLE = "เจ้าหน้าที่";
  static const String HISTORY_TITLE = "ประวัติ";
  static const String LOANER_SUM_TITLE = "รายการ Loaner";

  //app font
  static const String APP_FONT = "sans_thai";

  //routes
  static const String HOME_ROUTE = "/home";
  static const String LOGIN_ROUTE = "/login";

  static const String IMAGE_DIR = "lib/src/assets/images";

  //login
  static const String LOGO_IMAGE = "$IMAGE_DIR/logo_pose.png";
  static const String SPLASH_IMAGE = "$IMAGE_DIR/splash.png";

  //fill appointment
  static const List<String> emp = ["นาย ก", "นาย ข", "นาย ค", "นาย ง"];
  static const List<String> hos = [
    "โรงพยาบาล ก",
    "โรงพยาบาล ข",
    "โรงพยาบาล ค",
    "โรงพยาบาล ง"
  ];
  static const List<String> org = [
    "บริษัท ก",
    "บริษัท ข",
    "บริษัท ค",
    "บริษัท ง"
  ];
  static const List<String> doc = ["แพทย์ ก", "แพทย์ ข", "แพทย์ ค", "แพทย์ ง"];
  static const List<String> dep = [
    "หน่วยงาน ก",
    "หน่วยงาน ข",
    "หน่วยงาน ค",
    "หน่วยงาน ง"
  ];
  static const List<String> status = [
    "รอ cssd ยืนยัน",
    "cssd ยืนยันแล้ว",
    "เสร็จสิ้น",
    "รอยืนยัน"
  ];
 static const List<String> group = [
    "หมวดหมู่ ก",
    "หมวดหมู่ ข",
    "หมวดหมู่ ค",
    "หมวดหมู่ ง"
  ];
//status
  static const String APP_CREATE = "สร้างเอกสาร";
  static const String APP_WAIT_CSSD = "รอ cssd ยืนยัน";
  static const String APP_CONFIRM_CSSD = "cssd ยืนยันแล้ว";
  static const String APP_COMPLETED = "เสร็จสิ้น";
  static const String APP_WAITING = "รอยืนยัน";

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
  static const String TEXT_PROFILE = "โปรไฟล์";
  static const String TEXT_LOGOUT = "ออกจากระบบ";
  static const String TEXT_SETTING = "ตั้งค่า";
  static const String TEXT_LOGOUT_MESSAGE = "คุณต้องการออกจากระบบใช่หรือไม่?";
  static const String TEXT_SAVE = "บันทึก";
  static const String TEXT_SOME_THING_WRONG =
      "มีบางอย่างผิดพลาด กรุณาลองใหม่อีกครั้ง";
  static const String TEXT_FORM_FIELD = "กรุณาตรวจกรอกข้อมูล";
}
