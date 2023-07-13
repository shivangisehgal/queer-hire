import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/pages/job_app.dart';

import '/pages/home.dart';
import '/pages/jobs.dart';
import '/pages/training.dart';
import '/pages/scholarships.dart';
import '/pages/counselling.dart';
import '/pages/login.dart';
import '/pages/register.dart';
import '/pages/profile_page.dart';

class MyAppRouter{
  static GoRouter router = GoRouter(
    //refreshListenable: authService,
    routes: [
      GoRoute(
          name: 'home',
          path: '/',
          pageBuilder: (context, state){
            return MaterialPage(child: Home());
          }
      ),

      GoRoute(
          name: 'training',
          path: '/training',
          pageBuilder: (context, state){
            return MaterialPage(child: TrainingPage());
          }
      ),

      GoRoute(
          name: 'jobs',
          path: '/jobs',
          pageBuilder: (context, state){
            return MaterialPage(child: JobsPage());
          }
      ),

      GoRoute(
          name: 'scholarships',
          path: '/scholarships',
          pageBuilder: (context, state){
            return MaterialPage(child: ScholarshipsPage());
          }
      ),

      GoRoute(
          name: 'guidance',
          path: '/guidance',
          pageBuilder: (context, state){
            return MaterialPage(child: GuidancePage());
          }
      ),

      GoRoute(
          name: 'login',
          path: '/login',
          pageBuilder: (context, state){
            return MaterialPage(child: LoginPage());
          }
      ),

      GoRoute(
          name: 'register',
          path: '/register',
          pageBuilder: (context, state){
            return MaterialPage(child: RegisterPage());
          }
      ),

      GoRoute(
          name: 'profile',
          path: '/profile',
          pageBuilder: (context, state){
            return MaterialPage(child: ProfilePage());
          }
      ),

    ],
  );
}
