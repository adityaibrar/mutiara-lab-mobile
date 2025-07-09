import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/helpers/dialog_helper.dart';
import '../../../constant/theme.dart';
import '../../../constant/utils/state_enum.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/item_document.dart';
import '../providers/customer_provider.dart';
import 'detail_document_user.dart';

class ListDocumentUser extends StatefulWidget {
  static const String routeName = '/list-document-user';
  const ListDocumentUser({super.key});

  @override
  State<ListDocumentUser> createState() => _ListDocumentUserState();
}

class _ListDocumentUserState extends State<ListDocumentUser> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dokumen Tahun')),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(gradient: backgroundGradient),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
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
                  itemBuilder: (context, index) {
                    final item = customerNotifier.listDocument[index];
                    return ItemDocument(
                      documentUser: item,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          DetailDocumentUser.routeName,
                          arguments: item,
                        );
                      },
                    );
                  },
                  separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  itemCount: customerNotifier.listDocument.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
