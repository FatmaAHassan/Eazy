import 'package:eazy/core/Api/api_service.dart';
import 'package:eazy/core/config/text_styles_manager.dart';
import 'package:eazy/features/home/Data/data_source/home_remote_datasource.dart';
import 'package:eazy/features/home/Data/home_cubit.dart';
import 'package:eazy/features/home/presentation/widgets/continue_lessons.dart';
import 'package:eazy/features/home/presentation/widgets/offers_section.dart';
import 'package:eazy/features/home/presentation/widgets/search_section.dart';
import 'package:eazy/features/home/presentation/widgets/servicesSection.dart';
import 'package:eazy/notification/presentation/screen/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:eazy/core/config/app_palette.dart';
import 'package:eazy/core/config/images_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          HomeCubit(HomeRemoteDataSource(ApiService()))..fetchHomeData(),
      child: Scaffold(
        backgroundColor: AppPalette.backgroundLight,
        appBar: _buildAppBar(context),
        body: const SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchSection(),
              SizedBox(height: 15),
              WelcomeSection(),
              SizedBox(height: 10),
              PromotionalBanner(),
              SizedBox(height: 10),
              ServicesSection(),
              SizedBox(height: 10),
              ContinueLessonsSection(),
            ],
          ),
        ),
      ),
    );
  }
}

PreferredSizeWidget _buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppPalette.backgroundLight,
    elevation: 0,
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'مرحباً بك في',
                textAlign: TextAlign.right,
                style: TextStylesManager.titleLarge,
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(2),
                child: Image.asset(ImagesManager.eazytxt),
              ),
              const SizedBox(width: 2),
              Text(
                "!",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationScreen(),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(),
            child: SvgPicture.asset(ImagesManager.notification),
          ),
        ),
      ],
    ),
  );
}
