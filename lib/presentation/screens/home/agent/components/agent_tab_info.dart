import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:real_estate/presentation/screens/home/agent/components/agency_list_screen.dart';
import 'package:real_estate/presentation/widget/custom_test_style.dart';
import '../../../../../data/model/auth/user_profile_model.dart';
import '../../../../../state_inject_package_names.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../component/all_broker_agent_list.dart';

class AgentTabInfo extends StatefulWidget {
  const AgentTabInfo({super.key, required this.agents});

  final List<UserProfileModel> agents;

  @override
  State<AgentTabInfo> createState() => _AgentTabInfoState();
}

class _AgentTabInfoState extends State<AgentTabInfo> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> detailScreen = [
      AgentListScreen(agents: widget.agents,),
      const AgencyListScreen(),
    ];
    final List<String> tabTitle = [
      Utils.translatedText(context, 'Agent'),
      Utils.translatedText(context, 'Agency')
    ];
    return ExpandablePageView.builder(
      itemCount: detailScreen.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          children: [
            Padding(
              padding: Utils.symmetric(h: 16.0),
              child: Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                          color: borderColor,
                        ))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    tabTitle.length,
                        (index) {
                      final active = _currentIndex == index;
                      return GestureDetector(
                        onTap: () => setState(() => _currentIndex = index),
                        child: AnimatedContainer(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(
                              color: primaryColor
                            ),
                            color: active ? primaryColor : Colors.transparent,
                          ),
                          duration: const Duration(seconds: 0),
                          padding: Utils.symmetric(v: 8.0, h: 20.0),
                          margin: Utils.only(
                              left: index == 0 ? 0.0 : 16.0,
                              bottom: 0.0,
                              top: 0.0),
                          child: CustomTextStyle(
                            text: tabTitle[index],
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            color: active ? whiteColor : blackColor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Utils.verticalSpace(16.0),
            Padding(
              padding: Utils.symmetric(h: 0.0, v: 10.0).copyWith(top: 0.0),
              child: detailScreen[_currentIndex],
            ),
          ],
        );
      },
    );
  }
}