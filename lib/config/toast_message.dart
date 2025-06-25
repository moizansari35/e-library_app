import 'package:e_library/config/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

void successMessage(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: MyColors.blackColor,
    textColor: MyColors.greenColor,
    fontSize: 15,
  );
}

void errorMessage(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: MyColors.blackColor,
    textColor: MyColors.errorColor,
    fontSize: 15,
  );
}
