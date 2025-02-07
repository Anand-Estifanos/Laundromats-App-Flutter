import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundromats/src/common/header.widget.dart';
import 'package:laundromats/src/common/profile_status.widget.dart';
import 'package:laundromats/src/components/bottom_nav_bar.dart';
import 'package:laundromats/src/constants/app_styles.dart';
import 'package:laundromats/src/utils/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  double screenHeight = 0;
  double keyboardHeight = 0;
  final int _currentIndex = 4;
  final bool _isKeyboardVisible = false;

  String? userName;
  String? userEmail;
  int? askedCount;
  int? commentCount;
  int? likeCount;
  int? dislikeCount;

  final logger = Logger();

  @override
  void initState() {
    super.initState();
    getUserQuestions();
  }

  Future<void> getUserQuestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userName = prefs.getString("userName");
      userEmail = prefs.getString("userEmail");
    });
  }

  Future<bool> _onWillPop() async => false;

  @override
  Widget build(BuildContext context) {
    if (_isKeyboardVisible) {
      screenHeight = MediaQuery.of(context).size.height;
    } else {
      screenHeight = 800;
      keyboardHeight = 0;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: kColorWhite,
        resizeToAvoidBottomInset: true,
        body: SizedBox.expand(
          child: SingleChildScrollView(
            child: FocusScope(
              child: Container(
                decoration: const BoxDecoration(color: kColorWhite),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const HeaderWidget(role: true, isLogoutBtn: true),
                    Container(
                      padding: EdgeInsets.only(
                        top: vMin(context, 5),
                        left: vMin(context, 4),
                        right: vMin(context, 4),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Like Count on the Left
                              Column(
                                children: [
                                  Text(
                                    likeCount?.toString() ?? '0',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: kColorPrimary,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.thumb_up,
                                    color: kColorPrimary,
                                    size: 24,
                                  ),
                                ],
                              ),
                              // User Image in the Center
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: kColorPrimary,
                                    width: 1,
                                  ),
                                ),
                                child: const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.person,
                                    color: kColorPrimary,
                                    size: 90,
                                  ),
                                ),
                              ),
                              // Dislike Count on the Right
                              Column(
                                children: [
                                  Text(
                                    dislikeCount?.toString() ?? '0',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: kColorSecondary,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.thumb_down,
                                    color: kColorSecondary,
                                    size: 24,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: vMin(context, 1)),
                          Text(
                            userName ?? 'Guest',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Onset-Regular',
                              color: kColorSecondary,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: vMin(context, 0.5)),
                          // Text(
                          //   userEmail ?? 'Guest Email',
                          //   style: const TextStyle(
                          //     fontSize: 16,
                          //     fontWeight: FontWeight.bold,
                          //     color: kColorPrimary,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    ProfileStatusWidget(
                      askedCount: askedCount ?? 0,
                      commentCount: commentCount ?? 0,
                    ),
                    SizedBox(
                      height: vh(context, 5),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBar(currentIndex: _currentIndex),
      ),
    );
  }
}
