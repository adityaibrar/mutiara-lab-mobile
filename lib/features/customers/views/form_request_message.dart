import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/helpers/dialog_helper.dart';
import '../../../constant/theme.dart';
import '../../../constant/utils/state_enum.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_calendar.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/input_field.dart';
import '../models/upload_document_user.dart';
import '../providers/customer_provider.dart';
import '../providers/file_provider.dart';

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
  final TextEditingController _yearDocController = TextEditingController();
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

  Future postDocument(
    FileNotifier fileNotifier,
    CustomerNotifier customerNotifier,
  ) async {
    if (fileNotifier.selectedImage == null) {
      throw ('gambar kosong');
    }
    final data = UploadDocumentUser(
      docName: _nameDocController.text,
      docDate: _dateController.text,
      docNumber: _nomorController.text,
      docDesc: _subjectController.text,
      imagePath: fileNotifier.selectedImage!.path,
      docYear: _yearDocController.text,
    );
    await customerNotifier.uploadDocument(data);
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
          Consumer2<FileNotifier, CustomerNotifier>(
            builder: (context, fileNotifier, customerNotifier, child) {
              if (customerNotifier.state == RequestState.loading) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  DialogHelper.showLoadingDialog(context);
                });
              }
              if (customerNotifier.state == RequestState.loaded) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  DialogHelper.hideLoadingDialog(context);
                  Navigator.pop(context);
                  CustomSnackbar(
                    title: 'Berhasil',
                    message: 'Dokumen berhasil di upload',
                    type: SnackbarType.success,
                  ).show(context);
                  customerNotifier.resetState();
                  fileNotifier.deleteFile();
                });
              }
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
                      _buildImageDisplay(fileNotifier),
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
                      InputField(
                        controller: _yearDocController,
                        label: 'Tahun Dokumen',
                        borderColor: whiteColor,
                        textStyle: whiteTextStyle,
                      ),
                      SizedBox(height: 10.h),
                      CustomButton(
                        onPressed: () async {
                          await postDocument(fileNotifier, customerNotifier);
                        },
                        label: 'Simpan',
                      ),
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

  Widget _buildImageDisplay(FileNotifier fileNotifier) {
    if (fileNotifier.selectedImage != null) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Image.file(
              File(fileNotifier.selectedImage!.path),
              height: 200.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: -10,
            right: -8,
            child: GestureDetector(
              onTap: fileNotifier.deleteFile,
              child: _buildDeleteButton(),
            ),
          ),
        ],
      );
    } else if (fileNotifier.selectedPdf != null) {
      return Container(
        height: 60.h,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          color: Colors.white.withOpacity(0.2),
          border: Border.all(color: whiteColor, width: 2),
        ),
        child: Row(
          children: [
            Icon(Icons.picture_as_pdf, color: whiteColor, size: 40),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                fileNotifier.selectedPdf!.path.split('/').last,
                style: whiteTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            GestureDetector(
              onTap: fileNotifier.deleteFile,
              child: _buildDeleteButton(),
            ),
          ],
        ),
      );
    } else {
      return Stack(
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
              onTap: () => fileNotifier.selectFile(context),
              child: _buildAddButton(),
            ),
          ),
        ],
      );
    }
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
