class Validator {
  static String validate(String op, value) {
    switch (op) {
      case 'email':
        return validateEmail(value);
        break;
      case 'password':
        return validatePassword(value);
        break;
      case 'confirm password':
        return validateConfirmPassword(value);
        break;
      case 'name':
        return validateName(value);
        break;
      case 'school':
        return validateSchool(value);
        break;
      case 'nic number':
        return validateNicNumber(value);
      case 'slmc number':
        return validateSlmcRegNumber(value);
      case 'phone':
        return validateNumber(value);
        break;
      case 'birthday':
        return validatebirthday(value);
        break;
      case 'text':
        return validateText(value);
      case 'working place':
        return validateWorkingPlace(value);
        break;
        
      case 'Date':
        return validateDate(value);
      case 'Time':
        return validateTime(value);
      case 'Place':
        return validatePlace(value);
      default:
        return null;
    }
  }

  static String validateEmail(value) {
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a valid email address.';
    else
      return null;
  }
   static String validatebirthday(value) {
    Pattern pattern = r'^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a correct birthday.';
    else
      return null;
  }

  static String validatePassword(value) {
    Pattern pattern = r'^.{6,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Password must be at least 6 characters.';
    else
      return null;
  }

  static String validateConfirmPassword(value) {
    Pattern pattern = r'^.{6,}$';
    RegExp regex = new RegExp(pattern);
    
    if (!regex.hasMatch(value))
      return 'Password must be at least 6 characters.';
    else 
      return null;
    
  }

  

  static String validateName(value) {
    Pattern pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a name.';
    else
      return null;
  }

  static String validateSchool(value) {
    Pattern pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a school name.';
    else
      return null;
  }

  static String validateNicNumber(value) {
    Pattern pattern = r'^.{6,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Password must be at least 6 characters.';
    else
      return null;
  }

  static String validateSlmcRegNumber(value) {
    Pattern pattern = r'^.{6,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Password must be at least 6 characters.';
    else
      return null;
  }

  static String validateWorkingPlace(value) {
    Pattern pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a working place.';
    else
      return null;
  }

  static String validateNumber(value) {
    Pattern pattern = r'^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a number.';
    else
      return null;
  }

  static String validateDate(value) {
    Pattern pattern = r'^([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter(yyyy-mm-dd)format.';
    else
      return null;
  }

  static String validateTime(value) {
    Pattern pattern = r'^[0-2][0-3]:[0-5][0-9]$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter(HH:MM)format.';
    else
      return null;
  }

  static String validatePlace(value) {
    Pattern pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter the place ';
    else
      return null;
  }

  static String validateText(value) {
    return null;
  }

}
