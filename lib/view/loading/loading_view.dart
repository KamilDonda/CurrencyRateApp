import 'dart:async';
import 'dart:developer' as developer;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:currency_rate_app/constants/texts.dart';
import 'package:currency_rate_app/constants/typography.dart';
import 'package:currency_rate_app/model/services/fetch_service.dart';
import 'package:currency_rate_app/utils/fetch_status.dart';
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
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> _initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Could not check connectivity status', error: e);
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result != ConnectivityResult.none) {
      _showSnackBar(CustomTexts.downloadingData, Colors.green);
      _fetchAll();
    } else {
      _showSnackBar(
        CustomTexts.noConnection,
        Colors.red,
        function: () => _displayLastKnownData(),
      );
    }
  }

  void _showSnackBar(
    String text,
    Color bgColor, {
    bool showCloseIcon = true,
    Function()? function,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            content: Text(text, style: CustomTypography.snackBarStyle),
            backgroundColor: bgColor,
            showCloseIcon: showCloseIcon,
            closeIconColor: Colors.white,
            duration: Duration(
              seconds: showCloseIcon ? 6 : 3,
            ),
          ),
        )
        .closed
        .then(
          (value) => {
            if (function != null) function(),
          },
        );
  }

  void _navigateToHome() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const HomeView(),
      ),
    );
  }

  void _fetchAll() {
    FetchService.fetchCurrencies().then(
      (value) => {
        if (value is FetchStatusFailure)
          {
            _showSnackBar(
              CustomTexts.unexpectedError,
              Colors.red,
              showCloseIcon: false,
              function: () => _displayLastKnownData(),
            ),
          },
      },
    );
    FetchService.fetchLast30Values().then(
      (value) => {
        if (value is FetchStatusFailure)
          {
            _showSnackBar(
              CustomTexts.unexpectedError,
              Colors.red,
              showCloseIcon: false,
            ),
          }
        else
          {
            _navigateToHome(),
          },
      },
    );
  }

  void _displayLastKnownData() {
    _navigateToHome();
    _showSnackBar(CustomTexts.lastKnownData, Colors.orange);
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
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
