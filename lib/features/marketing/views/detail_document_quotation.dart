import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/theme.dart';
import '../../../constant/url.dart';
import '../models/list_quotation_model.dart';
import 'upload_document_pottd.dart';

class DetailDocumentQuotation extends StatelessWidget {
  static const String routeName = '/detail-document-quotation-page';
  const DetailDocumentQuotation({super.key});

  @override
  Widget build(BuildContext context) {
    final doc =
        ModalRoute.of(context)!.settings.arguments as ListQuotationModel;
    return Scaffold(
      appBar: AppBar(title: Text('Detail Dokumen')),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: [Color(0xFF0F172A), Color(0xFF1E3A8A)],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: BoxBorder.all(color: whiteColor, width: 1.sp),
                color: Color(0X55FFFFFF),
                borderRadius: BorderRadius.circular(20.h),
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(height: 10.h),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.r),
                      child: Image.network(
                        '${Appurl.base}${doc.documentPath}',
                        height: 200.h,
                        width: 300.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _itemEdit(
                          title: 'Nama Dokumen',
                          data: doc.documentUser?.docName ?? '',
                        ),
                        _itemEdit(title: 'Status Dokumen', data: doc.status),
                        _itemEdit(
                          title: 'Tanggal Dokumen',
                          data: doc.tglSurvey,
                        ),
                        _itemEdit(
                          title: 'Nomor Dokumen',
                          data: doc.documentUser?.docNumber ?? '',
                        ),
                        _itemEdit(
                          title: 'Deskripsi',
                          data: doc.documentUser?.docDesc ?? '',
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              UploadDocumentPottd.routeName,
                              arguments: doc.documentUser!.id,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            minimumSize: Size(double.infinity, 50),
                          ),
                          child: Text(
                            'Kaji ulang Kontrak',
                            style: whiteTextStyle.copyWith(fontSize: 16.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemEdit({required String title, required String data}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: whiteTextStyle.copyWith(fontSize: 16.sp, fontWeight: bold),
        ),
        Text(data, style: whiteTextStyle.copyWith(fontSize: 16.sp)),
        SizedBox(height: 10.h),
      ],
    );
  }
}
