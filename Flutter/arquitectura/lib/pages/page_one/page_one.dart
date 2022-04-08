import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:arquitectura/pages/page_two/page_two.dart';
import 'package:arquitectura/bloc/basic_bloc/basic_bloc.dart';

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('App de ejemplo'),
      ),
      body: BlocProvider(
        create: (BuildContext context) => BasicBloc(),
        child: BlocListener<BasicBloc, BasicState>(
          listener: (context, state) {
            switch (state.runtimeType) {
              case AppStarted:
                break;
              case PageChanged:
                final estado = state as PageChanged;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (cxt) => PageTwo(title: estado.title)));
                break;
            }
          },
          child: BlocBuilder<BasicBloc, BasicState>(
            builder: (context, state) {
              if (state is AppStarted) {
                print('aplicacion iniciada');
              }

              return Column(
                children: [
                  Text('Pagina uno'),
                  ElevatedButton(
                    onPressed: () {
                      //BlocProvider.of<BasicBloc>(context)
                      //  .add(LoginButtonPressed());
                    },
                    child: Text('Pagina dos'),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
