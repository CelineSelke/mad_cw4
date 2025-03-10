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
  List<String> Plans = [];
  List<int> plancompletion = [];
  int PlanIDCounter = 0;

  void createPlan(String PlanName) {
    setState(() {
      Plans.add(PlanName);
      plancompletion.add(0);

      PlanIDCounter++;
      if(Plans.length > 7){
        deletePlan(0);
      }
    });
  }

  void deletePlan(int index) {
    setState(() {
      Plans.removeAt(index);
      plancompletion.removeAt(index);
    });
  }

  void showcreatePlanDialog() {
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
                  createPlan(newPlanName);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Color getColor(int index){
      if(plancompletion[index] == 0){
        return Colors.red;
      }

      if(plancompletion[index] == 1){
        return Colors.yellow;
      }
      
      return Colors.green;
  }

  void editPlan(int index){
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
                  setState(() {
                    Plans[index] = newPlanName;
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
            Plans.length,
            (index) => SizedBox(
              key: Key(index.toString()),
              width: 600,
              height: 100,
              child: Padding(padding: EdgeInsets.all(15),
                child:GestureDetector(
                  onLongPress: (){editPlan(index);},
                  child: ColoredBox(color: getColor(index), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(Plans[index], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                    SizedBox(width: 50, height: 50, child: IconButton(
                      padding: EdgeInsets.all(0),
                      color: Colors.white,
                      onPressed: () => deletePlan(index),
                      icon: Icon(Icons.restore_from_trash),
                      
                    ),)
                  ],
                ),
              ),
    
            ))
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showcreatePlanDialog,
        child: const Text("Create\nPlan"),
      ),
    );
  }
}
