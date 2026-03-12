import 'package:cv_content/presentation/cubit/profile/profile_state.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._profileRepository)
      : super(const ProfileState.initial());

  final ProfileRepository _profileRepository;

  Future<void> loadProfile() async {
    emit(const ProfileState.loading());
    try {
      final profile = await _profileRepository.getProfile();
      emit(ProfileState.loaded(profile: profile));
    } on Exception catch (e) {
      emit(ProfileState.error(message: e.toString()));
    }
  }
}
