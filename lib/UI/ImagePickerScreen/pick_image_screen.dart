import 'dart:io';
import 'package:bloc_tutorial/Bloc/Image_picker_bloc/bloc.dart';
import 'package:bloc_tutorial/Bloc/Image_picker_bloc/events.dart';
import 'package:bloc_tutorial/Bloc/Image_picker_bloc/state.dart';
import 'package:bloc_tutorial/Utils/image_picker_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagePickScreen extends StatefulWidget {
  const ImagePickScreen({super.key});

  @override
  State<ImagePickScreen> createState() => _ImagePickScreenState();
}

class _ImagePickScreenState extends State<ImagePickScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Center(child: Text("I m a g e  P i c k e r "))),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ImagePickerBloc(ImagePickerUtils()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: BlocBuilder<ImagePickerBloc, ImagePickerState>(
                  builder: (context, state) {
                    return state.file == null
                        ? InkWell(
                            onTap: () {
                              // context.read<ImagePickerBloc>().add(
                              //   CameraPickerEvent(),
                              // );
                              context.read<ImagePickerBloc>().add(
                                GalleryPickerEvent(),
                              );
                            },
                            child: CircleAvatar(child: Icon(Icons.search)),
                          )
                        : Image.file(File(state.file!.path.toString()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
