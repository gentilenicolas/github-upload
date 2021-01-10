import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formvalidation/src/providers/localidades_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:formvalidation/src/routes/routes.dart';
import 'package:formvalidation/src/share_prefs/preferencias_usuario.dart';
import 'package:formvalidation/src/utils/funciones.dart';
import 'package:provider/provider.dart';
import 'src/providers/login_provider.dart';

void main() {
  cargoDataInicial();
  //Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  return runApp(MyApp());
  //
} // main anterior ,

class MyApp extends StatelessWidget {
  final prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {});

    //agregar tiempo de espera para que se cargue toda la data! ! ! ! ! ! ! ! ! !! !!!!!!!

    return MultiProvider(
      //esto es lo de Providers. vos podes poner return ChangeNotifierProvider y eso te deja manejar solo un provider
      //MultiProvider es para muchoses

      //create: (_) => new LocalidadesProvider(),
      providers: [
        ChangeNotifierProvider<LocalidadesProvider>(
            create: (_) => new LocalidadesProvider()),
        //aca van los demas providers, podes hacerte un provider de logueado
        //Provider<Clase> (create: (_) => new Clase())    como ejemplo, clase puede ser login, loguead, lo que venga fijate
      ],
      child: LoginProvider(
        //aca tenias la palabra Provider en vez de LoginProvider, compilaba porque Provider a secas es el patron y existe
        child: MaterialApp(
          actions: {},
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            // ... app-specific localization delegate[s] here
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', 'US'), // English, no country code
            const Locale('es', 'ES'),
            const Locale.fromSubtags(
                languageCode: 'zh'), // Chinese *See Advanced Locales below*
          ],
          // title: 'Material App',
          //inicio de la aplicacion en la pagina de home
          initialRoute:
              'home', //prefs.ultimaPagina,       // si no hay ultima pagina me vuelve al home , video 191
          routes: getApplicatiosnRoutes(),
          theme: ThemeData(
            primaryColor: Colors.blueAccent[400],
          ),
        ),
      ),
    );
  }
}
