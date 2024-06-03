import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:instagram_clone/components/back_button_navbar.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';

class PdfDetails extends StatefulWidget {
  String url;

  PdfDetails({
    super.key,
    required this.url,
  });

  @override
  State<PdfDetails> createState() => _PdfDetailsState();
}

class _PdfDetailsState extends State<PdfDetails> with ScreenUtils {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SizedBox(
        width: super.screenWidthPercentage(context, 100),
        height: super.screenHeightPercentage(context, 100),
        child: Stack(
          children: [


            PDF(
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: false,
              pageFling: false,
              onError: (error) {
                print(error.toString());
              },
              onPageError: (page, error) {
                print('$page: ${error.toString()}');
              },
              onPageChanged: (page, total) {},
            ).cachedFromUrl(
              widget.url,
              placeholder: (progress) =>
                  Center(child: Text('$progress %')),
              errorWidget: (error) => Center(child: Text(error.toString())),
            ),

            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: BackButtonNavbar(
                    onPress: () {
                      Navigator.pop(context);
                    },
                    center: null),
              ),
            ),

           
          ],
        ),
      ),
    );
  }
}
