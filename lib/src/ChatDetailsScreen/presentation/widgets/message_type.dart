import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:instagram_clone/components/fileTypes/audio_player.dart';
import 'package:instagram_clone/utils/resources/enums.dart';
import 'package:instagram_clone/utils/routes/routes_name.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

class MessageType extends StatefulWidget {
  String message;
  String messageType;
  MessageType({super.key, required this.message, required this.messageType});

  @override
  State<MessageType> createState() => _MessageTypeState();
}

class _MessageTypeState extends State<MessageType>  with ScreenUtils {
  CustomUploadFileType fileType = CustomUploadFileType.TextDocument;

  @override
  Widget build(BuildContext context) {
    fileType = CustomUploadFileTypeExtension.stringToEnum(widget.messageType);

    if (fileType == CustomUploadFileType.Image) {
      return GestureDetector(
         onTap: () async {
          Navigator.pushNamed(context, RoutesName.imageDetailScreen, arguments: {'postUrl' :widget.message});
         },
        child: SizedBox(
          width: super.screenWidthPercentage(context, 80),
          height: super.screenHeightPercentage(context, 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GestureDetector(
              child: CachedNetworkImage(
                imageUrl: widget.message,
                fit: BoxFit.cover,
                placeholder: (context, url) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: primaryShade500,
                    ),
                  ],
                ),
                // progressIndicatorBuilder: (context, url, progress) => Center(child: Text('${progress.downloaded.toString()} %')),
                errorWidget: (context, url, error) =>const Center(child: Icon(Icons.error)),
              ),
            ),
          ),
        ),
      );
    }
    if (fileType == CustomUploadFileType.Video) {
      return GestureDetector(
         onTap: () async {
           Navigator.pushNamed(context, RoutesName.videoDetailScreen, arguments: {'postUrl' :widget.message});
         },
        child: Container(
          width: super.screenWidthPercentage(context, 80),
          height: super.screenHeightPercentage(context, 20),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: black),
          child: const Icon(
            Icons.movie,
            size: 20,
            color: white,
          ),
        ),
      );
    }
    if (fileType == CustomUploadFileType.Audio) {
      return Container(
        width: super.screenWidthPercentage(context, 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: CoustomAudioPlayer(
          message: widget.message,
        ),
      );
    }
    if (fileType == CustomUploadFileType.Document) {
      return GestureDetector(
        onTap: () async {
           Navigator.pushNamed(context, RoutesName.fileDetailScreen, arguments: {'postUrl' :widget.message,});
        },
        child: Container(
          width: super.screenWidthPercentage(context, 50),
          height: super.screenHeightPercentage(context, 30),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: primaryShade100),
          child: IgnorePointer(
            ignoring: true,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const PDF().cachedFromUrl(widget.message),
            ),
          ),
        ),
      );
    }

    return Text(
      widget.message ?? '',
      softWrap: true,
      style: CoustomTextStyle.paragraph4.copyWith(
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
