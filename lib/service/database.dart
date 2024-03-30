import "package:cloud_firestore/cloud_firestore.dart";

class DatabaseMethods {
  // Add employee
  Future<void> addEmployee(
      Map<String, dynamic> employeeInfoMap, String id) async {
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

  // Get all employees
  Future<Stream<QuerySnapshot>> getAllEmployees() async {
    return FirebaseFirestore.instance.collection("Employees").snapshots();
  }
}
