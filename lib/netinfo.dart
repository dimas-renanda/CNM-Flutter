// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:mac_address/mac_address.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dart_ipify/dart_ipify.dart';

class netInfo extends StatefulWidget {
  const netInfo({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _netInfoState createState() => _netInfoState();
}

class _netInfoState extends State<netInfo> {
  String _connectionStatus = 'Loading Information...';
  final NetworkInfo _networkInfo = NetworkInfo();

  @override
  void initState() {
    super.initState();
    _initNetworkInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network Info '),
      ),
      body: Center(child: Text('Connection Status: $_connectionStatus')),
    );
  }

  Future<void> _initNetworkInfo() async {
    String? wifiName,
        wifiBSSID,
        wifiIPv4,
        wifiIPv6,
        wifiGatewayIP,
        wifiBroadcast,
        wifiSubmask,
        macaddnya,
        pipnya;

    try {
      if (!kIsWeb && Platform.isIOS) {
        var status = await _networkInfo.getLocationServiceAuthorization();
        if (status == LocationAuthorizationStatus.notDetermined) {
          status = await _networkInfo.requestLocationServiceAuthorization();
        }
        if (status == LocationAuthorizationStatus.authorizedAlways ||
            status == LocationAuthorizationStatus.authorizedWhenInUse) {
          wifiName = await _networkInfo.getWifiName();
        } else {
          wifiName = await _networkInfo.getWifiName();
        }
      } else {
        wifiName = await _networkInfo.getWifiName();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi Name', error: e);
      wifiName = 'Failed to get Wifi Name';
    }

    try {
      if (!kIsWeb && Platform.isIOS) {
        var status = await _networkInfo.getLocationServiceAuthorization();
        if (status == LocationAuthorizationStatus.notDetermined) {
          status = await _networkInfo.requestLocationServiceAuthorization();
        }
        if (status == LocationAuthorizationStatus.authorizedAlways ||
            status == LocationAuthorizationStatus.authorizedWhenInUse) {
          wifiBSSID = await _networkInfo.getWifiBSSID();
        } else {
          wifiBSSID = await _networkInfo.getWifiBSSID();
        }
      } else {
        wifiBSSID = await _networkInfo.getWifiBSSID();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi BSSID', error: e);
      wifiBSSID = 'Failed to get Wifi BSSID';
    }

    try {
      wifiIPv4 = await _networkInfo.getWifiIP();
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi IPv4', error: e);
      wifiIPv4 = 'Failed to get Wifi IPv4';
    }

    try {
      wifiIPv6 = await _networkInfo.getWifiIPv6();
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi IPv6', error: e);
      wifiIPv6 = 'Failed to get Wifi IPv6';
    }

    try {
      wifiSubmask = await _networkInfo.getWifiSubmask();
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi submask address', error: e);
      wifiSubmask = 'Failed to get Wifi submask address';
    }

    try {
      wifiBroadcast = await _networkInfo.getWifiBroadcast();
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi broadcast', error: e);
      wifiBroadcast = 'Failed to get Wifi broadcast';
    }

    try {
      wifiGatewayIP = await _networkInfo.getWifiGatewayIP();
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi gateway address', error: e);
      wifiGatewayIP = 'Failed to get Wifi gateway address';
    }

    try {
      wifiSubmask = await _networkInfo.getWifiSubmask();
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi submask', error: e);
      wifiSubmask = 'Failed to get Wifi submask';
    }

    try {
      macaddnya = await GetMac.macAddress;
    } on PlatformException {
      macaddnya = 'Failed to get Device MAC Address.';
    }

    try {
      pipnya = await Ipify.ipv4();
    } on PlatformException {
      pipnya = 'Failed to get Device Public IP.';
    }

    setState(() {
      _connectionStatus = 'Wifi Name: $wifiName\n'
          'Wifi BSSID : $wifiBSSID\n'
          'Wifi IPv4: $wifiIPv4\n'
          // 'Wifi IPv6: $wifiIPv6\n'
          'Wifi Broadcast: $wifiBroadcast\n'
          'Wifi Gateway: $wifiGatewayIP\n'
          'MacAdress: $macaddnya\n'
          'Publik IPnya: $pipnya\n'
          'Wifi Submask: $wifiSubmask\n';
    });
  }
}
