import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/user_services.dart';

import 'package:flutter_application_2/widgets/my_text.dart';
import 'package:flutter_application_2/widgets/sliver_app_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

import '../models/comments_records_model.dart';
import '../services/user_comments_services.dart';
import '../widgets/comments_dialog.dart';

class Comments extends StatefulWidget {
  final String gameId;
  final String gameName;
  const Comments({super.key, required this.gameId, required this.gameName});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  var isloaded = false;
  List<CommentsRecordsModel> comments = [];
  String userName = '';

  @override
  void initState() {
    initComments();

    super.initState();
  }

  void initComments() async {
    comments = await fetchCommentsRecords(widget.gameId);
    userName = await getUserName();
    if (comments.isNotEmpty && userName.isNotEmpty) {
      setState(() {
        isloaded = true;
        //print('Users id are ${comments[1].userId}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          MySliverAppbar(
            text: 'Comments on \n${widget.gameName}',
            ontap: () => context.go('/gamedetails/${int.parse(widget.gameId)}'),
            noBack: false,
          ),
          SliverToBoxAdapter(
            child: Visibility(
              visible: isloaded,
              replacement: const Center(
                heightFactor: 18,
                child: MyText(
                    text: "No Comments For This Game",
                    size: 25,
                    weight: FontWeight.bold),
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            color: Colors.grey.withOpacity(0.4),
                          ),
                          height: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GetUsersNames(
                                  userId: comments[index]
                                      .userId), // comments[index].userId
                              RatingBar.builder(
                                initialRating: comments[index].starsNumber,
                                minRating: 0.5,
                                ignoreGestures: true,
                                allowHalfRating: true,
                                itemSize: 20,
                                itemBuilder: (context, index) {
                                  return const Icon(Icons.star,
                                      color: Colors.amber);
                                },
                                onRatingUpdate: (value) {},
                              ),
                              const MyText(
                                text: 'Comment :',
                                size: 10,
                                paddingSize: 8,
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                height: 94,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  color: Colors.white.withOpacity(0.4),
                                ),
                                child: MyText(
                                  text: comments[index].commentDescription,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    })),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showcommentdialog(context, widget.gameId);
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(
          Icons.comment,
          color: Colors.white,
        ),
      ),
    );
  }
}
