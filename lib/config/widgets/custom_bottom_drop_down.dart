import 'package:energy_park/modules/add_task/data/employee_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:energy_park/config/colors.dart';
import 'package:energy_park/config/styles.dart';
import 'package:energy_park/constants/assets_path.dart';

class CustomBottomDropDown extends StatefulWidget {
  final List<EmployeeListModel> items;
  final String title;
  final String hintText;
  final bool isExpanded;
  final double? height;
  final ValueChanged<EmployeeListModel> onChanged;
  final EmployeeListModel? selectedItem;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const CustomBottomDropDown({
    super.key,
    required this.items,
    required this.title,
    required this.hintText,
    required this.onChanged,
    this.selectedItem,
    this.isExpanded = true,
    this.height,
    this.suffixIcon,
    this.validator,
  });

  @override
  State<CustomBottomDropDown> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CustomBottomDropDown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
         // Text(widget.title, style: TextStyles.greyRegular12),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  clipBehavior: Clip.antiAlias,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(26),
                      topRight: Radius.circular(26),
                    ),
                  ),
                  builder: (BuildContext bc) => BottomSheet(
                        items: widget.items,
                        title: widget.title,
                        hintText: widget.hintText,
                        isExpanded: widget.isExpanded,
                        height: widget.height,
                        onChanged: widget.onChanged,
                        selectedItem: widget.selectedItem,
                        suffixIcon: widget.suffixIcon,
                      )
                  //   showBottomDropDown(
                  // context),
                  );
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 12, 10, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0), // Border radius
                border: Border.all(
                  color: AppColors.greyColor,
                  width: 0.5,

                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 0, left: 10, top: 0),
                child: TextFormField(
                  validator: widget.validator,
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: (widget.selectedItem == null) ? widget.hintText : widget.selectedItem!.name,
                    errorStyle: TextStyles.errorMedium12,
                    hintStyle: TextStyles.whiteRegular14.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.6),
                    ),
                   // hintStyle: (widget.selectedItem == null || widget.selectedItem!.isEmpty) ? TextStyles.blackBold14.copyWith(color: const Color.fromRGBO(18, 24, 27, 0.30)) : TextStyles.blackBold14,
                    suffixIconConstraints: const BoxConstraints(
                      minHeight: 20,
                      maxHeight: 20,
                    ),
                    suffixIcon: widget.suffixIcon ??
                        SvgPicture.asset(
                          SvgAssets.dropDownSvg,
                          width: 20,
                          height: 8,
                        ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.dividerColor.withOpacity(0.3),
                      ),
                    ),
                    border: InputBorder.none,
                    // border: UnderlineInputBorder(
                    //   borderSide: BorderSide(color: AppColors.blackColor),
                    // ),
                    labelStyle: TextStyles.whiteRegular14.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomSheet extends StatefulWidget {
  final List<EmployeeListModel> items;
  final String title;
  final String hintText;
  final bool isExpanded;
  final double? height;
  final ValueChanged<EmployeeListModel> onChanged;
  final EmployeeListModel? selectedItem;
  final Widget? suffixIcon;

  const BottomSheet({
    super.key,
    required this.items,
    required this.title,
    required this.hintText,
    required this.onChanged,
    this.selectedItem,
    this.isExpanded = true,
    this.height,
    this.suffixIcon,
  });

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: SvgPicture.asset(SvgAssets.dragSvg),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text(
              widget.title,
              style: TextStyles.blackBold18,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 24, right: 24, bottom: 10),
              child: ListView.builder(
                itemCount: widget.items.length,
                physics: const ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        // widget.selectedItem = widget.items[index];
                        widget.onChanged(widget.items[index]);
                        Navigator.pop(context);
                      });
                    },
                    child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(16), color: widget.selectedItem == widget.items[index] ? const Color.fromRGBO(191, 198, 215, 0.20) : Colors.white),
                        child: Text(
                          widget.items[index].name,
                          style: TextStyles.blackMedium14,
                        )),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
