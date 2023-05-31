import 'package:flutter_odev/screens/detail_view.dart';
import 'package:flutter_odev/screens/home_view.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return HomeView();
      },
    ),
    GoRoute(
      path: '/detail/:id/:isIncome',
      builder: (context, state) => DetailView(id: state.params['id']!, isIncome: state.params['isIncome']!),
    ),
  ],
);
