import 'package:eazy/core/config/app_palette.dart';
import 'package:eazy/core/config/text_styles_manager.dart';
import 'package:flutter/material.dart';

class SearchSection extends StatelessWidget {
  const SearchSection();

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) {
        if (value.trim().isNotEmpty) {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => SearchResultPage(query: value),
          //   ),
          // );
        }
      },
      decoration: InputDecoration(
        hintText: 'ابحث عن درس ...',
        hintStyle: TextStylesManager.titleSmall,
        prefixIcon: Icon(
          Icons.search_sharp,
          color: AppPalette.lightBlack,
          size: 22,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        filled: true,
        fillColor: AppPalette.textFiledSearch,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: AppPalette.textFiledEnabledBorder,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: AppPalette.textFiledEnabledBorder,
            width: 1,
          ),
        ),
      ),
      style: TextStyle(color: AppPalette.textBlack),
    );
  }
}
