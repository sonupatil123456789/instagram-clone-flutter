
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/utils/resources/enums.dart';
import 'package:instagram_clone/utils/screen_utils/file_model.dart';

class InputFielUtils {
  RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  RegExp nameRegExp =
      RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
  RegExp passwordRegExp = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
  // RegExp phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");

  validatePhoneNumber(phoneno) {
    if (phoneno!.isEmpty || phoneno == null) {
      return 'Phone number should not be empty';
    }
    // if (!phoneRegExp.hasMatch(phoneno)) {
    //   return 'Please enter valid phone number ';
    // }
    return null;
  }

  validateName(name) {
    if (name!.isEmpty || name == null) {
      return 'Name should not be empty';
    }
    if (!nameRegExp.hasMatch(name)) {
      return 'Please enter valid name ';
    }
    return null;
  }

  validatePassword(String password) {
    if (password.isEmpty) {
      return 'password should not be empty';
    }
    if (password.length <= 6) {
      return 'Please should not be smaller than eight (6) digit ';
    }
    // if (!passwordRegExp.hasMatch(password)) {
    //   return 'Please enter valid password ';
    // }
    return null;
  }

  validateEmail(email) {
    if (email!.isEmpty || email == null) {
      return 'Email should not be empty';
    }
    if (!emailRegExp.hasMatch(email)) {
      return 'Please enter valid email ';
    }
    return null;
  }

  static Future<FileData?> getMyFile(List<String> allowedExtension,
      FileType fileType, CustomUploadFileType uploadType) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: fileType,
        // type: fileType,
        allowedExtensions: allowedExtension,
      );

      if (result != null) {
        PlatformFile file = result.files.first;
        if (kDebugMode) {
          print('File picked: ${file.name}');
          print('File picked: ${file.extension}');
          print('File path: ${file.path}');
          print('File size: ${file.size}');
        }

        return FileData(
            fileData: file as PlatformFile?, coustomfileType: uploadType);
      } else {
        print('File picking canceled');
      }
    } catch (e) {
      print('Error picking file: $e');
    }
    return null;
  }

  static Future<PlatformFile?> getALlMyFile(
      List<String> allowedExtension) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowedExtensions: allowedExtension,
        type: FileType.custom,
      );

      if (result != null) {
        PlatformFile file = result.files.first;
        if (kDebugMode) {
          print('File picked: ${file.name}');
          print('File picked: ${file.extension}');
          print('File path: ${file.path}');
          print('File size: ${file.size}');
        }

        return file as PlatformFile?;
      } else {
        print('File picking canceled');
      }
    } catch (e) {
      print('Error picking file: $e');
    }
    return null;
  }

  static Future<FileData?> pickImages(
      ImageSource source, CustomUploadFileType uploadType) async {
    try {
      final imagePicker = ImagePicker();

      XFile? pickedFile = await imagePicker.pickImage(source: source);
      if (pickedFile != null) {
        if (kDebugMode) {
          print('File picked: ${pickedFile.name}');
          print('File path: ${pickedFile.path}');
        }
        return FileData(
            coustomfileType: uploadType, fileData: pickedFile as XFile?);
      } else {
        print('Image picking canceled');
      }
    } catch (e) {
      print('Image picker error: $e');
    }
    return null;
  }

  static void openFileFromUrl(String fileUri, context) async {
    print(fileUri.split("_").last.toString());


    try {
      FileDownloader.downloadFile(
          url: fileUri,
          name: fileUri.split("_").last.toString(), //(optional)
          onProgress: (fileName, progress) {

          },
          downloadDestination: DownloadDestinations.publicDownloads,
          onDownloadCompleted: (String path) async{
            print('FILE DOWNLOADED TO PATH: $path');
          },
          onDownloadError: (String error) {
            print('DOWNLOAD ERROR: $error');
            throw error ;
          });
    } catch (e) {
      print(e);
    }
  }
}
