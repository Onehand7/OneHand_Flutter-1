class ValidateText{
  String validateEmail(String value){
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    if (value.isEmpty){
      return 'Por favor ingrese el email';
    }else{
      RegExp regex = new RegExp(pattern.toString());
      if (!regex.hasMatch(value)){
        return 'Enter Valid Email';
      }
      return "Email correcto";
    }
  }
  String validatePassword(String value){
    if(value.isEmpty){
      return 'Por favor ingrese el password';
    }else{
      if(6 > value.length){
        return 'Por favor ingrese un password de 6 caracteres';
      }
      return "Contraseña correcta";
    }
  }
}