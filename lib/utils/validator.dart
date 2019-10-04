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
      case 'text':
        return validateText(value);
      case 'working place':
        return validateWorkingPlace(value);    
        break;
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

  static String validateText(value) {
    return null;
  }
}
