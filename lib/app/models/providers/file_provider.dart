import 'dart:io';
import 'package:appbdp/app/common/http_config.dart';
import 'package:appbdp/app/constants/api.const.dart';
import 'package:appbdp/app/models/banner_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart' as fd;
import 'package:get/get_connect/http/src/multipart/multipart_file.dart' as mf;

class FileProvider extends GetConnect {
  GetStorage box = GetStorage('App');

  @override
  void onInit() {
    httpClient.baseUrl = urlV1;
    httpDefaultConfiguration(
      httpClient,
      box,
      enabledContentType: false,
    );
  }

  Future<FileModel?> store(
    FilePickerResult file, {
    String? folder,
  }) async {
    if (file.files.isNotEmpty) {
      final FormData formData = fd.FormData(
        {
          'folder': folder,
          'file': mf.MultipartFile(
            File(
              file.files.first.xFile.path,
            ),
            filename: file.files.first.xFile.name,
          ),
          'object': true,
        },
      );

      final response = await post(
        'files',
        formData,
        contentType: 'multipart/form-data',
      );
      if (response.body != null && response.body['data'] != null) {
        return FileModel.fromJson(response.body['data']);
      }
    }
    return null;
  }
}
