// // ignore_for_file: avoid_print

// import 'package:diety/features/Asks/view/Activates.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import '../view/Age.dart';
// import '../view/Gender.dart';
// import '../view/Height.dart';
// import '../view/Weight.dart';

// String getSelectedActivityLevel() {
//     List<String> activityLevels = [
//       'Sedentary',
//       'Lightly Active',
//       'Moderately Active',
//       'Very Active',
//       'Extra Active',
//     ];
//     int selectedIndex = isSelected.indexOf(true);
//     return activity =activityLevels[selectedIndex];
//   }
// Future<void> addUser() async {
//   String gender = isMale ? 'male' : 'female';
//   getSelectedActivityLevel();
//   return users
//       .doc(uid)
//       .set({
//         "email": FirebaseAuth.instance.currentUser!.email,
//         "gender": gender,
//         "height": height,
//         "weight": weight.text,
//         "age": age.text,
//         "activity": activity
//       })
//       .then((value) => print('user added'))
//       .catchError((error) => print(error));
// }
