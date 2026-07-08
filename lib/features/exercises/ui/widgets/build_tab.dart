// import 'package:flutter/material.dart';
// import 'package:flutter_coffee/core/theme/app_color.dart';

// class BuildTab extends StatelessWidget {
//   const BuildTab({super.key});
// final TabController _tabController ;
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _tabController,
//       builder: (context, _) {
//         final isSelected = _tabController.index == index;
//         return GestureDetector(
//           onTap: () => _tabController.animateTo(index),
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 200),
//             padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
//             decoration: BoxDecoration(
//               color: isSelected ? AppColors.accentColor : AppColors.cardColor,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Text(
//               label,
//               style: TextStyle(
//                 color: isSelected ? Colors.black : AppColors.textSecondary,
//                 fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                 fontSize: 13,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
