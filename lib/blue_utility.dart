import 'package:bluetooth_classic/bluetooth_classic.dart';

class BlueUtility {
  BluetoothClassic _blueClassic = BluetoothClassic();
  bool? isDiscovering;

  void startScanning() {
    _blueClassic.startScan();
  }
}
