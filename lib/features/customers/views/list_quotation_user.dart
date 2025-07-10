import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/helpers/dialog_helper.dart';
import '../../../constant/theme.dart';
import '../../../constant/utils/state_enum.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/item_document_quotation.dart';
import '../providers/customer_provider.dart';
import 'detail_quotation_user.dart';

class ListQuotationUser extends StatefulWidget {
  static const String routeName = '/list-quotation-user';
  const ListQuotationUser({super.key});

  @override
  State<ListQuotationUser> createState() => _ListQuotationUserState();
}

class _ListQuotationUserState extends State<ListQuotationUser> {
  @override
  void initState() {
    super.initState();
    context.read<CustomerNotifier>().getListQuotationInvoice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PO/TTD Lab')),
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
                      type: SnackbarType.error,
                    ).show(context);
                    customerNotifier.resetState();
                  }
                });
                return ListView.separated(
                  itemBuilder: (context, index) {
                    final item = customerNotifier.listQuotationDocument[index];
                    return ItemDocumentQuotation(
                      listInvoiceModel: item,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          DetailQuotationUser.routeName,
                          arguments: item,
                        );
                      },
                    );
                  },
                  separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  itemCount: customerNotifier.listQuotationDocument.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
