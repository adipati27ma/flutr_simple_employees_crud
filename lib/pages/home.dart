import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutr_simple_employees_crud/pages/employee.dart';
import 'package:flutr_simple_employees_crud/service/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  Stream? employeeStream;

  getEmployeesOnTheLoad() async {
    employeeStream = await DatabaseMethods().getAllEmployees();
    setState(() {});
  }

  // docs: initState() is the first function that usually calls when the app launches.
  @override
  void initState() {
    getEmployeesOnTheLoad();
    super.initState();
  }

  Widget allEmployeeDetails() {
    return StreamBuilder(
        stream: employeeStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];

                    return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      // Card
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        // Container
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          // Inner Card Content
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 255,
                                    child: Text(
                                      "Name : ${ds['name']}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        nameController.text = ds['name'];
                                        ageController.text = ds['age'];
                                        locationController.text =
                                            ds['location'];
                                        editEmployeeDetail(ds.id);
                                      },
                                      child: Icon(Icons.edit,
                                          color: Colors.orange)),
                                  SizedBox(width: 5),
                                  GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title:
                                                      Text("Delete Employee"),
                                                  content: Text(
                                                      "Are you sure you want to delete ${ds['name']}?"),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("No")),
                                                    TextButton(
                                                        onPressed: () async {
                                                          await DatabaseMethods()
                                                              .deleteEmployeeData(
                                                                  ds.id)
                                                              .then((value) {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "${ds['name']}'s data deleted successfully!",
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity
                                                                        .CENTER,
                                                                timeInSecForIosWeb:
                                                                    2,
                                                                backgroundColor:
                                                                    Colors.blue,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16.0);
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                        },
                                                        child: Text("Yes"))
                                                  ],
                                                ));
                                      },
                                      child: Icon(Icons.delete,
                                          color: Colors.red)),
                                ],
                              ),
                              Text(
                                "Age : ${ds['age']}",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Location : ${ds['location']}",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => EmployeeForm()));
        },
        tooltip: 'Add employee',
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
          centerTitle: true,
          title: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Flutr",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Text("SEC",
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 24,
                      fontWeight: FontWeight.bold))
            ],
          )),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Column(
          children: [
            Expanded(child: allEmployeeDetails()),
          ],
        ),
      ),
    );
  }

  Future editEmployeeDetail(String id) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            icon: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Edit",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      Text("Employee",
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close, color: Colors.black, size: 30),
                  ),
                ]),
            content: SingleChildScrollView(
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ==Form Name==
                    Text(
                      "Name",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
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
                          fontSize: 22,
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
                          fontSize: 22,
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
                    SizedBox(height: 30),
                    Container(
                        alignment: Alignment.centerRight,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.blue, width: 1),
                          ),
                          child: ElevatedButton(
                            onPressed: () async {
                              await DatabaseMethods().updateEmployeeData({
                                "name": nameController.text,
                                "age": ageController.text,
                                "location": locationController.text
                              }, id).then((value) {
                                Fluttertoast.showToast(
                                    msg:
                                        "${nameController.text}'s data updated successfully!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.blue,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                Navigator.pop(context);
                              });
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.lightBlue[50]),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 10,
                                        bottom: 10))),
                            child: Text(
                              "Update",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            )),
      );
}
