import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widget/plan_model.dart';
import 'planes_state.dart';

class PlanesCubit extends Cubit<PlanesState> {
  final FirestoreService _firestoreService;
  StreamSubscription<List<Plan>>? _plansSubscription;

  PlanesCubit({FirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? FirestoreService(),
        super(PlanesInitial());

  void fetchPlans() {
    emit(PlanesLoading());

    _plansSubscription?.cancel();
    _plansSubscription = _firestoreService.getPlans().listen(
      (plans) {
        emit(PlanesLoaded(plans: plans));
      },
      onError: (error) {
        emit(PlanesError(message: error.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _plansSubscription?.cancel();
    return super.close();
  }
}
