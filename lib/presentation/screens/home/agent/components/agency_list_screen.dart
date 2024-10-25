import 'package:real_estate/data/model/agency/agency_list_model.dart';
import 'package:real_estate/logic/cubit/agency/agency_cubit.dart';
import 'package:real_estate/logic/cubit/agency/agency_state_model.dart';
import 'package:real_estate/presentation/screens/home/agent/components/single_agency_card.dart';

import '../../../../../state_inject_package_names.dart';
import '../../../../widget/error_text.dart';
import '../../../../widget/loading_widget.dart';
import '../../component/agent_search.dart';
import '../../component/single_broker_agent_card_view.dart';

class AgencyListScreen extends StatelessWidget {
  const AgencyListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final agencyCubit = context.read<AgencyCubit>();
    agencyCubit.getAllAgency();
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 595,
            child: BlocBuilder<AgencyCubit, AgencyStateModel>(
                builder: (context, state) {
              final agency = state.agencyState;
              if (agency is AgencyLoading) {
                return const LoadingWidget();
              } else if (agency is AgencyError) {
                if (agency.statusCode == 503 || agencyCubit.agency != null) {
                  return LoadedAgency(agency: agencyCubit.agency!);
                } else {
                  return ErrorText(text: agency.message);
                }
              } else if (agency is AgencyLoaded) {
                return LoadedAgency(agency: agencyCubit.agency!);
              }
              if (agencyCubit.agency != null) {
                return LoadedAgency(agency: agencyCubit.agency!);
              } else {
                return const ErrorText(text: 'Something want wrong');
              }
            }),
          ),
        ],
      ),
    );
  }
}

class LoadedAgency extends StatefulWidget {
  const LoadedAgency({
    super.key,
    required this.agency,
  });

  final List<AgencyListModel> agency;

  @override
  State<LoadedAgency> createState() => _LoadedAgencyState();
}

class _LoadedAgencyState extends State<LoadedAgency> {
  String _searchQuery = ''; // To track the current search query
  late List<AgencyListModel> _filteredAgents; // To store filtered agents

  @override
  void initState() {
    super.initState();
    _filteredAgents = widget.agency; // Initially, all agents are shown
  }

  // Method to filter the agents based on the search query
  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      _filteredAgents = widget.agency
          .where((agent) =>
              agent.profile!.companyName.toLowerCase().contains(_searchQuery))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          AgentSearch(onSearchChanged: _onSearchChanged),
          Expanded(
            child: _filteredAgents.isEmpty
                ? const Center(
                    child: Text('No agency found'),
                  )
                : GridView.builder(
                    itemCount: _filteredAgents.length,
                    //  physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0)
                        .copyWith(bottom: 6.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 12.0,
                        crossAxisSpacing: 12.0,
                        crossAxisCount: 2,
                        mainAxisExtent: 233.0),
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        SingleAgencyCard(agency: _filteredAgents[index])),
          ),
        ],
      ),
    );
  }
}
