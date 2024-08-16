import 'package:energy_park/config/widgets/custom_bottom_drop_down.dart';
import 'package:energy_park/modules/add_task/data/employee_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:energy_park/config/colors.dart';
import 'package:energy_park/config/styles.dart';
import 'package:energy_park/config/widgets/common_snack_bar.dart';
import 'package:energy_park/config/widgets/common_text_field.dart';
import 'package:energy_park/config/widgets/custom_progress_bar.dart';
import 'package:energy_park/constants/app_constants.dart';
import 'package:energy_park/modules/add_task/presentation/bloc/add_task_bloc.dart';
import 'package:energy_park/modules/add_task/presentation/bloc/add_task_event.dart';
import 'package:energy_park/modules/add_task/presentation/bloc/add_task_state.dart';
import 'package:energy_park/modules/home/data/model/task_model.dart';
import 'package:energy_park/utils/remove_emoji_input_formatter.dart';
import 'dart:math';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => AddTaskScreenState();
}

@visibleForTesting
class AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<EmployeeListModel> employeeListModel = [];
  EmployeeListModel? selectedEmployee;
  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');
  DateTime _date = DateTime.now();

  _handleDatePicker() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      dateController.text = _dateFormatter.format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTaskBloc()..add(GetEmployeeList()),
      child: BlocListener<AddTaskBloc, AddTaskState>(
        listener: (context, state) {
          if (state is ShowProgressBar) {
            CustomProgressBar(context).showLoadingIndicator();
          } else if (state is TaskAddedSuccess) {
            CustomProgressBar(context).hideLoadingIndicator();
            ScaffoldMessenger.of(context)
                .showSnackBar(snackBarWidget("Task added successfully"));
            Navigator.pop(context, true);
          } else if (state is FailureState){
            CustomProgressBar(context).hideLoadingIndicator();
            ScaffoldMessenger.of(context)
                .showSnackBar(snackBarWidget(state.message, isError: true));
          } else if (state is ShowEmployeeListState){
            CustomProgressBar(context).hideLoadingIndicator();
            employeeListModel = state.employeeList;
          } else if (state is AssignEmployeeState){
            selectedEmployee = state.employeeListModel;
          }
        },
        child: BlocBuilder<AddTaskBloc, AddTaskState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                backgroundColor: AppColors.eventBackGroundColor,
                centerTitle: true,
                title: Text(
                  AppConstants.addTask,
                  style: TextStyles.whiteBold16,
                ),
              ),
              body: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                  padding: const EdgeInsets.only(top: 50),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        SizedBox(
                          height: 72,
                          child: CommonTextField(
                            controller: _titleController,
                            hintText: "",
                            labelText: AppConstants.taskName,
                            isMandatory: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the task name';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 28),
                        InkWell(
                          onTap: _handleDatePicker,
                          child: SizedBox(
                            height: 72,
                            child: CommonTextField(
                              controller: dateController,
                              hintText: "",
                              labelText: AppConstants.date,
                              isMandatory: true,
                              readOnly: true,
                              onTap: _handleDatePicker,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[+a-zA-Z0-9@._-]")),
                              ],
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty) {
                                  return 'Please select date';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 25, right: 25),
                          child: TextFormField(
                            inputFormatters: [
                              RemoveEmojiInputFormatter(),
                            ],
                            controller: _descriptionController,
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.multiline,
                            autocorrect: false,
                            style: TextStyles.blackMedium14,
                            maxLines: 5,
                            maxLength: 250,
                            decoration: InputDecoration(
                              hintText: AppConstants.description,
                              hintStyle: TextStyles.whiteRegular14
                                  .copyWith(
                                  color:
                                  Colors.black.withOpacity(0.6),
                                  fontWeight: FontWeight.w500),
                              contentPadding: const EdgeInsets.only(
                                  top: 15,
                                  left: 10,
                                  right: 10,
                                  bottom: 10),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 0.5,
                                    color: AppColors.greyColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 0.5,
                                    color: AppColors.greyColor),
                              ),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ) {
                                return 'Please enter task description';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              if (value.isEmpty) {
                                CustomProgressBar(context)
                                    .showLoadingIndicator();
                                // BlocProvider.of<AddQuestionBloc>(context).add(PostButtonEnabled(isEnabled: false));
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 28),
                        employeeListModel.isNotEmpty ?   CustomBottomDropDown(
                          items: employeeListModel,
                          title: AppConstants.employee,
                          isExpanded: true,
                          height: MediaQuery.of(context).size.height * 0.35,
                          onChanged: (EmployeeListModel value) {
                            BlocProvider.of<AddTaskBloc>(context)
                                .add(AssignEmployeeEvent(
                              employeeListModel: value,
                            ));
                          },
                          selectedItem: selectedEmployee,
                          hintText: AppConstants.assignEmployee,
                          validator: (value) {
                            if (selectedEmployee == null) {
                              return 'Please assign the task to employee';
                            }
                            return null;
                          },
                        ) : Container(),
                        const SizedBox(height: 28),
                        submitWidget(context),
                        const SizedBox(height: 28),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget submitWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: AppColors.eventBackGroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        onPressed: () async {
          if (_formKey.currentState?.validate() ?? false) {
            CustomProgressBar(context).showLoadingIndicator();
            int min = 1;
            int max = 100000;
            Random rnd = Random.secure();
            int randomInt = min + rnd.nextInt(max - min);
            BlocProvider.of<AddTaskBloc>(context).add(
              AddTaskTapped(
                taskModel: TaskModel(
                  id: randomInt,
                  title: _titleController.text,
                  description: _descriptionController.text,
                  date: _date,
                  status: 0,
                  employee: selectedEmployee,
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(snackBarWidget("Please check the validation", isError: true));
          }
        },
        child: Text(
          AppConstants.addTask,
          textAlign: TextAlign.center,
          style: TextStyles.blackButtonRegular14.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
