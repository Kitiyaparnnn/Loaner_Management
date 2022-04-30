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
  static const String DETAIL_APPOINT_TITLE = "รายละเอียดการนัดหมาย";
  static const String APPOINTMENT_TITLE = "นัดหมาย";
  static const String LOANER_TITLE = "Loaner";
  static const String EMPLOYEE_TITLE = "เจ้าหน้าที่";
  static const String EMPLOYEE_ADD_TITLE = "เพิ่มเจ้าหน้าที่";
  static const String HISTORY_TITLE = "ประวัตินัดหมาย";
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
  static const List<String> role = ["supplier", "cssd"];

  //fill appointment
  static const Map<String, String> emp = {
    "0": "นาย ก",
    "1": "นาย ข",
    "2": "นาย ค",
    "3": "นาย ง"
  };
  static const Map<String, String> hos = {
    "0": "โรงพยาบาล ก",
    "1": "โรงพยาบาล ข",
    "2": "โรงพยาบาล ค",
    "3": "โรงพยาบาล ง"
  };

  static const Map<String, String> org = {
    "0": "บริษัท ก",
    "1": "บริษัท ข",
    "2": "บริษัท ค",
    "3": "บริษัท ง"
  };
  static const Map<String, String> doc = {
    "0": "แพทย์ ก",
    "1": "แพทย์ ข",
    "2": "แพทย์ ค",
    "3": "แพทย์ ง"
  };
  static const Map<String, String> dep = {
    "0": "หน่วยงาน ก",
    "1": "หน่วยงาน ข",
    "2": "หน่วยงาน ค",
    "3": "หน่วยงาน ง"
  };
  static const Map<String, String> status = {
    "0": "สร้างเอกสาร",
    "1": "รอ cssd ยืนยัน",
    "2": "cssd ยืนยันแล้ว",
    "3": "Completed",
    "4": "รอยืนยัน"
  };
  static const Map<String, String> group = {
    "0": "หมวดหมู่ ก",
    "1": "หมวดหมู่ ข",
    "2": "หมวดหมู่ ค",
    "3": "หมวดหมู่ ง"
  };

  static const Map<String, String> head = {"0": "นาย", "1": "นางสาว", "2": "นาง"};

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
  static const String TEXT_SAVE_MESSAGE = "คุณต้องการบันทึกการนัดหมาย";
  static const String TEXT_SAVE = "บันทึก";
  static const String TEXT_SOME_THING_WRONG =
      "มีบางอย่างผิดพลาด กรุณาลองใหม่อีกครั้ง";
  static const String TEXT_FORM_FIELD = "กรุณาตรวจการกรอกข้อมูล";
  static const String TEXT_IMPORT_IMAGE = "โปรดเลือกวิธีการอัพโหลดรูปภาพ";
}
