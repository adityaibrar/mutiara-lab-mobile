import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/helpers/dialog_helper.dart';
import '../../../constant/utils/state_enum.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/item_kaji_koor.dart';
import '../provider/koor_teknis_provider.dart';
import 'detail_document_koor.dart';

class ListDokumenUserTeknis extends StatefulWidget {
  static const String routeName = '/list-dokumen-user-teknis';
  const ListDokumenUserTeknis({super.key});

  @override
  State<ListDokumenUserTeknis> createState() => _ListDokumenUserTeknisState();
}

class _ListDokumenUserTeknisState extends State<ListDokumenUserTeknis> {
  @override
  void initState() {
    super.initState();
    context.read<KoorTeknisProvider>().getDocumentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Dokumen User')),
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
            child: Consumer<KoorTeknisProvider>(
              builder: (context, koorTeknisProvider, child) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (koorTeknisProvider.state == RequestState.loading) {
                    DialogHelper.showLoadingDialog(context);
                  }
                  if (koorTeknisProvider.state == RequestState.loaded) {
                    DialogHelper.hideLoadingDialog(context);
                    if (koorTeknisProvider.listDocument.isEmpty) {
                      CustomSnackbar(
                        title: 'Info',
                        message: 'Belum ada dokumen yang tersedia',
                        type: SnackbarType.success,
                      ).show(context);
                      koorTeknisProvider.resetState();
                    }
                  }

                  if (koorTeknisProvider.state == RequestState.error) {
                    DialogHelper.hideLoadingDialog(context);
                    CustomSnackbar(
                      title: 'Error',
                      message: 'Error ${koorTeknisProvider.errorMessage}',
                      type: SnackbarType.error,
                    ).show(context);
                    koorTeknisProvider.resetState();
                  }
                });
                return ListView.separated(
                  itemBuilder: (context, index) {
                    final item = koorTeknisProvider.listDocument[index];
                    return ItemKajiKoor(
                      documentUser: item,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          DetailDocumentKoor.routeName,
                          arguments: item,
                        );
                      },
                    );
                  },
                  separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  itemCount: koorTeknisProvider.listDocument.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
