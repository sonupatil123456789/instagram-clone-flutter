import 'package:instagram_clone/utils/resources/enums.dart';

class FileData {
  final fileData ;
  CustomUploadFileType coustomfileType = CustomUploadFileType.TextDocument ; 
  FileData({
    required this.fileData,
    required this.coustomfileType,
  });
}