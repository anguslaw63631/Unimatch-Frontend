import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unimatch/config.dart';
import 'package:unimatch/fn.dart';

import 'const.dart';

class BleController extends GetxController{
  Future scanDevices() async{
    var blePermission = await Permission.bluetoothScan.status;
    var locationPermission = await Permission.location.status;
    if(blePermission.isDenied || locationPermission.isDenied){
      if(await Permission.location.request().isGranted){
        if(await Permission.bluetoothScan.request().isGranted){
          FlutterBluePlus.startScan(
            timeout: const Duration(seconds: 15),
            // removeIfGone: const Duration(seconds: 5),
          );
        }
      }
    } else {
      FlutterBluePlus.startScan(
        timeout: const Duration(seconds: 15),
        // removeIfGone: const Duration(seconds: 5),
      );
    }
  }

  Future rescan() async {
    if (FlutterBluePlus.isScanningNow) {
      await FlutterBluePlus.stopScan();
      FlutterBluePlus.startScan(
        timeout: const Duration(seconds: 15),
      );
    } else {
      FlutterBluePlus.startScan(
        timeout: const Duration(seconds: 15),
      );
    }
  }

  Future stopScan() async {
    if (FlutterBluePlus.isScanningNow) {
      await FlutterBluePlus.stopScan();
    }
  }

  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;
}