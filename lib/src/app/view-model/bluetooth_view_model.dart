import 'dart:async';
import 'dart:developer';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:ims/src/app/bluetooth/bluetooth_device_manager.dart';
import 'package:ims/src/app/bluetooth/bluetooth_discover_manager.dart';
import 'package:ims/src/app/bluetooth/controllers/robot_controller.dart';
import 'package:ims/src/app/bluetooth/interactors/robot_interactor.dart';
import 'package:stacked/stacked.dart';
import '../bluetooth/bluetooth_device_manager.dart';