import 'dart:async';
import 'dart:developer';

import 'package:cv_app/app/app.dart';
import 'package:cv_app/di/injection.dart';
import 'package:cv_app/firebase_options_dev.dart' as dev;
import 'package:cv_app/firebase_options_prod.dart' as prod;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> bootstrap({required String environment}) async => runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();

        await configureDependencies(environment: environment);
        await Firebase.initializeApp(
          options: environment == 'dev'
            ? dev.DefaultFirebaseOptions.currentPlatform
            : prod.DefaultFirebaseOptions.currentPlatform,
        );

        log('Firebase initialized for environment: $environment');
        log('Firebase app name: ${Firebase.app().name}');
        log('Firebase project ID: ${Firebase.app().options.projectId}');

        runApp(const CvApp());
      },
      (error, stackTrace) {
        log(error.toString());
      },
    );
