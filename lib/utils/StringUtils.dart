import 'package:quiver/strings.dart';

class StringUtils {
  static isStrEmpty(String string) {
    return isEmpty(string);
  }

  static isStrNotEmpty(String string) {
    return isNotEmpty(string);
  }

  static isStrSame(String str1, String str2) {
    return equalsIgnoreCase(str1, str2);
  }
}
