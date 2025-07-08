import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/theme.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_calendar.dart';
import '../../../widgets/input_field.dart';
import '../providers/image_provider.dart';

class FormRequestMessage extends StatefulWidget {
  static const String routeName = '/form-request-message';
  const FormRequestMessage({super.key});

  @override
  State<FormRequestMessage> createState() => _FormRequestMessageState();
}

class _FormRequestMessageState extends State<FormRequestMessage> {
  final TextEditingController _nameDocController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _nomorController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void showCalendarBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: whiteColor,
      enableDrag: true,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      context: context,
      builder: (context) => CustomCalendar(
        dateController: _dateController,
        selectedDate: _selectedDate,
        onDateSelected: (newDate) {
          setState(() {
            _selectedDate = newDate;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Surat Permintaan')),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(gradient: backgroundGradient),
          ),
          Consumer<ImageNotifier>(
            builder: (context, imageNotifier, child) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    children: [
                      Text(
                        '📤 Upload Dokumen',
                        textAlign: TextAlign.center,
                        style: whiteTextStyle.copyWith(
                          fontSize: 24.sp,
                          fontWeight: medium,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      _buildImageDisplay(imageNotifier),
                      SizedBox(height: 10.h),
                      InputField(
                        controller: _nameDocController,
                        label: 'Nama Dokumen',
                        borderColor: whiteColor,
                        textStyle: whiteTextStyle,
                      ),
                      SizedBox(height: 10.h),
                      InputField(
                        controller: _dateController,
                        label: 'Pilih Tanggal',
                        borderColor: whiteColor,
                        textStyle: whiteTextStyle,
                        onTap: () => showCalendarBottomSheet(context),
                      ),
                      SizedBox(height: 10.h),
                      InputField(
                        controller: _nomorController,
                        label: 'Nomor Dokumen',
                        borderColor: whiteColor,
                        textStyle: whiteTextStyle,
                      ),
                      SizedBox(height: 10.h),
                      InputField(
                        controller: _subjectController,
                        label: 'Keterangan Dokumen',
                        borderColor: whiteColor,
                        textStyle: whiteTextStyle,
                      ),
                      SizedBox(height: 10.h),
                      CustomButton(onPressed: () async {}, label: 'Simpan'),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildImageDisplay(ImageNotifier imageNotifier) {
    return imageNotifier.selectedImage != null
        ? Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Image.file(
                  File(imageNotifier.selectedImage!.path),
                  height: 200.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: -10,
                right: -8,
                child: GestureDetector(
                  onTap: imageNotifier.deleteImage,
                  child: _buildDeleteButton(),
                ),
              ),
            ],
          )
        : Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14.r),
                child: Image.asset(
                  'assets/uploadimg.png',
                  height: 200.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: -10,
                right: -8,
                child: GestureDetector(
                  onTap: () => imageNotifier.selectImage(context),
                  child: _buildAddButton(),
                ),
              ),
            ],
          );
  }

  Widget _buildAddButton() {
    return Container(
      height: 40.h,
      width: 40.w,
      decoration: BoxDecoration(shape: BoxShape.circle, color: primaryColor),
      child: Icon(Icons.add, color: whiteColor),
    );
  }

  Widget _buildDeleteButton() {
    return Container(
      height: 40.h,
      width: 40.w,
      decoration: BoxDecoration(shape: BoxShape.circle, color: redColor),
      child: Icon(Icons.delete_outlined, color: whiteColor),
    );
  }
}
