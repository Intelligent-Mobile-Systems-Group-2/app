import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:int_app/src/app/view-model/bluetooth_view_model.dart';
import 'package:int_app/src/app/view/bluetooth/body.dart';

class BluetoothView extends ViewModelBuilderWidget<BluetoothViewModel> {
  @override
  bool get reactive => true;

  @override
  bool get createNewModelOnInsert => true;

  @override
  bool get disposeViewModel => true;

  @override
  void onViewModelReady(BluetoothViewModel viewModel) async {
    return viewModel.initialize();
  }

  @override
  BluetoothViewModel viewModelBuilder(BuildContext context) {
    return BluetoothViewModel();
  }

  @override
  Widget builder(
      BuildContext context, BluetoothViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bluetooth"),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          viewModel.isRefreshing
              ? IconButton(
                  onPressed: null,
                  icon: Icon(Icons.refresh, color: Colors.black12, size: 30))
              : IconButton(
                  onPressed: () async => await viewModel.refresh(),
                  icon: Icon(Icons.refresh, color: Colors.white, size: 30)),
        ],
      ),
      body: Body(viewModel),
    );
  }
}
