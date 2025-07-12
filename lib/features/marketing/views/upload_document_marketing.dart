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
import '../../customers/providers/file_provider.dart';
import '../models/upload_document_marketing.dart';
import '../providers/marketing_provider.dart';

class UploadDocumentMarketing extends StatefulWidget {
  static const String routeName = '/upload-document-marketing';
  const UploadDocumentMarketing({super.key});

  @override
  State<UploadDocumentMarketing> createState() =>
      _UploadDocumentMarketingState();
}

class _UploadDocumentMarketingState extends State<UploadDocumentMarketing> {
  late final int? id;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  bool _isInitialized =
      false; // Tambahan agar `didChangeDependencies` hanya sekali jalan

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      id = ModalRoute.of(context)!.settings.arguments as int?;
      _isInitialized = true;
    }
  }

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
    MarketingNotifier marketingNotifier,
  ) async {
    if (fileNotifier.selectedImage == null) {
      throw ('gambar kosong');
    }
    final data = UploadDocumentMarketingModel(
      tglKajian: _dateController.text,
      ketKajian: _subjectController.text,
      docPath: fileNotifier.selectedImage!.path,
      status: 'accept marketing',
    );
    await marketingNotifier.uploadDocument(id!, data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Surat Kaji Ulang Dokumen')),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(gradient: backgroundGradient),
          ),
          Consumer2<FileNotifier, MarketingNotifier>(
            builder: (context, fileNotifier, marketingNotifier, child) {
              if (marketingNotifier.state == RequestState.loading) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  DialogHelper.showLoadingDialog(context);
                });
              }
              if (marketingNotifier.state == RequestState.loaded) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  DialogHelper.hideLoadingDialog(context);
                  Navigator.pop(context);
                  CustomSnackbar(
                    title: 'Berhasil',
                    message: 'Dokumen berhasil di upload',
                    type: SnackbarType.success,
                  ).show(context);
                  marketingNotifier.resetState();
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
                        controller: _dateController,
                        label: 'Pilih Tanggal',
                        borderColor: whiteColor,
                        textStyle: whiteTextStyle,
                        onTap: () => showCalendarBottomSheet(context),
                      ),
                      SizedBox(height: 10.h),
                      InputField(
                        controller: _subjectController,
                        label: 'Keterangan Dokumen',
                        borderColor: whiteColor,
                        textStyle: whiteTextStyle,
                      ),
                      SizedBox(height: 10.h),
                      CustomButton(
                        onPressed: () async {
                          await postDocument(fileNotifier, marketingNotifier);
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
          color: Colors.white.withValues(alpha: 0.2),
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
