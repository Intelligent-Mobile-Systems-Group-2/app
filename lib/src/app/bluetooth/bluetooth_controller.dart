import 'package:int_app/src/app/bluetooth/bluetooth_interactor.dart';
import 'package:int_app/src/app/bluetooth/controllers/robot_controller.dart';
import 'package:int_app/src/app/bluetooth/interactors/robot_interactor.dart';

class BluetoothController<Interactor extends BluetoothInteractor> {
  BluetoothController(Interactor interactor);

  static Controller? createInstance<Controller extends BluetoothController,
      Interactor extends BluetoothInteractor>(Interactor interactor) {
    switch (Controller) {
      case RobotController:
        return RobotController(interactor as RobotInteractor) as Controller;
    }
    return null;
  }
}
