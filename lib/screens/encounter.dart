import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_card_swiper/models/photo_card.dart';
import 'package:photo_card_swiper/photo_card_swiper.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../common/services/data_transport.dart' as data_transport;
import '../common/services/utils.dart';
import '../common/widgets/common.dart';
import 'profile_details.dart';
import 'user_common.dart';
import '../../support/app_theme.dart' as app_theme;

class EncounterPage extends StatefulWidget {
  const EncounterPage({super.key});

  @override
  EncounterPageState createState() => EncounterPageState();
}

class EncounterPageState extends State<EncounterPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  PhotoCard? encounterCard;
  Map encounteredUserData = {};
  bool isLoaded = false;
  bool encounterAvailability = false;
  List<PhotoCard> encounterCards = [];
  List<SwipeItem> _swipeItems = [];
  late MatchEngine _matchEngine;
  bool _showLikeIcon = false;
  bool _showDisLikeIcon = false;
  @override
  void initState() {
    super.initState();
    _matchEngine =
        MatchEngine(swipeItems: _swipeItems); // Initialize with an empty list
    if (mounted) {
      getEncounterData();
    }
  }

  /// Get initial encounter data
  getEncounterData() {
    data_transport.get(
      'encounter-data',
      context: context,
      onSuccess: (responseData) {
        setState(() {
          isLoaded = true;
          encounterAvailability =
              getItemValue(responseData, 'data.encounterAvailability');
          var tempEncounteredUserData = getItemValue(
            responseData,
            'data.randomUserData',
            fallbackValue: {},
          );
          if (tempEncounteredUserData is List) {
            encounteredUserData = {};
          } else {
            encounteredUserData = tempEncounteredUserData;
          }

          if (encounteredUserData.isNotEmpty) {
            encounterCards = [
              PhotoCard(
                cardId: encounteredUserData['_uid'],
                description: Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          encounteredUserData['userFullName'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 21,
                              color: app_theme.primary),
                        ),
                        Text(
                          encounteredUserData['detailString'] ?? '',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors
                                  .white), // Optional: Change text color for better visibility
                        )
                      ],
                    ),
                    const Divider(
                      height: 10,
                      color: app_theme.primary,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: Colors.white
                            .withOpacity(0.1), // Transparent white color
                      ),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: 10, sigmaY: 10), // Blur effect
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              encounteredUserData['countryName'] ?? '',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors
                                      .white), // Optional: Change text color for better visibility
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
                itemWidget: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    AppCachedNetworkImage(
                      height: double.infinity,
                      // imageUrl: encounteredUserData['userCoverUrl'],
                      imageUrl: encounteredUserData['userImageUrl'],
                    ),
                    // Positioned(
                    //   bottom: 10,
                    //   child: CircleAvatar(
                    //     radius: 80,
                    //     backgroundImage: appCachedNetworkImageProvider(
                    //       imageUrl: encounteredUserData['userImageUrl'],
                    //     ),
                    //   ),
                    // ),
                    if ((encounteredUserData['isPremiumUser'] != null) &&
                        encounteredUserData['isPremiumUser'])
                      const Positioned(
                        top: 10,
                        right: 10,
                        child: PremiumBadgeWidget(),
                      ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: ((encounteredUserData['userOnlineStatus'] == 1)
                              ? Colors.green
                              : (encounteredUserData['userOnlineStatus'] == 2
                                  ? Colors.orange
                                  : Colors.red)),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
                isLocalImage: false,
              ),
            ];

            _swipeItems = encounterCards.map((card) {
              return SwipeItem(
                content: card,
                likeAction: () {
                  rightButtonAction
                  ();
                  showLikeIcon();

                },
                nopeAction: () {
                  leftButtonAction();
                  showDisLikeIcon();


                },
                superlikeAction: () {
                  cardSwiped(encounterCards.indexOf(card));
                },
                onSlideUpdate: (SlideRegion? region) async {
                  print("Region $region");

                  if(region == SlideRegion.inNopeRegion){

                      showDisLikeIcon();

                  }

                  if( region ==  SlideRegion.inLikeRegion){
                    showLikeIcon();

                  }

                },
              );
            }).toList();

            _matchEngine = MatchEngine(
                swipeItems:
                    _swipeItems); // Update _matchEngine with new swipe items
          }
        });
      },
    );
  }

  void showLikeIcon() {
    setState(() {
      _showLikeIcon = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _showLikeIcon = false;
      });
    });
  }

  void showDisLikeIcon() {
    setState(() {
      _showDisLikeIcon = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _showDisLikeIcon = false;
      });
    });
  }

  void rightButtonAction() {
    data_transport.post(
      "encounters/${encounteredUserData['_uid']}/1/user-encounter-like-dislike",
      context: context,
      onSuccess: (responseData) {
        getEncounterData();
      },
    );
  }

  void leftButtonAction() {
    data_transport.post(
      "encounters/${encounteredUserData['_uid']}/2/user-encounter-like-dislike",
      context: context,
      onSuccess: (responseData) {
        getEncounterData();
      },
    );
  }

  void cardSwiped(int index) {
    data_transport.post(
      "encounters/${encounteredUserData['_uid']}/skip-encounter-user",
      context: context,
      onSuccess: (responseData) {
        getEncounterData();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          !isLoaded
              ? const Center(child: AppItemProgressIndicator())
              : encounterAvailability == false
                  ? const BePremiumAlertInfo()
                  : (encounteredUserData.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 100),
                          child: SwipeCards(
                            matchEngine: _matchEngine,
                            itemBuilder: (BuildContext context, int index) {
                              return _swipeItems[index].content.itemWidget;
                            },
                            onStackFinished: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("No more cards"),
                                duration: Duration(milliseconds: 500),
                              ));
                            },
                            itemChanged: (SwipeItem item, int index) {
                              print("Item changed: ${item.content.cardId}");
                            },
                            upSwipeAllowed: false,
                            fillSpace: false,
                          ),
                        )
                      : const Center(
                          child: Text(
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                              'Your daily limit for encounters may exceed or there are no users to show.'),
                        )),
          if (_showLikeIcon)

            Lottie.asset('assets/images/like.json'),

            // const Center(
            //   child: Icon(
            //     Icons.favorite,
            //     color: Colors.red,
            //     size: 100,
            //   ),
            // ),
          if (_showDisLikeIcon)
            Lottie.asset('assets/images/dislike.json'),
            // const Center(
            //   child: Icon(
            //     Icons.thumb_down,
            //     color: app_theme.primary,
            //     size: 100,
            //   ),
            // ),
        ],
      ),
    );
  }
}
