import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_monika/blocs/appbar_part/appbar_bloc.dart';
import 'package:portfolio_monika/blocs/appbar_part/appbar_events.dart';
import 'package:portfolio_monika/blocs/project_part/project_events.dart';

import 'blocs/project_part/project_bloc.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCLNhlZQhg9vH3v33jf1mVe1i337yIt_yM",
          appId: "1:664050407788:web:e6afb88a97bffc1f3a7b49",
          messagingSenderId: "664050407788",
          storageBucket: "gs://portfolio-794b9.appspot.com",
          projectId: "portfolio-794b9"));
  FirebaseStorage.instanceFor(bucket: "gs://portfolio-794b9.appspot.com");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Sizes.height = MediaQuery.of(context).size.height;
    Sizes.width = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProjectBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MONIKA',
        theme: ThemeData(
          appBarTheme: AppBarTheme(titleTextStyle: TextStyle(color: Colors.white.withOpacity(0.8))),
          textTheme: TextTheme(
            bodyMedium: TextStyle(
              color: Colors.white.withOpacity(0.8),
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.6),
                  offset: const Offset(1, 1),
                  blurRadius: 10,
                ),
              ],
            ),
          ),
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
              TargetPlatform.windows: OpenUpwardsPageTransitionsBuilder(),
            },
          ),
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.black,
        ),
        initialRoute: '/home',
        routes: {
          '/home': (context) => MultiBlocProvider(providers: <BlocProvider>[
                BlocProvider<ProjectBloc>(create: (ctx) => ProjectBloc()..add(FetchProjects())),
                BlocProvider<AppBarBloc>(
                    create: (ctx) => AppBarBloc()..add(ChangeSeletcion(selectedTile: "Home")))
              ], child: const HomeScreen()),
        },
      ),
    );
  }
}

class Sizes {
  static double width = 0.0;
  static double height = 0.0;
}
