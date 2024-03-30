import "package:cloud_firestore/cloud_firestore.dart";

class DatabaseMethods {
  Future<void> addEmployeeDetails(
      Map<String, dynamic> employeeInfoMap, String id) async {
    print(
      "Firebase Running...!",
    );

    return FirebaseFirestore.instance
        .collection("Employees")
        .doc(id)
        .set(employeeInfoMap)
        .catchError((e) {
      print(
        "Firebase Error: ${e.toString()}",
      );
    });
  }
}
