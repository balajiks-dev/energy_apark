import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:energy_park/config/colors.dart';
import 'package:energy_park/modules/task_filter/bloc/task_filter_bloc.dart';
import 'package:energy_park/modules/task_filter/bloc/task_filter_event.dart';
import 'package:energy_park/modules/task_filter/bloc/task_filter_state.dart';

class TaskFilterScreen extends StatefulWidget {
  final String selectedStatus;

  const TaskFilterScreen({super.key, required this.selectedStatus});

  @override
  State<TaskFilterScreen> createState() => _TaskFilterScreenState();
}

class _TaskFilterScreenState extends State<TaskFilterScreen> {
  List<String> statusList = ['Completed', 'Pending'];
  String selectedStatus = '';

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.selectedStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => TaskFilterBloc(),
        child: BlocListener<TaskFilterBloc, TaskFilterState>(
          listener: (context, state) {
            if (state is UpdateTaskStatus) {
              selectedStatus = state.status;
            }
          },
          child: BlocBuilder<TaskFilterBloc, TaskFilterState>(
            builder: (context, state) {
              return Container(
                height: 500,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 20, bottom: 5),
                            child: Text(
                              "Task Filter",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.clear,
                              size: 25,
                              color: AppColors.eventBackGroundColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              "Status",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const VerticalDivider(),
                          SizedBox(
                            // color: Colors.yellow,
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: ListView.builder(
                                itemCount: statusList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    children: [
                                      Checkbox(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                        side: WidgetStateBorderSide.resolveWith(
                                          (states) => BorderSide(
                                            width: statusList[index] ==
                                                    selectedStatus
                                                ? 0
                                                : 1,
                                            color: Colors.black,
                                          ),
                                        ),
                                        checkColor: Colors.white,
                                        activeColor: const Color(0xFF1A4CC0),
                                        value:
                                            statusList[index] == selectedStatus,
                                        onChanged: (bool? value) {
                                          BlocProvider.of<TaskFilterBloc>(
                                                  context)
                                              .add(SelectTaskStatus(
                                                  status: statusList[index]));
                                        },
                                      ),
                                      Text(
                                        statusList[index],
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  BlocProvider.of<TaskFilterBloc>(context)
                                      .add(SelectTaskStatus(status: ''));
                                  Navigator.pop(context, '');
                                },
                                child: Container(
                                  height: 48,
                                  padding: const EdgeInsets.all(10),
                                  decoration: ShapeDecoration(
                                    color:
                                        const Color.fromRGBO(225, 234, 255, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text("Clear All"),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  Navigator.pop(context, selectedStatus);
                                },
                                child: Container(
                                  height: 48,
                                  padding: const EdgeInsets.all(10),
                                  decoration: ShapeDecoration(
                                    // color: AppColors.blueColor,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                        width: 1,
                                        color: Color(0xFFC8CED9),
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text("Apply"),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
