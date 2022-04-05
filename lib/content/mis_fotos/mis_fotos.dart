
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:foto_share/content/mis_fotos/bloc/misFotos_bloc.dart';
import 'package:foto_share/content/mis_fotos/item_mis_fotos.dart';

class MisFotos extends StatelessWidget {
  const MisFotos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<misFotosBloc, misFotosState>(
      listener: (context, state) {
        if (state is misFotosFotosErrorState) {
          // show snackbar
        }
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
          return Center(child: Text("No hay datos por mostrar"));
        } else if (state is misFotosFotosSuccessState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.40,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: state.myEnableData.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
              return ItemEspera(nonPublicFData: state.myEnableData[index]);
            },
            )
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}