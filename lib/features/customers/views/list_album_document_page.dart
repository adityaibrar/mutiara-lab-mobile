import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/helpers/dialog_helper.dart';
import '../../../constant/utils/state_enum.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/item_album.dart';
import '../providers/customer_provider.dart';
import 'list_document_user.dart';

class ListAlbumDocumentPage extends StatefulWidget {
  static const String routeName = '/list-album';
  const ListAlbumDocumentPage({super.key});

  @override
  State<ListAlbumDocumentPage> createState() => _ListAlbumDocumentPageState();
}

class _ListAlbumDocumentPageState extends State<ListAlbumDocumentPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final result = context.read<CustomerNotifier>();
      if (result.listAlbum.isEmpty) {
        result.getAlbum();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Album Dokumen')),
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
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Consumer<CustomerNotifier>(
              builder: (context, customerNotifier, child) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (customerNotifier.state == RequestState.loading) {
                    DialogHelper.showLoadingDialog(context);
                  }
                  if (customerNotifier.state == RequestState.loaded) {
                    DialogHelper.hideLoadingDialog(context);
                    if (customerNotifier.listAlbum.isEmpty) {
                      CustomSnackbar(
                        title: 'Info',
                        message: 'Belum ada dokumen yang tersedia',
                        type: SnackbarType.success,
                      ).show(context);
                    }
                  }

                  if (customerNotifier.state == RequestState.error) {
                    DialogHelper.hideLoadingDialog(context);
                    CustomSnackbar(
                      title: 'Error',
                      message: 'Error ${customerNotifier.errorMessage}',
                      type: SnackbarType.success,
                    ).show(context);
                    customerNotifier.resetState();
                  }
                });

                return ListView.separated(
                  itemCount: customerNotifier.listAlbum.length,
                  separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  itemBuilder: (context, index) {
                    final item = customerNotifier.listAlbum[index];
                    return ItemAlbum(
                      year: item.year ?? 0,
                      totalDocument: item.totalDocument ?? '',
                      onTap: () async {
                        customerNotifier.getDocumentYear(item.year!);
                        Navigator.pushNamed(
                          context,
                          ListDocumentUser.routeName,
                          // arguments: item.year,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
