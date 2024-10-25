import 'package:flutter/material.dart';
import 'package:real_estate/presentation/utils/constraints.dart';
import 'package:real_estate/presentation/widget/custom_images.dart';
import 'package:real_estate/presentation/widget/custom_test_style.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/model/agent/agent_details_model.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key, required this.agentDetails});

  final AgentDetailsModel agentDetails;

  @override
  Widget build(BuildContext context) {
    return    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          CustomTextStyle(
              text:
              agentDetails.agent!.aboutMe,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF7E8BA0)),
          const SizedBox(height: 40.0,),
          ContactComponents(image: KImages.phoneIcon, text:  agentDetails.agent!.phone,),
          const SizedBox(height: 6.0,),
          ContactComponents(image: KImages.mailIcon, text:  agentDetails.agent!.email,),
          const SizedBox(height: 6.0,),
          ContactComponents(image: KImages.locationsIcon, text:  agentDetails.agent!.address,),
          const SizedBox(height: 20.0,),
           Row(children: [
            SocialComponents(icon: KImages.linkedinIcon,onTap: (){
              _launchURL(agentDetails.agent!.linkedin);
            },),
            const SizedBox(width: 10.0,),
            SocialComponents(icon: KImages.twitterIcon,onTap: (){
              _launchURL(agentDetails.agent!.twitter);
            },),
            const SizedBox(width: 10.0,),
            SocialComponents(icon: KImages.instagramIcon,onTap: (){
              _launchURL(agentDetails.agent!.instagram);

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
      SizedBox(width: 8.0,),
      CustomTextStyle(text: text)
    ],);
  }
}
