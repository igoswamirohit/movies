import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../injection_container.dart';
import 'core/router/router.dart';
import 'presentation/blocs/bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MoviesBloc>(),
      child: MaterialApp(
          restorationScopeId: 'app',
          theme: ThemeData(),
          onGenerateRoute: CustomRouter.generateRoute),
    );
  }
}
