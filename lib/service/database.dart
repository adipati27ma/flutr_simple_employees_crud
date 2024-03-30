import "package:cloud_firestore/cloud_firestore.dart";

/*
  docs: Map<String, dynamic> is a data type that represents a collection of key-value pairs,
  where each key is a String and each value is a dynamic type.

  TLDR; It's a dictionary (similar to object in JS).
*/
class DatabaseMethods {
  // docs: Add employee
  Future<void> addEmployeeData(
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

  // Update employee
  Future<void> updateEmployeeData(
      Map<String, dynamic> employeeInfoMap, String id) async {
    return FirebaseFirestore.instance
        .collection("Employees")
        .doc(id)
        .update(employeeInfoMap)
        .catchError((e) {
      print(
        "Firebase Error: ${e.toString()}",
      );
    });
  }

  // Delete employee
  Future<void> deleteEmployeeData(String id) async {
    return FirebaseFirestore.instance
        .collection("Employees")
        .doc(id)
        .delete()
        .catchError((e) {
      print(
        "Firebase Error: ${e.toString()}",
      );
    });
  }
}
