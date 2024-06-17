import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/widget/background_widget.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';
import 'package:photo_view/photo_view.dart';

class ViewImage extends StatelessWidget {
  String image;

  ViewImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      hasAppBar: true,
      titleWidget: TextView(
        text: "",
        textAlign: TextAlign.start,
        textStyle: GoogleFonts.roboto(
            fontSize: setSp(22),
            color: Pallet.black,
            fontWeight: FontWeight.w500),
      ),
      body: Container(
        child: SafeArea(
          child: PhotoView(
            backgroundDecoration: const BoxDecoration(color: Pallet.white),
            imageProvider: CachedNetworkImageProvider(image),
          ),
        ),
      ),
    );
  }
}
