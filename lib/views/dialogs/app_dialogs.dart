import 'dart:io';

import 'package:flutter_ticket/core/constants/constants.dart';
import 'package:flutter_ticket/core/utils/utils.dart';
import 'package:flutter_ticket/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


part 'image_source_sheet.dart';

class AppDialogs {
  AppDialogs._();

  static Future<File?> showImageSourceSheet(BuildContext context) {
    return _ImageSourceSheet.showSheet(context);
  }


}
