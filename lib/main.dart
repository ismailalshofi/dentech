import 'package:dentech/core/app_theme.dart';
import 'package:dentech/core/configure_di.dart';
import 'package:dentech/core/app_store/app_store.dart';
import 'package:dentech/core/local/app_localization.dart';
import 'package:dentech/core/local/language_data_model.dart';
import 'package:dentech/core/local/languages.dart';
import 'package:dentech/core/local/languages/language_en.dart';
import 'package:dentech/core/logic/global_bloc.dart';
import 'package:dentech/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

BaseLanguage language = LanguageEn();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  localeLanguageList = languagesModels;
  await getIt<AppStore>().initial();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GlobalBloc(),
      child: BlocBuilder<GlobalBloc, GlobalState>(
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme(),
              darkTheme: AppTheme.darkTheme(),
              themeMode: getIt<AppStore>().isDarkMode
                  ? ThemeMode.dark
                  : ThemeMode.light,
              localizationsDelegates: const [
                AppLocalizations(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: LanguageDataModel.languageLocales(),
              localeResolutionCallback: (locale, supportedLocales) => locale,
              locale: Locale(getIt<AppStore>().selectedLanguageCode),
              home: LoginScreen());
        },
      ),
    );
  }
}
