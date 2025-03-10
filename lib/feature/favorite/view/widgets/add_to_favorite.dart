import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tjhaz/feature/favorite/logic/add_or_remove_to_favorite_states.dart';
import '../../../../core/widgets/box_icon_button.dart';
import '../../logic/add_or_remove_to_favorite_cubit.dart';
import '../../logic/get_all_favorite_cubit.dart';

class AddToFavorite extends StatefulWidget {
  final String id;
  const AddToFavorite({super.key, required this.id});

  @override
  State<AddToFavorite> createState() => _AddToFavoriteState();
}

class _AddToFavoriteState extends State<AddToFavorite> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = context.read<GetAllFavoriteCubit>().allFavorites.any((element) => element.id == widget.id);
  }



  @override
  Widget build(BuildContext context) {
    return BlocListener<AddOrRemoveToFavoriteCubit, AddOrRemoveToFavoriteStates>(
      listener: (context, state) {
        if (state is AddOrRemoveToFavoriteSuccess) {
          // Refresh the favorite list after a successful add/remove operation
          context.read<GetAllFavoriteCubit>().get();
        } else if (state is AddOrRemoveToFavoriteFailure) {
          // Optionally, handle failure state, e.g., show an error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update favorite status')),
          );
        }
      },
      child: FavouriteIcon(
        isFavorite: isFavorite,
        onTap: () async {
          // Show loader overlay while adding/removing to favorite
          context.loaderOverlay.show();

          // Perform the add/remove operation
          await context.read<AddOrRemoveToFavoriteCubit>().addToFavorite(entertainmentID: widget.id);

          // Hide the loader overlay once the operation is complete
          if (context.mounted) {
            context.loaderOverlay.hide();
          }

          // Update the favorite status locally
          setState(() {
            isFavorite = !isFavorite;
          });
        },
      ),
    );
  }
}
