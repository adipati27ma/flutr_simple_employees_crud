import "package:cloud_firestore/cloud_firestore.dart";

class DatabaseMethods {
  Future<void> addEmployeeDetails(
      Map<String, dynamic> employeeInfoMap, String id) async {
    return FirebaseFirestore.instance
        .collection("Employees")
        .doc(id)
        .set(employeeInfoMap)
        .catchError((e) {
      print(e.toString());
    });
  }
}
