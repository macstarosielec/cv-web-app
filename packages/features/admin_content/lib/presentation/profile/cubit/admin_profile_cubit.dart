import 'package:admin_content/presentation/profile/cubit/admin_profile_state.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AdminProfileCubit extends Cubit<AdminProfileState> {
  AdminProfileCubit(this._profileRepository)
      : super(const AdminProfileState.initial());

  final AdminProfileRepository _profileRepository;

  Future<void> loadProfile() async {
    emit(const AdminProfileState.loading());
    try {
      final profile = await _profileRepository.getProfile();
      emit(AdminProfileState.loaded(profile: profile));
    } on Exception catch (e) {
      emit(AdminProfileState.error(message: e.toString()));
    }
  }

  Future<void> saveProfile(Profile profile) async {
    emit(AdminProfileState.saving(profile: profile));
    try {
      await _profileRepository.saveProfile(profile);
      emit(AdminProfileState.saved(profile: profile));
    } on Exception catch (e) {
      emit(AdminProfileState.error(message: e.toString()));
    }
  }
}
