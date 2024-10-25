part of 'plan_cubit.dart';

class PlanState extends Equatable {
  final List<PropertyPlanDto> propertyPlan;

  const PlanState(this.propertyPlan);

  @override
  List<Object> get props => [propertyPlan];
}
