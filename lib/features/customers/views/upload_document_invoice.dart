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
import '../providers/customer_provider.dart';

class UploadDocumentInvoice extends StatefulWidget {
  static const String routeName = '/upload-document-invoice';
  const UploadDocumentInvoice({super.key});

  @override
  State<UploadDocumentInvoice> createState() => _UploadDocumentInvoiceState();
}

class _UploadDocumentInvoiceState extends State<UploadDocumentInvoice> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buat Invoice')),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(gradient: backgroundGradient),
          ),
          Consumer<CustomerNotifier>(
            builder: (context, customerNotifier, child) {
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
                        label: 'Keterangan invoice',
                        borderColor: whiteColor,
                        textStyle: whiteTextStyle,
                      ),
                      SizedBox(height: 10.h),
                      CustomButton(
                        onPressed: () async {
                          await customerNotifier.uploadInvoice(
                            id: id!,
                            date: _dateController.text,
                            subject: _subjectController.text,
                          );
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
}
