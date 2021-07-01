import 'package:flutter/material.dart';
import 'filterChip.dart';

class FilterChips {
  static final all = <FilterChipData>[
    FilterChipData(
      label: 'Terror',
      isSelected: false,
      color: Colors.white
    ),
    FilterChipData(
      label: 'Ficção Científica',
      isSelected: false,
      color: Colors.white,
    ),
    FilterChipData(
      label: 'Romance',
      isSelected: false,
      color: Colors.white,
    ),
    FilterChipData(
      label: 'Ação',
      isSelected: false,
      color: Colors.white,
    ),
    FilterChipData(
      label: 'Aventura',
      isSelected: false,
      color: Colors.white,
    ),
  ];
}