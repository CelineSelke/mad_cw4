import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plan Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

      ),
      home: const MyHomePage(title: 'Plan Manager'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Plan{
    String name = "";
    String description = "";
    String date = "";
    Color color = Colors.red;
    int completion = 0;

    Plan(String newName, String newDescription, String newDate){
        name = newName;
        description = newDescription;
        date = newDate;
    }

    String getName(){
      return name;
    }

    String getDescription(){
      return description;
    }

    String getDate(){
      return date;
    }

    Color getColor(){
      return color;
    }

    void setCompletion(){
        if(completion == 0){
          completion = 1;
        }
        else{
          completion = 0;
        }
        setColor();
    }

    void setColor(){
        if(completion == 0){
          color = Colors.red;
        }
        else{
          color = Colors.green;
        }
    }

    void setDescription(String newDesc){
        description = newDesc;
    }

    void setName(String newName){
       name = newName;
    }

    void setDate(String newDate){
      date = newDate;
    }
}

class _MyHomePageState extends State<MyHomePage> {
  List<Plan> plans = [];
  List<String> months = ["Jan.", "Feb.", "Mar.", "Apr.", "May.", "Jun.", "Jul.", "Aug.", "Sep.", "Oct.", "Nov.", "Dec."];

  void deletePlan(int index) {
    setState(() {
      plans.removeAt(index);
    });
  }

  void showNamePlanDialog() {
    String newPlanName = "";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Plan Name'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                newPlanName = value;
              });
            },
            decoration: const InputDecoration(hintText: "Enter Plan Name"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Next"),
              onPressed: () {
                if (newPlanName.isNotEmpty) {
                  Navigator.of(context).pop();

                  showPlanDescriptionDialog(newPlanName);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void showPlanDescriptionDialog(String name){
    String newDescription = "";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Plan Description'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                newDescription = value;
              });
            },
            decoration: const InputDecoration(hintText: "Enter Plan Description"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Next"),
              onPressed: () {
                if (newDescription.isNotEmpty) {
                  Navigator.of(context).pop();

                  showPlanDateDialog(name, newDescription);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void showPlanDateDialog(String name, String description){
    String date = "";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Plan Date'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                date = value;
              });
            },
            decoration: const InputDecoration(hintText: "Enter Plan Date (yyyy-mm-dd)"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Add"),
              onPressed: () {
                final dateRegex = RegExp(r"^\d{4}-\d{2}-\d{2}$");
                if(dateRegex.hasMatch(date) && (int.parse(date.substring(5,7)) < 13) && (int.parse(date.substring(5,7)) > 0) && (int.parse(date.substring(8,10)) < 31) && (int.parse(date.substring(8,10)) > 0 )){
                  List<String> dateSplit = date.split("-");
                  String month = months[int.parse(dateSplit[1])];
                  String dateParsed = month + " " + dateSplit[2] + ", " + dateSplit[0];
                  setState(() {
                    plans.add(Plan(name, description, dateParsed));

                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void editPlanName(int index){
      String newPlanName = "";
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter New Plan Name'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                newPlanName = value;
              });
            },
            decoration: const InputDecoration(hintText: "Enter New Plan Name"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Next"),
              onPressed: () {
                if (newPlanName.isNotEmpty) {
                  setState(() {
                    plans[index].setName(newPlanName);
                  });
                }
                Navigator.of(context).pop();
                editPlanDescription(index);
              },
            ),
          ],
        );
      },
    );
  }

    void editPlanDate(int index){
      String newPlanDate = "";
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter New Plan Date'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                newPlanDate = value;
              });
            },
            decoration: const InputDecoration(hintText: "Enter New Plan Date (yyyy-mm-dd)"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Finish"),
              onPressed: () {
                final dateRegex = RegExp(r"^\d{4}-\d{2}-\d{2}$");
                if(dateRegex.hasMatch(newPlanDate) && (int.parse(newPlanDate.substring(5,7)) < 13) && (int.parse(newPlanDate.substring(5,7)) > 0) && (int.parse(newPlanDate.substring(8,10)) < 31) && (int.parse(newPlanDate.substring(8,10)) > 0 )){
                  List<String> dateSplit = newPlanDate.split("-");
                  String month = months[int.parse(dateSplit[1])];
                  String dateParsed = month + " " + dateSplit[2] + ", " + dateSplit[0];
                  setState(() {
                      plans[index].setDate(dateParsed);
                  });
                  Navigator.of(context).pop();

                }
              }
            ),
          ],
        );
      },
    );
  }

  void editPlanDescription(int index){
      String newPlanDescription = "";
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter New Plan Description'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                newPlanDescription = value;
              });
            },
            decoration: const InputDecoration(hintText: "Enter New Plan Description"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Next"),
              onPressed: () {
                if (newPlanDescription.isNotEmpty) {
                  setState(() {
                    plans[index].setDescription(newPlanDescription);
                  });
                }
                Navigator.of(context).pop();
                editPlanDate(index);
              },
            ),
          ],
        );
      },
    );
  }

  void setCompletion(int index){
      setState(() {
        plans[index].setCompletion();

      });
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: ListView.builder(
          itemCount: plans.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: () {
                setState(() {
                  editPlanName(index);
                });
              },
              onDoubleTap: () {
                setState(() {
                  deletePlan(index);  
                });
              },
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  setCompletion(index); 
                });
              },
              child: SizedBox(
                width: 600,
                height: 200,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: ColoredBox(
                    color: plans[index].getColor(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(plans[index].getName(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                        Text(plans[index].getDescription(), style: TextStyle(fontSize: 15)),
                        Text(plans[index].getDate(), style: TextStyle(fontSize: 15)),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: showNamePlanDialog,
          child: const Text("Create\nPlan"),
        ),
      );
    }

}
