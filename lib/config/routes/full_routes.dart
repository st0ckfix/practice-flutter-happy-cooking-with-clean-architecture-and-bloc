import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'authentication_routes.dart';
import 'vertify_routes.dart';
import 'profile_routes.dart';

GetPage createPage(String name, Widget Function() page, {Transition? transition, Duration? duration, Curve? curve}) {
  return GetPage(
    name: name,
    page: page,
    transition: transition ?? Transition.fade,
    transitionDuration: duration ?? const Duration(milliseconds: 300),
    curve: curve ?? Curves.easeInOut,
  );
}

class FullRoutes {
  static final List<GetPage> routes = [
    ///* All routes from AuthRoutes
    ...AuthRoutes().routes,

    ///* All routes from ProfileRoutes
    ...ProfileRoutes().routes,

    ///* All routes from PhoneVertifyRoutes
    ...VertifyRoutes().routes,
  ];
}