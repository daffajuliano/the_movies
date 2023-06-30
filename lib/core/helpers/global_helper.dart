class AppGlobalHelper {
  static isEmptyList(List? data) {
    if (data != null && data.isNotEmpty) {
      return false;
    } else {
      return true;
    }
  }

  static isEmpty(dynamic data) {
    if (data != null && data != 0 && data != '') {
      return false;
    } else {
      return true;
    }
  }
}