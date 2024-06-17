import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imsmart_admin/core/extensions/extended_build_context.dart';
import 'package:imsmart_admin/core/my_providers/property_provider.dart';
import 'package:imsmart_admin/core/utils/page_router.dart';
import 'package:imsmart_admin/core/utils/utils.dart';
import 'package:imsmart_admin/core/widget/background_widget.dart';
import 'package:imsmart_admin/core/widget/custom_button.dart';
import 'package:imsmart_admin/core/widget/dialogs.dart';
import 'package:imsmart_admin/core/widget/edit_form_widget.dart';
import 'package:imsmart_admin/models/room_property_model.dart';
import 'package:imsmart_admin/pages/home_screens/home_screen.dart';

class UpdateApartmentScreen extends StatefulWidget {
  final RoomPropertyModel property;
  const UpdateApartmentScreen({super.key, required this.property});

  @override
  State<UpdateApartmentScreen> createState() => _UpdateApartmentScreenState();
}

class _UpdateApartmentScreenState extends State<UpdateApartmentScreen> {
  TextEditingController _titleController = TextEditingController();

  TextEditingController _descriptionController = TextEditingController();

  TextEditingController _amenitiesController = TextEditingController();

  TextEditingController _amountController = TextEditingController();

  TextEditingController _chargeController = TextEditingController();

  TextEditingController _addressController = TextEditingController();

  List<String> _amenitiesList = ["WiFi service", "Laundry service", "Gaming Lounge", "Full body massage service", "24/7 uninterrupted Power", "Netflix", "DSTV", "Playstation 5"];
  List<dynamic> _selectedList = [];
  late PropertyProvider _provider;

  @override
  void initState() {
    // TODO: implement initState
    _provider = context.provideOnce<PropertyProvider>();
    _titleController.text = widget.property.title ?? "";
    _descriptionController.text = widget.property.description ?? "";
    _amountController.text = formNum(widget.property.amount.toString());
    _chargeController.text = formNum(widget.property.cautionFee.toString());
    _addressController.text = widget.property.location ?? "";

    _selectedList = widget.property.roomItems;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                children: [

                  SizedBox(height: 32.h),

                  EditFormField(
                    controller: _titleController,
                    keyboardType: TextInputType.text,
                    label: "Apartment title",
                    hint: "Apartment title",
                    autocorrect: false,
                    onChanged: (text){
                      if (mounted) {
                        setState(() {});
                      }
                    },
                  ),

                  EditFormField(
                    controller: _descriptionController,
                    keyboardType: TextInputType.multiline,
                    minLines: 3,
                    maxLines: 6,
                    label: "Apartment description",
                    hint: "Apartment description",
                    autocorrect: false,
                    onChanged: (text){
                      if (mounted) {
                        setState(() {});
                      }
                    },
                  ),

                  EditFormField(
                    controller: _addressController,
                    keyboardType: TextInputType.text,
                    label: "Apartment address",
                    hint: "Apartment address",
                    autocorrect: false,
                    onChanged: (text){
                      if (mounted) {
                        setState(() {});
                      }
                    },
                  ),

                  EditFormField(
                    controller: _amountController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    label: "Apartment price",
                    hint: "Apartment price",
                    autocorrect: false,
                    onChanged: (text){
                      text = formNum(text);
                      _amountController.value = TextEditingValue(
                        text: text,
                        selection: TextSelection.collapsed(
                          offset: text.length,
                        ),
                      );
                    },
                  ),

                  EditFormField(
                    controller: _chargeController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    label: "Apartment charge",
                    hint: "Apartment charge",
                    autocorrect: false,
                    onChanged: (text){
                      text = formNum(text);
                      _chargeController.value = TextEditingValue(
                        text: text,
                        selection: TextSelection.collapsed(
                          offset: text.length,
                        ),
                      );
                    },
                  ),

                  /*EditFormField(
                    controller: _amenitiesController,
                    keyboardType: TextInputType.multiline,
                    label: "Apartment amenities",
                    hint: "Apartment amenities",
                    minLines: 3,
                    maxLines: 6,
                    autocorrect: false,
                    onChanged: (text){
                      if (mounted) {
                        setState(() {});
                      }
                    },
                  ),*/

                  CustomChipInupt(
                    label: "Amenity list",
                    inputList: _amenitiesList,
                    initialList: widget.property.roomItems,
                    onChanged: (result){
                      _selectedList = result;
                    },
                  ),

                  SizedBox(height: 24.h),

                ],
              ),
            ),

            SizedBox(height: 24.h,),

            CustomButtonWidget(
              width: 1.sw - 40.w,
              height: 56.h,
              buttonText: "Update",
              onTap: () async {
                num amount = num.parse(_amountController.text.replaceAll(",", ""));
                num charge = num.parse(_chargeController.text.replaceAll(",", ""));
                RoomPropertyModel model = RoomPropertyModel(
                  title: _titleController.text,
                  description: _descriptionController.text,
                  location: _addressController.text,
                  roomItems: _amenitiesList,
                  amount: amount, cautionFee: charge,
                );
                var result = await _provider.updateProperty(context: context, propertyId: widget.property.id, propertyModel: model);

                if(result.error){
                  return;
                }

                AppDialog.showSuccessDialog(context, message: result.message, onContinue: () {
                  PageRouter.gotoWidget(HomeScreen(), context, clearStack: true);
                });
              },
            ),

            SizedBox(height: 24.h,),

          ],
        ),
      ),
    );
  }
}
