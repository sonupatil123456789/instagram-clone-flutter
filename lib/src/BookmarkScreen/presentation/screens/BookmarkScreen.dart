
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/components/back_button_navbar.dart';
import 'package:instagram_clone/components/cards/discover_grid_card.dart';
import 'package:instagram_clone/src/BookmarkScreen/domain/use_cases/DeletBookmarkUsecase.dart';
import 'package:instagram_clone/src/BookmarkScreen/presentation/bloc/BookmarkBloc.dart';
import 'package:instagram_clone/src/BookmarkScreen/presentation/bloc/BookmarkEvent.dart';
import 'package:instagram_clone/src/BookmarkScreen/presentation/bloc/BookmarkState.dart';
import 'package:instagram_clone/src/HomeScreen/presentation/bloc/HomeEvent.dart';
import 'package:instagram_clone/utils/resources/enums.dart';
import 'package:instagram_clone/utils/screen_utils/screen_utils.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';
import 'package:instagram_clone/utils/theams/text_theams.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> with ScreenUtils {
  initialise(BuildContext context, bool refresh) async {
    context
        .read<BookmarkBloc>()
        .add(GetAllBookmarkEvent(context: context, isRefresh: true));
  }

  @override
  void initState() {
    super.initState();
    // initialise(context, false);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
     initialise(context, false);
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
              BackButtonNavbar(
                onPress: () {
                  Navigator.pop(context);
                },
                center: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Bookmarks",
                    style: CoustomTextStyle.paragraph1,
                  ),
                ),
              ),

              const SizedBox(height: 20,),
              LiquidPullToRefresh(
                showChildOpacityTransition: false,
                springAnimationDurationInMilliseconds: 200,
                color: primaryShade200,
                backgroundColor: primaryShade50,
                onRefresh: () async {
                  context.read<BookmarkBloc>().add(
                      GetAllBookmarkEvent(context: context, isRefresh: true));
                },
                child: Container(
                  width: super.screenWidthPercentage(context, 100),
                  height: super.screenHeightPercentage(context, 80),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                      horizontal: super.screenWidthPercentage(context, 4)),
                  child: BlocBuilder<BookmarkBloc, BookmarkState>(
                    buildWhen: (previous, current) => previous.currentState != current.currentState,
                      builder: (context, BookmarkState state) {
                    if (state.currentState == CurrentAppState.ERROR) {
                      return  Text("Some Error Occured " ,     style: CoustomTextStyle.paragraph4,);
                    }

                    if (state.currentState == CurrentAppState.SUCCESS) {
                      if (state.bookmarkList!.isEmpty) {
                        return  Text("No Bookmarks Yet" ,     style: CoustomTextStyle.paragraph4,);
                      }

                      return GridView.custom(
                        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                        ),
                        childrenDelegate: SliverChildBuilderDelegate(
                            childCount: state.bookmarkList!.length,
                            (context, index) {
                          final bookmarkData = state.bookmarkList![index];

                          return DiscoverGridCard(
                            postData: bookmarkData,
                            longPress: (){
                             deletBookmark(bookmarkData.postId! ,context);
                            },
                          );
                        }),
                      );
                    }

                    return CircularProgressIndicator(
                      color: primaryShade500,
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



Future<dynamic> deletBookmark(String bookmarkId ,BuildContext context ){
  return showDialog(
    context:context ,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: primaryShade50,
        title: Text(
          'Delete Confirmation',
          style: CoustomTextStyle.paragraph1,
        ),
        content: Text('Are you sure you want to delete comment . After deleting we cannot cancell the deletion ?', style: CoustomTextStyle.paragraph4,),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
              child:  Text('Delet', style: CoustomTextStyle.paragraph3.copyWith(color: primaryShade500),),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child:  Text('Cancel', style: CoustomTextStyle.paragraph3,),
          ),
        ],
      );
    },
  ).then((confirmed) {
    if (confirmed == true) {
      context.read<BookmarkBloc>().add(DeletBookmarkEvent(context: context, bookmarkId: bookmarkId));
    } else {}
  });
}