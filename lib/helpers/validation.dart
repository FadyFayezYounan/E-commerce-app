abstract class StringValidate {
  String? isValid(String? value);
}


///login page
class ValidEmailAddress implements StringValidate {
  @override
  String? isValid(String? email) {
    if (email!.trim().isEmpty) {
      return 'Email address must not be empty';
    } else if (!email.contains('@gmail.com')) {
      return 'Email address must contains @gmail.com';
    } else if (!email.contains('@')) {
      return 'Email address must contains @';
    }
    return null;
  }
}

class ValidPassword implements StringValidate {
  @override
  String? isValid(String? password) {
    if (password!.trim().isEmpty) {
      return 'Password must not be empty';
    } else if ( password.length < 6) {
      return 'Password length must be greater the or equal 6';
    }
    return null;
  }
}

class ValidateUserEmailAndPassword{
  final StringValidate emailValidator = ValidEmailAddress();
  final StringValidate passwordValidator = ValidPassword();
}


///signUp page


class ValidName implements StringValidate {
  @override
  String? isValid(String? name) {
    if (name!.trim().isEmpty) {
      return 'Name must not be empty';
    }
    return null;
  }
}

class ValidPhoneNumber implements StringValidate {
  @override
  String? isValid(String? phone) {
    if (phone!.trim().isEmpty) {
      return 'Phone number must not be empty';
    }else if(phone.trim().length < 11){
      return 'Phone Number length must not be less than 11 characters';
    }
    return null;
  }
}

class ValidateUserSignUp{
  final StringValidate nameValidator = ValidName();
  final StringValidate emailValidator = ValidEmailAddress();
  final StringValidate phoneValidator = ValidPhoneNumber();
  final StringValidate passwordValidator = ValidPassword();
}








// class Validation {
//   static String? validateEmailAddress({String? email}) {
//     if (email!.isEmpty) {
//       return 'Email address must not be empty';
//     } else if (!email.contains('@gmail.com')) {
//       return 'Email address must contains @gmail.com';
//     } else if (!email.contains('@')) {
//       return 'Email address must contains @';
//     }
//     return null;
//   }
// }
