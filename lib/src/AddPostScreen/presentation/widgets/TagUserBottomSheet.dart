import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/components/back_button_navbar.dart';
import 'package:instagram_clone/src/AddPostScreen/data/model/TagPeopleModel.dart';
import 'package:instagram_clone/src/AddPostScreen/presentation/widgets/user_list_card.dart';
import 'package:instagram_clone/components/search_bar.dart';
import 'package:instagram_clone/src/AddPostScreen/presentation/bloc/PostBloc.dart';
import 'package:instagram_clone/src/AddPostScreen/presentation/bloc/PostEvents.dart';
import 'package:instagram_clone/src/Authantication/presentation/bloc/AuthBloc.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';

import '../../../Authantication/domain/entity/UserEntity.dart';

class SearchUserToTagBottomSheet extends StatefulWidget {
  const SearchUserToTagBottomSheet({super.key});

  @override
  State<SearchUserToTagBottomSheet> createState() =>
      _SearchUserToTagBottomSheetState();
}

class _SearchUserToTagBottomSheetState extends State<SearchUserToTagBottomSheet>
    with ScreenUtils {

  String searchbar = "";
  Timer? _debounce;
  late AuthBloc _authBloc;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AuthBloc>().getAllUserStreamList(context , "");
  }


      @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authBloc = context.read<AuthBloc>();
    // _authBloc.state.userListStream = StreamController<List<UserEntity>>.broadcast();
   
  }

  @override
  void dispose() {
    // _authBloc.state.userListStream.close();
    _debounce?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {


    return Container(
      decoration: BoxDecoration(
         color: primaryShade50,
         borderRadius: const BorderRadius.all(Radius.circular(30))
      ),
        width: super.screenWidthPercentage(context, 100),
        height: super.screenHeightPercentage(context, 90),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
                
              /// app bar section'
              BackButtonNavbar(
                  onPress: () {
                    Navigator.pop(context);
                  },
                  icon: Icons.close,
                     center: Text("Tag People" ,style: CoustomTextStyle.paragraph2,)),
                
              // search bars section
              Container(
                  width: super.screenWidthPercentage(context, 100),
                  height: super.screenHeightPercentage(context, 10),
                   padding: EdgeInsets.symmetric(
                    horizontal: super.screenWidthPercentage(context, 5)),
                  child: CoustomSearchBar(
                    onPress: () {},
                    touchDetecter: false,
                    height: super.screenHeightPercentage(context, 10),
                    width: super.screenWidthPercentage(context, 100),
                    validateTextField: (value) {},
                    getTextFieldValue: (value) {
                      if (_debounce?.isActive ?? false) _debounce?.cancel();
                
                      _debounce = Timer(const Duration(seconds: 2), () {
                          // setState(() {
                          searchbar = value;
                          context.read<AuthBloc>().getAllUserStreamList(context, searchbar.toString() ?? "");
                        });
                      // });
                    },
                  )),
                
              Expanded(
                child: StreamBuilder(
                  stream: context.read<AuthBloc>().state.userListStream.stream,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<UserEntity>?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: primaryShade500,
                        ),
                      );
                    }
                      
                    if (snapshot.hasError) {
                      return Container(
                          height: 500,
                          alignment: Alignment.center,
                          child: Text("Some Error Occured",
                              style: CoustomTextStyle.paragraph4));
                    }
                      
                    if (snapshot.data!.isEmpty) {
                      return Container(
                        height: 500,
                        alignment: Alignment.center,
                        child: Text(
                          "No User",
                          style: CoustomTextStyle.paragraph4,
                        ),
                      );
                    }
                      
                    final value = snapshot.data;
                    // print(value?.length);
                    return ListView.builder(
                      itemCount: value?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return UserListCard(
                          data: value?[index],
                          onPressTrailing: (uuid, UserEntity data) {
                            context.read<PostBloc>().add(
                                  TagPeopleEvent(
                                    context: context,
                                    tagPeoples: TagPeopleModel(
                                        uuid: data.uuid,
                                        profileImage: data.profileImage,
                                        uniqueName: data.uniqueName),
                                  ),
                                );
                          },
                          index: index,
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
  
    );
  }
}
