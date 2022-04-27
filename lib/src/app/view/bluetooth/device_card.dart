import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:int_app/src/app/view-model/bluetooth_view_model.dart';
import 'package:stacked/stacked.dart';

import '../../view-model/bluetooth_view_model.dart';

class DeviceCard extends ViewModelBuilderWidget<BluetoothViewModel> {
  final BluetoothViewModel _viewModel;
  final BluetoothDevice _device;

  const DeviceCard(this._viewModel, this._device);

  @override
  bool get disposeViewModel => false;

  @override
  Widget builder(
      BuildContext context, BluetoothViewModel viewModel, Widget? child) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: Container(
          height: double.infinity,
          child:
              Icon(Icons.bluetooth_searching, color: Colors.black54, size: 30),
        ),
        title: Text(this._device.name.isNotEmpty ? this._device.name : "-"),
        subtitle: Text(this._device.id.id),
        trailing: ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: 100, height: 40),
            child: (viewModel.selectedDevice == null)
                ? button(_viewModel, _device)
                : (viewModel.selectedDevice! == _device)
                    ? selectedButton()
                    : disabledButton()),
      ),
    );
  }

  @override
  BluetoothViewModel viewModelBuilder(BuildContext context) {
    return _viewModel;
  }

  ElevatedButton button(BluetoothViewModel viewModel, BluetoothDevice device) {
    return ElevatedButton(
      child: Text("Connect"),
      style: ButtonStyle(),
      onPressed: () async => viewModel.connect(_device),
    );
  }

  ElevatedButton disabledButton() {
    return ElevatedButton(
      child: Text("Connect"),
      onPressed: null,
    );
  }

  ElevatedButton selectedButton() {
    return ElevatedButton(
      child: SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(),
      ),
      style: ButtonStyle(),
      onPressed: null,
    );
  }
}
