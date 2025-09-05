import 'package:eazy/core/config/app_palette.dart';
import 'package:eazy/core/config/text_styles_manager.dart';
import 'package:eazy/features/home/Data/home_cubit.dart';
import 'package:eazy/features/home/presentation/Screens/section_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('الأقسام ', style: TextStylesManager.titleLarge),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SectionScreen(),
                  ),
                );
              },
              child: Text('المزيد', style: TextStylesManager.bodySmallLight),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const ServiceGrid(),
      ],
    );
  }
}

class ServiceGrid extends StatelessWidget {
  const ServiceGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeLoaded) {
          final categories = state.homeData.categories;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return ServiceCard(
                title: category.title,
                imageUrl: category.image,
              );
            },
          );
        } else if (state is HomeError) {
          return Center(child: Text("Error: ${state.message}"));
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const ServiceCard({required this.title, required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppPalette.foregroundLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // هنا ممكن تروح لصفحة تفاصيل القسم
          },
          borderRadius: BorderRadius.circular(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: AppPalette.badgeButton,
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  imageUrl,
                  width: 25,
                  height: 25,
                  errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.error, color:AppPalette.foregroundLight),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStylesManager.titleSmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
