import 'package:flutter/material.dart';
import '../../../../data/model/agency/agency_list_model.dart';
import '/presentation/widget/custom_test_style.dart';
import 'agent_card.dart';


class AgencyAgentList extends StatelessWidget {
  const AgencyAgentList({super.key, required this.agentList, });

  final List<AgencyListModel> agentList;

  @override
  Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTextStyle(text: 'My Agent', fontSize: 18,fontWeight: FontWeight.w600,),
            SizedBox(
              height: 850,
              child: GridView.builder(
                  itemCount: agentList.length,
                  //  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0)
                      .copyWith(bottom: 40.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 12.0,
                      crossAxisSpacing: 12.0,
                      crossAxisCount: 2,
                      mainAxisExtent: 233.0),
                  itemBuilder: (context, index) =>
                       AgentCartView(agent: agentList[index],)),
            ),
          ],),
      );
  }
}
