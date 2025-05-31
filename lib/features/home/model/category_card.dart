import 'package:emergency_one/core/constants/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String iconPath;
  const CategoryCard({super.key, required this.title, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Column(
                  children: [
                    Container(
                      width: 80,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SvgPicture.asset(
                        iconPath,
                        height: 50,
                        width: 50,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(title),
                  ],
                );
  }
}