


enum CurrentAppState{
  INITIAL,
  LOADING,
  SUCCESS,
  ERROR
}

 enum LogLevel {
  info,
  warning,
  error,
}

 enum CustomUploadFileType {
  TextDocument,
  Image,
  Video,
  Audio,
  Document,
}

extension CustomUploadFileTypeExtension on CustomUploadFileType {
  // Convert enum value to string
  String enumToString() {
    switch (this) {
      case CustomUploadFileType.TextDocument:
        return 'TextDocument';
      case CustomUploadFileType.Image:
        return 'Image';
      case CustomUploadFileType.Video:
        return 'Video';
      case CustomUploadFileType.Audio:
        return 'Audio';
      case CustomUploadFileType.Document:
        return 'Document';
    }
  }

  // Convert string to enum value
  static CustomUploadFileType stringToEnum(String fileTypeString) {
    switch (fileTypeString) {
      case 'TextDocument':
        return CustomUploadFileType.TextDocument;
      case 'Image':
        return CustomUploadFileType.Image;
      case 'Video':
        return CustomUploadFileType.Video;
      case 'Audio':
        return CustomUploadFileType.Audio;
      case 'Document':
        return CustomUploadFileType.Document;
      default:
        throw ArgumentError('Invalid fileTypeString: $fileTypeString');
    }
  }
}
