import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/componant/custom_app_bar.dart';
import 'package:yasta/core/componant/save_cancel_buttons.dart';
import 'package:yasta/core/constants/constants.dart';
import 'package:yasta/core/di/dependency_injection.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/core/route/route_strings/route_strings.dart';
import 'package:yasta/core/theme/colors.dart';
import 'package:yasta/core/theme/text_styles.dart';
import 'package:yasta/features/update_workshop_center_profile/data/logic/update_center_cubit.dart';
import 'package:yasta/features/update_workshop_center_profile/presentation/widgets/add_photo_widget.dart';

import '../../../workshop_profile/model/get_workshop_byId_response.dart';

class UpdatePhotoAlbum extends StatefulWidget {
  UpdatePhotoAlbum({super.key});

  @override
  State<UpdatePhotoAlbum> createState() => _UpdatePhotoAlbumState();
}

class _UpdatePhotoAlbumState extends State<UpdatePhotoAlbum> {
  // Fetch the imagesAlbum list from the Cubit
  late List<Images> imagesAlbum;

  @override
  void initState() {
    super.initState();
    imagesAlbum =
    List<Images>.from(getIt<UpdateCenterCubit>().imagesAlbum ?? []);
  }

  // Function to delete an image
  void _deleteImage(int index) {
    setState(() {
      imagesAlbum.removeAt(index);
    });
    // Optionally, update the Cubit or backend to reflect the changes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray100,
      appBar: CustomAppBar(
        title: getLang(context, "Edit Workshop Center Profile").toString(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Constants.hPadding,
          vertical: Constants.hPadding,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                getLang(context, "Photo Album:").toString(),
                style: TextStyles.gray950FS18FW500TextStyle,
              ),
              verticalSpace(20),
              // GridView for images
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: imagesAlbum.length,
                itemBuilder: (context, index) {
                  final String imageUrl = imagesAlbum[index].image ?? '';

                  return Stack(
                    children: [
                      // Image container
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Delete button (trash icon)
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () {
                            getIt<UpdateCenterCubit>()
                                .deleteAlbum(
                                id: int.parse(
                                    imagesAlbum[index].id.toString()))
                                .then((_) {
                              _deleteImage(index);
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.7),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.delete,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              verticalSpace(30),
              PhotoAlbumWidget(),
              BlocListener<UpdateCenterCubit, UpdateCenterState>(
                listener: (context, state) {
                  if (state is DeleteAlbumSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.data!.message!),
                      ),
                    );
                  }   if (state is AddImageSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.data!.message!),
                      ),
                    );
                  }
                  if (state is DeleteAlbumErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                  if (state is AddImageErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                }, child: SizedBox.shrink(),
              ),
              verticalSpace(30),
              SaveCancelButtons(
                onCancelPressed: () {
                  Navigator.pop(context);
                },
                onSavedPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
