import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/helpers/dialog_helper.dart';
import '../../../constant/utils/state_enum.dart';
import '../../../widgets/item_album.dart';
import '../providers/customer_provider.dart';

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
      if (result.listAlbum == null) {
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Consumer<CustomerNotifier>(
              builder: (context, customerNotifier, child) {
                if (customerNotifier.state == RequestState.loading) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    DialogHelper.showLoadingDialog(context);
                  });
                }
                if (customerNotifier.state == RequestState.loaded) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    DialogHelper.hideLoadingDialog(context);
                    customerNotifier.resetState();
                  });
                }
                return ListView.separated(
                  itemCount: customerNotifier.listAlbum?.length ?? 0,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10.h);
                  },
                  itemBuilder: (context, index) {
                    final item = customerNotifier.listAlbum?[index];
                    return ItemAlbum(
                      year: item?.year ?? 0,
                      totalDocument: item?.totalDocument ?? '',
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
