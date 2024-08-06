import 'package:flutter/material.dart';
import 'package:food_delivery/models/food.dart';

class MyTabBar extends StatelessWidget {
  final TabController tabController;
  const MyTabBar({super.key, required this.tabController});

  List<Tab> _buildCategoryTabs() {
    return FoodCategory.values.map((category) {
      return Tab(
        text: category.toString().split('.').last,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
        dividerColor: Theme.of(context).colorScheme.background,
        controller: tabController,
        isScrollable: true, // hien thi do dai cua item
        tabAlignment: TabAlignment.center, // can giua cac item

        // labelColor: Theme.of(context).colorScheme.primary,
        tabs: _buildCategoryTabs());
  }
}
