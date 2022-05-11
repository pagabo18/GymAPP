import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foto_share/content/mis_fotos/bloc/misFotos_bloc.dart';
import 'package:foto_share/content/mis_fotos/item_mis_fotos.dart';

class MisFotos extends StatelessWidget {
  const MisFotos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<misFotosBloc, misFotosState>(
      listener: (context, state) {
        if (state is misFotosFotosErrorState) {
          // show snackbar with error

        } else if (state is misFotosFotosLoadingState) {
          print("Hello! misFotosFotosLoadingState has been loaded! loading");
        }

        print(state);
      },
      builder: (context, state) {
        if (state is misFotosFotosLoadingState) {
          return ListView.builder(
            itemCount: 25,
            itemBuilder: (BuildContext context, int index) {
              return YoutubeShimmer();
            },
          );
        } else if (state is misFotosFotosEmptyState) {
          return Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icon/workout.svg',
                height: 200,
                semanticsLabel: 'Exercise vector',
              ),
              SizedBox(height: 20),
              Container(
                constraints: BoxConstraints(maxWidth: 300),
                child:
                    Text("Hmmmm... parece que aún no haz agregado rutinas...",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center),
              ),
            ],
          ));
        } else if (state is misFotosFotosSuccessState) {
          return Container(
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: state.myEnableData.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return ItemEspera(nonPublicFData: state.myEnableData[index]);
                },
              ));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
