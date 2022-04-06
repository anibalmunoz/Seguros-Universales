import 'package:arquitectura/pages/bloc/basic_bloc/basic_bloc.dart';
import 'package:arquitectura/pages/page_two/page_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("App de ejemplo"),
      ),
      body: BlocProvider(
        create: (BuildContext context) => BasicBloc(),
        child: BlocListener<BasicBloc, BasicState>(listener: (context, state) {
          switch (state.runtimeType) {
            case AppStarted:
              break;
            case PageChanged:
            final estado=state as PageChanged;
            Navigator.push(context, MaterialPageRoute(builder: (ext)=> PageTwo(title: estado.title)));
              break;
          }
        },
        child: BlocBuilder<BasicBloc,BasicEvent>(
          builder: (context,state){
            if(state is AppStarted){
              print("Aplicacion iniciada");
            }
          return Column(
            children[
              Text("Pagina uno"),
              ElevatedButton(
                onPressed:(){
                  BlocProvider.of<BasicBloc>(context).add(ButtonPressed());
                },
          
              )
            ]
          );
        },
        ),
        ),
      ),
    );
  }
}
