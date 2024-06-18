import 'package:flutter/material.dart';
import 'package:loveria/common/services/utils.dart';
import 'package:loveria/screens/user_common.dart';
import 'dart:io';
import '../../screens/profile_image_update.dart';
import './../services/auth.dart' as auth;
import '../../support/app_theme.dart' as app_theme;

class UserProfileWidget extends StatelessWidget {
  final String profilePicUrl;
  final String? userName;
  final String? matchRatio;
  final bool isPremium;
  final File? selectedImageProfile;

  const UserProfileWidget({
    Key? key,
    required this.profilePicUrl,
    this.userName,
    this.matchRatio,
    this.isPremium = false,
    this.selectedImageProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigatePage(
            context,
            ProfileImageView(
              title: const Text('Profile Photo'),
              imageUrl: auth.getAuthInfo('profile_picture_url'),
              actions: [
                IconButton(
                    icon: const Icon(Icons.edit),
                    tooltip: 'Upload New Photos',
                    onPressed: () {
                      navigatePage(
                        context,
                        const ProfileImageUpdatePage(),
                      );
                    }),
              ],
            ));
      },
      child: Container(
        margin: EdgeInsets.only(top: 80, left: 20, bottom: 20),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topLeft,
          children: [
            matchRatio == null
                ? const SizedBox()
                : SizedBox(
                    height: 70,
                    width: 70,
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                      valueColor: const AlwaysStoppedAnimation(
                        app_theme.primary,
                      ), // Replace with your color
                      value: double.parse(matchRatio!.split(".").first) / 100,
                    ),
                  ),
            profilePicUrl != null
                ? Container(
                    height: 66,
                    width: 66,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(profilePicUrl!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : selectedImageProfile == null
                    ? CircleAvatar(
                        backgroundColor: Colors.grey.withOpacity(0.2),
                        maxRadius: 33,
                        child: Center(
                          child: Text(
                            userName?[0] ?? "",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: FileImage(selectedImageProfile!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
            isPremium
                ? Positioned(
                    top: -10,
                    child: Image.asset(
                      "assets/images/tajicon.png",
                      height: 25,
                      width: 25,
                    ),
                  )
                : const SizedBox(),
            matchRatio == null
                ? const SizedBox()
                : Positioned(
                    bottom: -10,
                    child: Container(
                      height: 22,
                      width: 35,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        height: 22,
                        width: 35,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(
                              255, 51, 123, 109), // Replace with your color
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "$matchRatio%",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ),
            Positioned(
                left: 80,
                child: Text(
                    '${auth.getAuthInfo('full_name')} (${auth.getAuthInfo('username')})')),
            Positioned(
                left: 80, bottom: 20, child: Text(auth.getAuthInfo('email')))
          ],
        ),
      ),
    );
  }
}
