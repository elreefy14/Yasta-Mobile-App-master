import 'package:flutter/material.dart';
import 'package:yasta/core/helper/cache_helper/cache_helper.dart';

import '../../../../core/app_local/app_local.dart';

class UpdateWidget extends StatelessWidget {
  const UpdateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: CacheHelper.getdata(key: "lang").toString() == "en"
          ? Alignment.topRight
          : Alignment.topLeft,
      child: Text(
        getLang(context, "Update Data").toString(),
        style: TextStyle(color: Colors.green),
      ),
    );
  }
}
