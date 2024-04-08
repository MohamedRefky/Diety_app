import 'package:diety/features/Asks/cubit/stateManagemen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AgeStateCubit extends Cubit<AgeState> {
  AgeStateCubit({required this.age}) : super(AgeInitial());
    double age;
}