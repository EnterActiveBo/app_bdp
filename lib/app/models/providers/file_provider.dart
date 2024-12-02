import 'package:appbdp/app/common/http_config.dart';
import 'package:appbdp/app/constants/api.const.dart';
import 'package:appbdp/app/models/banner_model.dart';
import 'package:chunked_uploader/chunked_uploader.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FileProvider extends GetConnect {
  GetStorage box = GetStorage('App');

  @override
  void onInit() {
    httpClient.baseUrl = urlV1;
    httpDefaultConfiguration(
      httpClient,
      box,
      enabledContentType: false,
      timeout: 3600,
    );
  }

  Future<FileModel?> store(
    FilePickerResult file, {
    String? folder,
  }) async {
    if (file.files.isNotEmpty) {
      try {
        final dio = Dio(
          BaseOptions(
            baseUrl: urlV1,
            headers: {
              'Authorization': "Bearer ${box.read('token')}",
              'XMLHttpRequest': "XMLHttpRequest",
              'Accept': "application/json",
              'Charset': "utf-8",
            },
            connectTimeout: const Duration(seconds: 10),
            sendTimeout: const Duration(seconds: 3600),
            receiveTimeout: const Duration(seconds: 3600),
            responseType: ResponseType.json,
          ),
        );
        final uploader = ChunkedUploader(dio);
        final response = await uploader.uploadUsingFilePath(
          fileKey: 'file',
          fileName: file.files.first.xFile.name,
          filePath: file.files.first.xFile.path,
          maxChunkSize: 100000000,
          path: 'files',
          data: {
            "folder": folder,
            "object": true,
          },
          onUploadProgress: (progress) => print(progress),
        );
        if (response != null &&
            response.statusCode == 200 &&
            response.data is Map) {
          return FileModel.fromJson(response.data['data']);
        }
      } catch (e) {
        print(e);
        return null;
      }
    }
    return null;
  }
}
