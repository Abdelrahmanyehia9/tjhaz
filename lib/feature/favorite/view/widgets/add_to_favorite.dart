import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/feature/favorite/logic/favorite_cubit.dart';
import 'package:tjhaz/feature/favorite/logic/favorite_states.dart';
import '../../../../core/widgets/box_icon_button.dart';

class AddToFavorite extends StatelessWidget {
  final String id;
  const AddToFavorite({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteStates>(
      buildWhen: (previous, current) {
        if (current is AddOrRemoveToFavoriteLoading) {
          return current.loadingID == id;
        }
        return current is AddOrRemoveToFavoriteSuccess ||
            current is GetFavoriteStatesSuccess;
      },
      builder: (context, state) {
        final favoriteCubit = context.read<FavoriteCubit>();
        final isFavorite = favoriteCubit.favoritesIds.contains(id);
        final isLoading = state is AddOrRemoveToFavoriteLoading && state.loadingID == id;

        return FavouriteIcon(
          isFavorite: isFavorite,
          isLoading: isLoading,
          onTap: isLoading ? null : () async {
            if (!isFavorite) {
              await favoriteCubit.addToFavorites(itemID: id);
            } else {
              await favoriteCubit.removeFavorites(itemID: id);
            }
          },
        );
      },
    );
  }
}