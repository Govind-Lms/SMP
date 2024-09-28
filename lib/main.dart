import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smp/firebase_options.dart';
import 'package:smp/src/core/state_management/amount/amount_bloc.dart';
import 'package:smp/src/core/state_management/client/client_bloc.dart';
import 'package:smp/src/core/state_management/item/item_bloc.dart';
import 'package:smp/src/core/state_management/voucher/voucher_bloc.dart';
import 'package:smp/src/presentations/views/dashboard/dashboard_screen.dart';

void main() async{
  await setup();
  runApp(const MyApp());
}

setup() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  // if(Platform.isIOS){
  //   await Firebase.initializeApp(
  //     name: "SMP",
  //   options: DefaultFirebaseOptions.currentPlatform);
  // }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);

  if(kIsWeb){
    ///Do NOTHING
  }
  else{
    await checkPermission();
  }
}
checkPermission () async{
  if(Platform.isAndroid){
    final status = await Permission.manageExternalStorage.request();
    if(status.isGranted){
    }
    else{
      checkPermission();
    }
  }
  else if(Platform.isIOS){
    var status = await Permission.photos.request();
    if (status.isGranted) {
    } else if (status.isDenied) {
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }

  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if(constraints.maxWidth < 600){
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ClientBloc()),
              BlocProvider(create: (context) => VoucherBloc()),
              BlocProvider(create: (context) => ItemBloc()),
              BlocProvider(create: (context) => AmountBloc()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'SMP',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
                useMaterial3: true,
              ),
              home: const DashboardScreen(),
            ),
          );
        }else{
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'SMP',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
                useMaterial3: true,
              ),
              home: const Scaffold(body: Center(child: Text("Please Resize the window"),),),
            );
        }
      },
      
    );
  }
}
