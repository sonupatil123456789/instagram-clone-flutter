import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/components/back_button_navbar.dart';
import 'package:instagram_clone/components/cards/chat_card.dart';
import 'package:instagram_clone/src/Authantication/data/model/UserModel.dart';
import 'package:instagram_clone/src/Authantication/domain/entity/UserEntity.dart';
import 'package:instagram_clone/src/Authantication/presentation/bloc/AuthBloc.dart';
import 'package:instagram_clone/src/ChatListScreen/presentation/bloc/ChatListBloc.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}
// getFollowersStatusStreamEvent
class _ChatListScreenState extends State<ChatListScreen> with ScreenUtils {


  UserEntity userData =  UserModel();

    initialise(BuildContext context, bool refresh) async {
    userData = await context.read<AuthBloc>().getUserDetails(context, refresh);
    setState(() {});
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialise(context , false);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryShade50,
      body: SizedBox(
        width: super.screenWidthPercentage(context, 100),
        height: super.screenHeightPercentage(context, 100),
        child: SafeArea(
          child: Column(
            children: [
              // appbar section

             BackButtonNavbar(onPress: (){
                  Navigator.pop(context);
                }, center: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                        "@ ${userData.uniqueName}",
                        style: CoustomTextStyle.paragraph1,
                      ),
                ),),



              const SizedBox(
                height: 20,
              ),

              Expanded(
                child: Container(
                  height: super.screenHeightPercentage(context, 80),
                  child: LiquidPullToRefresh(
                      showChildOpacityTransition: false,
                      springAnimationDurationInMilliseconds: 200,
                      color: primaryShade200,
                      backgroundColor: primaryShade50,
                      onRefresh: () async {
                          initialise(context , true);
                      },

                    child:  Container(
                    width: super.screenWidthPercentage(context, 100),
                    height: super.screenHeightPercentage(context, 70),
                    child: StreamBuilder(
                      stream: context.read<ChatListBloc>().getFollowersStatusStreamEvent(context, userData.following ?? []),
                      builder: (BuildContext context,AsyncSnapshot<List<UserEntity>> snapshot) {

                        if (snapshot.connectionState ==ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: primaryShade500,
                            ),
                          );
                        }

                        if (snapshot.connectionState ==ConnectionState.active) {
                          if (snapshot.data?.length == 0) {
                            return Container(
                              height: 500,
                              alignment: Alignment.center,
                              child: Text(
                                "No Chat Yet",
                                style: CoustomTextStyle.paragraph4,
                              ),
                            );
                          }

                          final value = snapshot.data;
                          // print(value?.length);
                          return ListView.builder(
                            itemCount: value!.length ?? 0,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              final userData = value[index];
                               return ChatCard(userData: userData,);
                            },
                          );
                        }

                        // if (snapshot.hasError) {
                        return Container(
                            height: 500,
                            alignment: Alignment.center,
                            child: Text(
                                snapshot.error.toString() ??
                                    "Some Error Occured",
                                style: CoustomTextStyle.paragraph4));
                        // }
                      },
                    ),
                  ),


                      // child: ListView.separated(
                      //   itemBuilder: (BuildContext context, int index) {
                      //     return ChatCard();
                      //   },
                        // separatorBuilder: (BuildContext context, int index) {
                        //   return const SizedBox(
                        //     height: 1,
                        //   );
                        // },
                      //   itemCount: 20,
                      // ),
                      ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
