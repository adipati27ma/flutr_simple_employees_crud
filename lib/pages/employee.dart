import 'package:flutr_simple_employees_crud/service/database.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class EmployeeForm extends StatefulWidget {
  const EmployeeForm({super.key});

  @override
  State<EmployeeForm> createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          style: ButtonStyle(
            iconSize: MaterialStateProperty.all(30),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Employee",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Text("Form",
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 24,
                    fontWeight: FontWeight.bold))
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 30),
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==Form Name==
            Text(
              "Name",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            // ==Form Age==
            SizedBox(height: 20),
            Text(
              "Age",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: ageController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            // ==Form Location==
            SizedBox(height: 20),
            Text(
              "Location",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: locationController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            // ==Form Button==
            SizedBox(height: 20),
            Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: () => {},
                    // onPressed: () async {
                    //   String id = randomAlphaNumeric(10);
                    //   Map<String, dynamic> employeeInfoMap = {
                    //     "name": nameController.text,
                    //     "age": ageController.text,
                    //     "location": locationController.text,
                    //   };
                    //   await DatabaseMethods()
                    //       .addEmployeeDetails(employeeInfoMap, id)
                    //       .then((value) {
                    //     // Fluttertoast.showToast(
                    //     //     msg: "Employee has been uploaded successfully!",
                    //     //     toastLength: Toast.LENGTH_SHORT,
                    //     //     gravity: ToastGravity.CENTER,
                    //     //     timeInSecForIosWeb: 1,
                    //     //     backgroundColor: Colors.blueGrey[50],
                    //     //     textColor: Colors.black,
                    //     //     fontSize: 16.0);
                    //     print("Employee has been uploaded successfully!");
                    //     Navigator.of(context).pop();
                    //   });
                    // },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.lightBlue[50]),
                        padding: MaterialStateProperty.all(EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10))),
                    child: Text(
                      "Add Employee",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )))
          ],
        ),
      ),
    );
  }
}
