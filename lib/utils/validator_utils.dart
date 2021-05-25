

class Validator{
  static final instance = Validator();

  bool IsEmail(String _email)
  {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(_email);
  }

/*
Phone numbers must contain 10 digits.
In case country code us used, it can be 12 digits. (example country codes: +84, 012)
No space or no characters allowed between digits
 */
  bool IsPhoneNumber(String value) {
    String pattern = r'(^(?:[+0][9|3|8|7|1|5])?[0-9]{10,10}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return false;
    }
    else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }
}