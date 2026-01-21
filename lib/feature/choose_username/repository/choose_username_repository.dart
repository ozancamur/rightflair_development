import '../../../core/base/model/response.dart';

abstract class ChooseUsernameRepository {
  Future<bool> checkUsername({required String username});
  Future<ResponseModel?> updatedUser({required String username});
}
