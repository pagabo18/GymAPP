import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:foto_share/content/RutinasDef/bloc/DefRoutine_bloc.dart';
import 'package:foto_share/content/RutinasDef/item_RutinasDef.dart';

class EnRutinasDef extends StatelessWidget {
  const EnRutinasDef({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DefRoutineBloc, DefRoutineState>(
      listener: (context, state) {
        if (state is DefRoutineErrorState) {
          // show snackbar
        }
      },
      builder: (context, state) {
        if (state is DefRoutineLoadingState) {
          return ListView.builder(
            itemCount: 25,
            itemBuilder: (BuildContext context, int index) {
              return YoutubeShimmer();
            },
          );
        } else if (state is DefRoutineEmptyState) {
          return Center(child: Text("No hay datos por mostrar"));
        } else if (state is DefRoutineSuccessState) {
          return ListView.builder(
            itemCount: state.myDisabledData.length,
            itemBuilder: (BuildContext context, int index) {
              return ItemRutinasDef(
                  nonPublicFData: state.myDisabledData[index]);
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
