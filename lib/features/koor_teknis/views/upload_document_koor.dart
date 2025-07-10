import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mutiara_lab/features/koor_teknis/models/upload_document_koorteknis.dart';
import 'package:mutiara_lab/features/koor_teknis/provider/koor_teknis_provider.dart';
import 'package:provider/provider.dart';

import '../../../constant/helpers/dialog_helper.dart';
import '../../../constant/theme.dart';
import '../../../constant/utils/state_enum.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_calendar.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/input_field.dart';
import '../../customers/providers/image_provider.dart';

class UploadDocumentKoor extends StatefulWidget {
  static const String routeName = '/upload-document-koor';
  const UploadDocumentKoor({super.key});

  @override
  State<UploadDocumentKoor> createState() => _UploadDocumentKoorState();
}

class _UploadDocumentKoorState extends State<UploadDocumentKoor> {
  late final int? id;
  final TextEditingController _dateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  bool _isInitialized =
      false; // Tambahan agar `didChangeDependencies` hanya sekali jalan

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      id = ModalRoute.of(context)!.settings.arguments as int?;
      print(id);
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
    ImageNotifier imageNotifier,
    KoorTeknisProvider koorTeknisProvider,
  ) async {
    if (imageNotifier.selectedImage == null) {
      throw ('gambar kosong');
    }
    final data = UploadDocumentKoorteknis(
      tglMasuk: _dateController.text,
      documentPath: imageNotifier.selectedImage!.path,
      status: 'accept koor teknis',
    );
    await koorTeknisProvider.uploadDocument(id!, data);
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
          Consumer2<ImageNotifier, KoorTeknisProvider>(
            builder: (context, imageNotifier, koorTeknisProvider, child) {
              if (koorTeknisProvider.state == RequestState.loading) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  DialogHelper.showLoadingDialog(context);
                });
              }
              if (koorTeknisProvider.state == RequestState.loaded) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  DialogHelper.hideLoadingDialog(context);
                  Navigator.pop(context);
                  CustomSnackbar(
                    title: 'Berhasil',
                    message: 'Dokumen berhasil di upload',
                    type: SnackbarType.success,
                  ).show(context);
                  koorTeknisProvider.resetState();
                  imageNotifier.deleteImage();
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
                      _buildImageDisplay(imageNotifier),
                      SizedBox(height: 10.h),
                      InputField(
                        controller: _dateController,
                        label: 'Pilih Tanggal',
                        borderColor: whiteColor,
                        textStyle: whiteTextStyle,
                        onTap: () => showCalendarBottomSheet(context),
                      ),
                      SizedBox(height: 10.h),
                      CustomButton(
                        onPressed: () async {
                          await postDocument(imageNotifier, koorTeknisProvider);
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
