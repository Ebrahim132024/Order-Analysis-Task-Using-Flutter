import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ordersanalysis/cubit/orders_cubit.dart';
import 'package:ordersanalysis/localzations/lang_cubit.dart';

import 'package:ordersanalysis/screens/orders_screen.dart';

import 'package:ordersanalysis/utils/shared.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await startShared();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en', ''), Locale('ar', '')],
      path: 'assets/lang', // <-- change the path of the translation files
      fallbackLocale:const  Locale('en', ''),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OrderCubit()..loadOrders()),
        BlocProvider(create: (_) => LangCubit())
      ],
      child: BlocBuilder<LangCubit, Locale>(
        builder: (context, languageCode) {
          return MaterialApp(
            title: 'Order Analysis',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.deviceLocale,
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode ==
                    context.locale!.languageCode) {
                  return supportedLocale;
                }
              }
              return context.deviceLocale;
            },
            home: OrdersScreen(),
          );
        },
      ),
    );
  }
}
