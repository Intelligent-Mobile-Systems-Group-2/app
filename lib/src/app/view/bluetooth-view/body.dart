import 'package:flutter/material.dart';
import 'package:int_app/src/app/view-model/bluetooth_view_model.dart';
import 'package:int_app/src/app/view/bluetooth-view/device_list.dart';
import 'package:stacked/stacked.dart';

class Body extends ViewModelBuilderWidget<BluetoothViewModel> {
  final BluetoothViewModel _viewModel;

  const Body(this._viewModel);

  @override
  bool get disposeViewModel => false;

  @override
  Widget builder(
      BuildContext context, BluetoothViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Devices"),
            Card(
              child: viewModel.isRefreshing
                  ? LinearProgressIndicator(
                      backgroundColor: Colors.black12,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.blueAccent,
                      ),
                    )
                  : LinearProgressIndicator(
                      backgroundColor: Colors.black12,
                      value: 0,
                    ),
            ),
            SizedBox(height: 10),
            Flexible(
              child: DeviceList(viewModel),
            )
          ],
        ),
      ),
    );
  }

  @override
  BluetoothViewModel viewModelBuilder(BuildContext context) {
    return _viewModel;
  }
}
