import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/helpers/dialog_helper.dart';
import '../../../constant/utils/state_enum.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/item_quotation.dart';
import '../providers/marketing_provider.dart';
import 'detail_document_quotation.dart';

class ListDocumentQuotation extends StatefulWidget {
  static const String routeName = '/list-dokumen-quotation';
  const ListDocumentQuotation({super.key});

  @override
  State<ListDocumentQuotation> createState() => _ListDocumentQuotationState();
}

class _ListDocumentQuotationState extends State<ListDocumentQuotation> {
  @override
  void initState() {
    super.initState();
    context.read<MarketingNotifier>().getListQuotation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Dokumen Quotation')),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: [Color(0xFF0F172A), Color(0xFF1E3A8A)],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Consumer<MarketingNotifier>(
              builder: (context, marketingNotifier, child) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (marketingNotifier.state == RequestState.loading) {
                    DialogHelper.showLoadingDialog(context);
                  }
                  if (marketingNotifier.state == RequestState.loaded) {
                    DialogHelper.hideLoadingDialog(context);
                    if (marketingNotifier.listQuotation.isEmpty) {
                      CustomSnackbar(
                        title: 'Info',
                        message: 'Belum ada dokumen yang tersedia',
                        type: SnackbarType.success,
                      ).show(context);
                      marketingNotifier.resetState();
                    }
                  }

                  if (marketingNotifier.state == RequestState.error) {
                    DialogHelper.hideLoadingDialog(context);
                    CustomSnackbar(
                      title: 'Error',
                      message: 'Error ${marketingNotifier.errorMessage}',
                      type: SnackbarType.error,
                    ).show(context);
                    marketingNotifier.resetState();
                  }
                });
                return ListView.separated(
                  itemBuilder: (context, index) {
                    final item = marketingNotifier.listQuotation[index];
                    return ItemQuotation(
                      listQuotationModel: item,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          DetailDocumentQuotation.routeName,
                          arguments: item,
                        );
                      },
                    );
                  },
                  separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  itemCount: marketingNotifier.listQuotation.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
