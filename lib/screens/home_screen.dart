import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_uchenna/services/locations.dart';
import 'package:todo_uchenna/utils/router.dart';
import 'package:todo_uchenna/view_models/add_task_view_model.dart';
import 'package:todo_uchenna/constants.dart';
import 'package:todo_uchenna/utils/snackbar.dart';
import 'package:todo_uchenna/view_models/task_view_model.dart';
import 'add_task_screen.dart';
import 'package:todo_uchenna/view_models/task_list_view_model.dart';
import 'package:todo_uchenna/widgets/task_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String address = '';
  Location location = Location();
  AddTaskViewModel addTaskViewModel = AddTaskViewModel();
  TaskListView viewModel = TaskListView();
  final TextEditingController _searchController = TextEditingController();//control search text-field
  User? user = FirebaseAuth.instance.currentUser;
  Stream<List<TaskViewModel>>? stream; //stream argument for TaskList

  //Rebuild UI
  Widget _updateUI(AddTaskViewModel vm) {
    switch (vm.loading) {
      case true:
        return const Align(
          child: CircularProgressIndicator(),
        );
      case false:
        return TaskList(stream: stream,);
    }
    return const Center(
      child: Text('please wait..'),
    );
  }

  //Get current address
  void getAddress() async {
    address = (await location.getCurrentLocation())!;
  }

  //Implement initState
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddress();
    stream = viewModel.getTasks();
    _updateUI(addTaskViewModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
            const EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 28.0,
                  child: Icon(
                    Icons.list,
                    size: 28.0,
                    color: Colors.lightBlue,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Welcome, ${user!.displayName}',
                  style: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 9,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _searchController,
                          decoration: textFieldDecoration.copyWith(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _searchController.clear(); //Clear text field
                                  stream = viewModel.getTasks(); //Get all tasks
                                  FocusScopeNode currentFocus = FocusScope.of(context);
                                  currentFocus.unfocus();//Close keyboard
                                  _updateUI(addTaskViewModel);//Rebuild UI
                                });
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        if (_searchController.text.isNotEmpty) {
                          setState((){
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            currentFocus.unfocus();
                            stream = viewModel.getSearchedTasks(_searchController.text);
                            _updateUI(addTaskViewModel);
                          });
                        } else {
                          showSnackBar(context, 'No Text');
                        }
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                          MaterialStatePropertyAll(Colors.white)),
                      child: const Text(
                        'Search',
                        style: TextStyle(color: Colors.black54),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: _updateUI(addTaskViewModel),
            ),
          )
        ],
      ),
      //FloatingActionButton to Navigate to AddTaskScreen
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          nextPage(
              AddTaskScreen(
                address: address,
              ),
              context);
        },
        backgroundColor: Colors.lightBlue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
