import 'package:flutter/material.dart';
import 'package:real_estate/data/model/agency/agency_details_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_images.dart';
import '../../../../widget/custom_test_style.dart';

class AgencyAboutScreen extends StatelessWidget {
  const AgencyAboutScreen({super.key, required this.agencyDetails});

  final AgencyDetailsModel agencyDetails;

  @override
  Widget build(BuildContext context) {
    return    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          CustomTextStyle(
              text:
              agencyDetails.agency!.aboutMe,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF7E8BA0)),
          const SizedBox(height: 40.0,),
          ContactComponents(image: KImages.phoneIcon, text:  agencyDetails.agency!.phone,),
          const SizedBox(height: 6.0,),
          ContactComponents(image: KImages.mailIcon, text:  agencyDetails.agency!.email,),
          const SizedBox(height: 6.0,),
          ContactComponents(image: KImages.locationsIcon, text:  agencyDetails.agency!.address,),
          const SizedBox(height: 20.0,),
          Row(children: [
            SocialComponents(icon: KImages.linkedinIcon,onTap: (){
              _launchURL(agencyDetails.agency!.linkedin);
            },),
            const SizedBox(width: 10.0,),
            SocialComponents(icon: KImages.twitterIcon,onTap: (){
              _launchURL(agencyDetails.agency!.twitter);
            },),
            const SizedBox(width: 10.0,),
            SocialComponents(icon: KImages.instagramIcon,onTap: (){
              _launchURL(agencyDetails.agency!.instagram);



            },),
          ],),

        ],
      ),
    );
  }
}

Future<void> _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}

class SocialComponents extends StatelessWidget {
  const SocialComponents({
    super.key, required this.icon, required this.onTap,
  });
  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(
                color: borderColor
            ),
            color: whiteColor
        ),
        child: Padding(
          padding: Utils.all(value: 12.0),
          child:  CustomImage(path: icon,height: 20,color: const Color(0xFF7E8BA0),),
        ),
      ),
    );
  }
}

class ContactComponents extends StatelessWidget {
  const ContactComponents({
    super.key, required this.image, required this.text,
  });
  final String image;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      CustomImage(path: image),
      const SizedBox(width: 8.0,),
      CustomTextStyle(text: text)
    ],);
  }
}
