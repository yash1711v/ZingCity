import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/logic/bloc/login/login_bloc.dart';
import 'package:real_estate/logic/cubit/company/company_cubit.dart';
import 'package:real_estate/presentation/widget/custom_images.dart';
import 'package:real_estate/presentation/widget/custom_test_style.dart';
import '../../router/route_names.dart';
import '../../utils/constraints.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widget/custom_app_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late LoginBloc loginBloc;
  late CompanyCubit cCubit;

  @override
  void initState() {
    loginBloc = context.read<LoginBloc>();
    cCubit = context.read<CompanyCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: scaffoldBackground,
      appBar: const CustomAppBar(title: 'Agent Dashboard', showButton: false),
      body: Padding(
        padding: Utils.symmetric(h: 12.0),
        child:  Column(children: [
         // loginBloc.userInfo!.user.ownerId == 0 ?
          DashboardComponents(icon: KImages.companyIcon,title: "My Company",onTap: (){
            print("agency is ${loginBloc.userInfo!.user.isAgency}");
            if(loginBloc.userInfo!.user.isAgency == 1){
              Navigator.pushNamed(context, RouteNames.companyScreen);
            } else if (loginBloc.userInfo!.user.isAgency == 2){
            Utils.showCustomDialog(
                context,
                barrierDismissible: true,
                child: const SizedBox(
              height: 150,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                Center(child: CustomTextStyle(text: "Admin will verify your application.",fontSize: 16.0,fontWeight: FontWeight.w500,color: redColor,))
              ],),
            ));
            }
            else if (loginBloc.userInfo!.user.isAgency == 0){
              cCubit.resetData();
              Navigator.pushNamed(context, RouteNames.createCompanyScreen);
            }

          },),
              // : const SizedBox.shrink(),
          const SizedBox(height: 12.0,),
          DashboardComponents(icon: KImages.homeProIcon,title: "My Properties",onTap: (){
            Navigator.pushNamed(context, RouteNames.profileScreen);
          }),
          const SizedBox(height: 12.0,),
          DashboardComponents(icon: KImages.reviewIcon,title: "All Reviews",onTap: (){
            Navigator.pushNamed(context, RouteNames.reviewScreen);
          }),
        ],),
      ),
    );
  }
}

class DashboardComponents extends StatelessWidget {
  const DashboardComponents({
    super.key, required this.title, required this.icon, required this.onTap,
  });

  final String title;
  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0),
        color: whiteColor
        ),
        child: Padding(
          padding: Utils.symmetric(h: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Row(children: [
              Container(
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: const Color(0xFFF5F4FF),
                ),
                child: Padding(
                  padding:Utils.all(value: 10.0),
                  child:  CustomImage(path: icon,),
                ),
              ),
              const SizedBox(width: 20.0,),
               CustomTextStyle(text: title,fontSize: 16,fontWeight: FontWeight.w400,),

            ],),
            Container(
              height: 32,
              width: 32,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFF5F4FF),
              ),
              child: Padding(
                padding: Utils.all(value: 8.0),
                child: const Center(child: CustomImage(path: KImages.arrowIcon,)),
              ),
            ),
          ],),
        ),
      ),
    );
  }
}
