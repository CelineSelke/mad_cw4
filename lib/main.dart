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

class _MyHomePageState extends State<MyHomePage> {
  List<String> plans = [];
  List<String> planDescriptions = [];
  List<String> planDates = [];
  List<int> planCompletion = [];
  List<Color> colors = [];
  int planIDCounter = 0;

  void createPlan(String planName, String planDescription, String date) {
    setState(() {
      plans.add(planName);
      planDescriptions.add(planDescription);
      planDates.add(date);
      planCompletion.add(0);
      colors.add(Colors.red);

      planIDCounter++;
      if(plans.length > 7){
        deletePlan(0);
      }
    });
  }

  void deletePlan(int index) {
    setState(() {
      plans.removeAt(index);
      planCompletion.removeAt(index);
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
          title: const Text('Enter Plan Name'),
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
          title: const Text('Enter Plan Name'),
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
                
                createPlan(name, description, dateParsed);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void setColor(int index){
      if(planCompletion[index] == 0){
        colors[index] = Colors.red;
      }
      
      colors[index] = Colors.green;
  }

  void editPlan(int index){
      String newPlanDescription = "";
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Plan Name'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                newPlanDescription = value;
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
                if (newPlanDescription.isNotEmpty) {
                  setState(() {
                    planDescriptions[index] = newPlanDescription;
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
        if(planCompletion[index] == 1){
          planCompletion[index] = 0;
        }
        else{
          planCompletion[index] = 1;
        }
        setColor(index);

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
                  onLongPress: (){editPlan(index);},
                  onDoubleTap: (){deletePlan(index);},
                  onVerticalDragUpdate: (DragUpdateDetails details){setCompletion(index);},
                  child: ColoredBox(color: colors[index], child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(plans[index], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                    Text(planDescriptions[index], style: TextStyle(fontSize: 15)),
                    Text(planDates[index], style: TextStyle(fontSize: 15)),
                    
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
