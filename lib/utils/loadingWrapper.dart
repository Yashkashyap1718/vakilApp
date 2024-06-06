// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vakil_app/Provider/home_provider.dart';
import 'package:vakil_app/constants/colors.dart';

class LoadingWrapper extends StatelessWidget {
  final Widget child;

  const LoadingWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        child,
        Consumer<HomeProvider>(
          builder: (_, homeProvider, __) {
            if (!homeProvider.isLoading) {
              return const SizedBox.shrink();
            } else {
              return Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: width,
                  decoration: const BoxDecoration(color: Colors.black45),
                  child: Center(
                    child: Container(
                      width: width * 0.25,
                      height: width * 0.25,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      padding: const EdgeInsets.all(32),
                      child: const CircularProgressIndicator(color: whiteColor),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
