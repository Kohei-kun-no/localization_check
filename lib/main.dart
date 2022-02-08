import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
    child: MyApp(),
    supportedLocales: [
      Locale('ja', 'JP'),
      Locale('en', 'US'),
      Locale('zh', 'TW'),
      Locale('zh', 'CN'),
      Locale('ko', 'KO'),
    ],
    path: 'assets/langs',
    fallbackLocale: Locale('ja', 'JP'),
    saveLocale: false,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _ezContext = EasyLocalization.of(context)!;
    return MaterialApp(
      title: 'Change Lang App',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        _ezContext.delegate,
      ],
      supportedLocales: _ezContext.supportedLocales,
      locale: _ezContext.locale,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('title'), style: TextStyle(fontSize: 20))),
      body: _body(context),
    );
  }
  Widget _body(BuildContext context) {
    final supportLocales = context.supportedLocales;
    final currentLocale = context.locale;
    return Center(
      child: Column(
        children: [
          Row(
              mainAxisSize: MainAxisSize.min,
              children: supportLocales
                  .map((locale) => _btn(context, locale, currentLocale))
                  .toList()),
          const SizedBox(height: 20),
          Text(tr('lang_name'), style: TextStyle(fontSize: 16)),
          const SizedBox(height: 4),
          //context.localeで現在のlocaleが取得できる
          Text(context.locale.toString(), style: TextStyle(fontSize: 16))
        ],
      ),
    );
  }
  Widget _btn(BuildContext context, Locale locale, Locale currentLocale) {
    final isActive = locale.languageCode == currentLocale.languageCode;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: isActive
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).disabledColor),
          onPressed: () => context.setLocale(locale),
          child: Text(locale.languageCode)),
    );
  }
}