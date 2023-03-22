import 'dart:async';
import 'dart:developer' as developer;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:currency_rate_app/constants/texts.dart';
import 'package:currency_rate_app/constants/typography.dart';
import 'package:currency_rate_app/model/services/fetch_service.dart';
import 'package:currency_rate_app/view/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  // URL: pub.dev/packages/connectivity_plus/example
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      if (result != ConnectivityResult.none) {
        _showSnackBar(CustomTexts.downloadingData, Colors.green);
        _fetchAll();
      } else {
        _showSnackBar(CustomTexts.noConnection, Colors.red);
      }
      _connectionStatus = result;
    });
  }

  void _showSnackBar(String text, bgColor) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text, style: CustomTypography.snackBarStyle),
        backgroundColor: bgColor,
        showCloseIcon: true,
        closeIconColor: Colors.white,
        duration: const Duration(seconds: 10),
      ),
    );
  }

  void _fetchAll() {
    FetchService.fetchCurrencies();
    FetchService.fetchLast30Values().then(
      (value) => {
        ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const HomeView(),
          ),
        )
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            CustomTexts.chooseCurrency,
            style: CustomTypography.appbarStyle,
          ),
        ),
        body: const SafeArea(
          child: Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
