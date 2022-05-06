import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:int_app/src/app/view-model/bluetooth_view_model.dart';
import 'package:int_app/src/app/view/bluetooth/device_card.dart';
import 'package:stacked/stacked.dart';

class DeviceList extends ViewModelBuilderWidget<BluetoothViewModel> {
  final BluetoothViewModel _viewModel;

  const DeviceList(this._viewModel);

  @override
  bool get disposeViewModel => false;

  @override
  Widget builder(
      BuildContext context, BluetoothViewModel viewModel, Widget? child) {
    return StreamBuilder<List<ScanResult>>(
      stream: viewModel.scanResults,
      builder: (context, AsyncSnapshot<List<ScanResult>> snapshot) {
        return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (_, index) {
            return DeviceCard(viewModel, snapshot.data![index].device);
          },
        );
      },
    );
  }

  @override
  BluetoothViewModel viewModelBuilder(BuildContext context) {
    return this._viewModel;
  }
}
