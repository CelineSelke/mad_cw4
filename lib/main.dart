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
    }

    void setColor(){
        if(completion == 0){
          color = Colors.red;
        }
        else{
          color = Colors.green;
        }
    }

    void setDescription(String desc){
        description = desc;
    }
}

class _MyHomePageState extends State<MyHomePage> {
  List<Plan> plans = [];

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
              child: const Text("Add"),
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
              child: const Text("Add"),
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
                List<String> dateSplit = date.split("-");
                String dateParsed = dateSplit[1] + "/" + dateSplit[2] + "/" + dateSplit[0];
                setState(() {
                  plans.add(Plan(name, description, dateParsed));

                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



  void editPlan(int index){
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
              child: const Text("Add"),
              onPressed: () {
                if (newPlanDescription.isNotEmpty) {
                  setState(() {
                    plans[index].setDescription(newPlanDescription);
                  });
                }
                Navigator.of(context).pop();
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            plans.length,
            (index) => SizedBox(
              key: Key(index.toString()),
              width: 600,
              height: 300,
              child: Padding(padding: EdgeInsets.all(15),
                child:GestureDetector(
                  onLongPress: (){setState(() {
                    editPlan(index);
                  });},
                  onDoubleTap: (){setState(() {
                    deletePlan(index);
                  });},
                  onVerticalDragUpdate: (DragUpdateDetails details){setState(() {
                    setCompletion(index);
                  });},
                  child: ColoredBox(color: plans[index].getColor(), child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(plans[index].getName(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                    Text(plans[index].getDescription(), style: TextStyle(fontSize: 15)),
                    Text(plans[index].getDate(), style: TextStyle(fontSize: 15)),
                    
                  ],
                ),
              ),
    
            ))
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showNamePlanDialog,
        child: const Text("Create\nPlan"),
      ),
    );
  }
}
