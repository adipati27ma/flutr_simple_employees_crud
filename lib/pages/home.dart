import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutr_simple_employees_crud/pages/employee.dart';
import 'package:flutr_simple_employees_crud/service/database.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name : ${ds['name']}",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
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
}
