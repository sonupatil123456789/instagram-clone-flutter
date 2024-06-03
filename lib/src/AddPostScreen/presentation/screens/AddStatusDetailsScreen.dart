import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/components/coustom_button.dart';
import 'package:instagram_clone/components/coustom_chips.dart';
import 'package:instagram_clone/src/AddPostScreen/data/model/TagPeopleModel.dart';
import 'package:instagram_clone/src/AddPostScreen/presentation/bloc/PostBloc.dart';
import 'package:instagram_clone/src/AddPostScreen/presentation/bloc/PostEvents.dart';
import 'package:instagram_clone/src/AddPostScreen/presentation/bloc/PostState.dart';
import 'package:instagram_clone/src/AddPostScreen/presentation/widgets/PostTextField.dart';
import 'package:instagram_clone/src/AddPostScreen/presentation/widgets/TagUserBottomSheet.dart';
import 'package:instagram_clone/utils/resources/enums.dart';
import 'package:instagram_clone/utils/screen_utils/file_model.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import '../../../../components/back_button_navbar.dart';
import '../../../../utils/theams/text_theams.dart';

class AddStatusDetailsScreen extends StatefulWidget {
  FileData fileData;

  AddStatusDetailsScreen({super.key, 
    required this.fileData,
  });

  @override
  State<AddStatusDetailsScreen> createState() => _AddStatusDetailsScreenState();
}

class _AddStatusDetailsScreenState extends State<AddStatusDetailsScreen>
    with ScreenUtils {
  TextEditingController discription = TextEditingController();

  @override
  void dispose() {
    discription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryShade50,
      body: SizedBox(
        width: super.screenWidthPercentage(context, 100),
        height: super.screenHeightPercentage(context, 100),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // appbar section
                BackButtonNavbar(
                  onPress: () {
                    Navigator.pop(context);
                  },
                  center: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Status Discription",
                      style: CoustomTextStyle.paragraph1,
                    ),
                  ),
                ),

                if (widget.fileData.fileData is PlatformFile &&
                    widget.fileData.coustomfileType ==
                        CustomUploadFileType.Video) ...[
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      color: blac2,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.movie,
                        color: white,
                      ),
                    ),
                  )
                ],

                if (widget.fileData.fileData is PlatformFile &&
                    widget.fileData.coustomfileType ==
                        CustomUploadFileType.Image) ...[
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.file(File(widget.fileData.fileData.path)),
                  )
                ],
                if (widget.fileData.fileData is XFile &&
                    widget.fileData.coustomfileType ==
                        CustomUploadFileType.Image) ...[
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.file(File(widget.fileData.fileData.path)),
                  )
                ],

                const SizedBox(
                  height: 20,
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: super.screenWidthPercentage(context, 100),
                  height: super.screenHeightPercentage(context, 5),
                  child: BlocBuilder<PostBloc, PostState>(
                    builder: (BuildContext context, PostState state) {
                      return ListView.builder(
                        itemCount: state.hashTags.length ?? 0,
                        padding: EdgeInsets.only(
                            left: super.screenWidthPercentage(context, 6)),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (state.hashTags == []) {
                            return const SizedBox();
                          }
                          final data = state.hashTags[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Text(
                              data,
                              style: CoustomTextStyle.paragraph4,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                GestureDetector(
                  onTap: () {
                    showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return const SearchUserToTagBottomSheet();
                        });
                  },
                  child: Container(
                    width: super.screenWidthPercentage(context, 90),
                    height: super.screenHeightPercentage(context, 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: primaryShade200, width: 1),
                        color: primaryShade50),
                    child: Stack(
                      alignment: Alignment.center,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Positioned(
                            left: super.screenWidthPercentage(context, 20),
                            child: Icon(
                              Icons.label,
                              color: primaryShade500,
                            )),
                        Text(
                          "Tag People",
                          style: CoustomTextStyle.paragraph3
                              .copyWith(color: primaryShade500),
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                PostTextField(
                  onPress: () {},
                  touchDetecter: false,
                  controller: discription,
                  isPassword: true,
                  maxLine: null,
                  width: super.screenWidthPercentage(context, 90),
                  validateTextField: (valPassword) {},
                  getTextFieldValue: (val) {},
                  lable: 'Discription',
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  width: super.screenWidthPercentage(context, 100),
                  height: super.screenHeightPercentage(context, 8),
                  child: BlocBuilder<PostBloc, PostState>(
                    builder: (BuildContext context, PostState state) {
                      return ListView.builder(
                        itemCount: state.tagPeoples.length ?? 0,
                        padding: EdgeInsets.only(
                            left: super.screenWidthPercentage(context, 6)),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (state.tagPeoples == []) {
                            return const SizedBox();
                          }

                          final data = state.tagPeoples[index];
                          return CoustomChips(
                              text: data.uniqueName.toString(),
                              onIconPress: (data) {
                                context.read<PostBloc>().add(
                                      TagPeopleEvent(
                                        context: context,
                                        tagPeoples: TagPeopleModel(
                                            uuid: data.uuid,
                                            profileImage: data.profileImage,
                                            uniqueName: data.uniqueName),
                                      ),
                                    );
                                  discription.clear();
                              },
                              data: data);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          BlocBuilder<PostBloc, PostState>(builder: (context, state) {
        return Container(
          height: super.screenHeightPercentage(context, 12),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state.currentState == CurrentAppState.LOADING) ...[
                CircularProgressIndicator(
                  color: primaryShade500,
                )
              ] else ...[
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: CoustomButton(
                    height: super.screenHeightPercentage(context, 6),
                    backgroundColor: primaryShade500,
                    text: 'Upload Post',
                    onTap: () async {
                      context.read<PostBloc>().add(UploadStatusEvent(
                          context: context,
                          fileData: widget.fileData,
                          discription: discription.text.trim()));
                    },
                    width: super.screenWidthPercentage(context, 90),
                    borderRadious: screenWidthPercentage(context, 20),
                  ),
                ),
              ]
            ],
          ),
        );
      }),
    );
  }
}
