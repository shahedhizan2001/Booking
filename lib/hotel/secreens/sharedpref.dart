import 'package:booking/account/myaccount.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // حفظ لغة التطبيق المحددة
  static Future<void> putLanguage(String language) async {
    await sharedPreferences.setString('lang', language);
  }

  // الحصول على لغة التطبيق المحفوظة
  static Future<String> getLanguage() async {
    await init(); // تأكد من تهيئة sharedPreferences قبل الاستخدام
    final lang = await sharedPreferences.getString('lang');
    if (lang != null) return lang;

    return AppLanguage.en.name;
  }
}
