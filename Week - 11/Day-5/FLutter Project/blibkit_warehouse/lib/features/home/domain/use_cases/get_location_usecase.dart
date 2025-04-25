import 'package:blibkit_warehouse/features/home/domain/entity/home_entity.dart';

class GetLocationUsecase {
  Future<HomeEntity> call() async {
    return HomeEntity(
      name: "",
      address: "",
    );
  }
}
