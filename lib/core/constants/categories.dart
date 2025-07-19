import 'package:flutter/material.dart';

class AgriculturalCategory {
  final String id;
  final String name;
  final String icon;
  final Color color;

  const AgriculturalCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

class AgriculturalCategories {
  static const List<AgriculturalCategory> categories = [
    AgriculturalCategory(
      id: 'livestock',
      name: 'Livestock',
      icon: '🐄',
      color: Color(0xFF8B4513), // Rich brown
    ),
    AgriculturalCategory(
      id: 'crops',
      name: 'Crops',
      icon: '🌾',
      color: Color(0xFFDAA520), // Golden wheat
    ),
    AgriculturalCategory(
      id: 'chemicals',
      name: 'Chemicals',
      icon: '🧪',
      color: Color(0xFFCD853F), // Peru brown
    ),
    AgriculturalCategory(
      id: 'machinery',
      name: 'Machinery',
      icon: '🚜',
      color: Color(0xFF4682B4), // Steel blue
    ),
    AgriculturalCategory(
      id: 'labor',
      name: 'Labor',
      icon: '👷',
      color: Color(0xFFD2691E), // Chocolate brown
    ),
    AgriculturalCategory(
      id: 'weather',
      name: 'Weather',
      icon: '🌦️',
      color: Color(0xFF228B22), // Forest green
    ),
    AgriculturalCategory(
      id: 'business',
      name: 'Business',
      icon: '💼',
      color: Color(0xFF6B46C1), // Purple
    ),
    AgriculturalCategory(
      id: 'politics',
      name: 'Politics',
      icon: '🏛️',
      color: Color(0xFFDC2626), // Red
    ),
    AgriculturalCategory(
      id: 'general',
      name: 'General',
      icon: '💬',
      color: Color(0xFF059669), // Emerald
    ),
    AgriculturalCategory(
      id: 'other',
      name: 'Other',
      icon: '📋',
      color: Color(0xFF696969), // Dim gray
    ),
  ];

  static AgriculturalCategory getCategoryById(String id) {
    return categories.firstWhere(
      (category) => category.id == id,
      orElse: () => categories.last, // Default to 'other' if not found
    );
  }

  static AgriculturalCategory getTrendingCategory(List<dynamic> posts) {
    if (posts.isEmpty) {
      return getCategoryById('general');
    }

    final categoryCounts = <String, int>{};
    for (final post in posts) {
      final category = post['category'] as String;
      categoryCounts[category] = (categoryCounts[category] ?? 0) + 1;
    }

    final sortedCategories = categoryCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return getCategoryById(sortedCategories.first.key);
  }
}