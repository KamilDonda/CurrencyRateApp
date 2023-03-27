import 'dart:async';
import 'dart:developer' as developer;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:currency_rate_app/constants/texts.dart';
import 'package:currency_rate_app/constants/typography.dart';
import 'package:currency_rate_app/model/entities/currency.dart';
import 'package:currency_rate_app/model/services/fetch_service.dart';
import 'package:currency_rate_app/utils/fetch_status.dart';
import 'package:currency_rate_app/view/details/cubit/currency_cubit.dart';
import 'package:currency_rate_app/view/details/cubit/currency_detail_cubit.dart';
import 'package:currency_rate_app/view/details/details_view.dart';
import 'package:currency_rate_app/view/details/widgets/currency_item.dart';
import 'package:currency_rate_app/view/widgets/data_not_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            content: Text(text, style: CustomTypography.snackBarStyle),
            backgroundColor: bgColor,
            showCloseIcon: showCloseIcon,
            closeIconColor: Colors.white,
            duration: Duration(
              seconds: showCloseIcon ? 5 : 3,
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

  void _fetchAll() {
    _showSnackBar(CustomTexts.downloadingData, Colors.green);
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
            context.read<CurrencyCubit>().setCurrencies(),
            ScaffoldMessenger.of(context).clearSnackBars(),
          },
      },
    );
  }

  void _displayLastKnownData() {
    var list = context.read<CurrencyCubit>().state;
    if (list != null && list.isNotEmpty) {
      _showSnackBar(CustomTexts.lastKnownData, Colors.orange);
    }
  }

  Future<bool> _showExitPopup(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(CustomTexts.exit),
            content: const Text(CustomTexts.exitContent),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(CustomTexts.no),
              ),
              ElevatedButton(
                onPressed: () => FlutterExitApp.exitApp(),
                child: const Text(CustomTexts.yes),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _showExitPopup(context),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            CustomTexts.chooseCurrency,
            style: CustomTypography.appbarStyle,
          ),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: BlocBuilder<CurrencyCubit, List<Currency>?>(
            builder: (_, currencies) {
              if (currencies == null || currencies.isEmpty) {
                return RefreshIndicator(
                  onRefresh: () async {
                    _updateConnectionStatus(
                        await _connectivity.checkConnectivity());
                    // _fetchAll();
                  },
                  child: const SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: DataNotFound(),
                  ),
                );
              }
              return NotificationListener<OverscrollIndicatorNotification>(
                // disable overscroll glow
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowIndicator();
                  return true;
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(4),
                  itemCount: currencies.length,
                  itemBuilder: (_, index) => GestureDetector(
                    onTap: () {
                      var code = currencies[index].code;
                      context.read<CurrencyDetailCubit>().clear();
                      context
                          .read<CurrencyDetailCubit>()
                          .setCurrencyDetail(code);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailsView(
                            code: code,
                            currency: currencies[index],
                          ),
                        ),
                      );
                    },
                    child: CurrencyItem(currency: currencies[index]),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
