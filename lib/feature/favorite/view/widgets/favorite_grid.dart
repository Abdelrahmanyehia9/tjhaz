import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/routes/index.dart';
import 'package:tjhaz/feature/entertainment/view/widget/entertainment_grid.dart';
import 'package:tjhaz/feature/entertainment/view/widget/entertainment_loading.dart';
import 'package:tjhaz/feature/favorite/logic/get_all_favorite_cubit.dart';
import 'package:tjhaz/feature/favorite/logic/get_all_favorite_states.dart';

import '../../../../core/widgets/errors_widgets.dart';

class FavoriteGrid extends StatelessWidget {
  const FavoriteGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllFavoriteCubit, GetAllFavoriteStates>(
      builder: (context, state) {
        if (state is GetAllFavoriteStatesSuccess) {
          List<EntertainmentDetailsModel> favoriteList = context.read<GetAllFavoriteCubit>().allFavorites ;
          return favoriteList.isNotEmpty? EntertainmentGrid(
            items: favoriteList) : EmptyList(title: "Favorites");
        }
        else if (state is GetAllFavoriteStatesFailure) {
          return AppErrorWidget(error: state.error);
        }
        else {
          return GridLoading();
        }
      },
    );
  }
}