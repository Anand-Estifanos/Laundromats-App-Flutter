import 'package:flutter/material.dart';
import 'package:laundromats/src/constants/app_styles.dart';
import 'package:laundromats/src/utils/index.dart';

class ProfileStatusWidget extends StatelessWidget {
  final int? askedCount;
  final int? commentCount;

  const ProfileStatusWidget({
    super.key,
    required this.askedCount,
    required this.commentCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: vMin(context, 4),
        vertical: vMin(context, 3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Level with horizontal progress bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Level',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Onset-Regular',
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: vMin(context, 4)),
                  // Display Beginner label
                  const Text(
                    'Beginner',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Onset',
                      color: kColorSecondary,
                    ),
                  ),
                ],
              ),
              // Display Level label

              SizedBox(height: vMin(context, 1)),
              // Horizontal progress bar
              Container(
                height: 10,
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.3, // Adjust for progress percentage
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [kColorPrimary, Colors.lightGreen],
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              SizedBox(height: vMin(context, 2)),
            ],
          ),

          SizedBox(
            height: vh(context, 3),
          ),
          // Asked and Commented in one row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem(
                context,
                icon: Icons.question_answer,
                count: askedCount,
                label: "Asked",
              ),
              _buildStatItem(
                context,
                icon: Icons.comment,
                count: commentCount,
                label: "Commented",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context,
      {required IconData icon, int? count, required String label}) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 28, color: kColorPrimary),
            SizedBox(width: vMin(context, 1)),
            Text(
              count?.toString() ?? '0',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Onset',
                color: kColorSecondary,
              ),
            ),
          ],
        ),
        SizedBox(height: vMin(context, 0.5)),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'Onset-Regular',
            color: kColorSecondary,
          ),
        ),
      ],
    );
  }
}
