import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeong_mood_tracker/constants/colors.dart';
import 'package:yeong_mood_tracker/constants/gaps.dart';
import 'package:yeong_mood_tracker/constants/sizes.dart';
import 'package:yeong_mood_tracker/view_models/f_post_vm.dart';
import 'package:yeong_mood_tracker/view_models/settings_vm.dart';

enum Mood { happy, excited, calm, sad, angry, anxious }

const moods = [
  Mood.happy,
  Mood.excited,
  Mood.calm,
  Mood.sad,
  Mood.angry,
  Mood.anxious,
];

const moodsStr = {
  Mood.happy: "happy",
  Mood.excited: "excited",
  Mood.calm: "calm",
  Mood.sad: "sad",
  Mood.angry: "angry",
  Mood.anxious: "anxious",
};

const moodImgs = {
  Mood.happy: "assets/images/happy.png",
  Mood.excited: "assets/images/excited.png",
  Mood.calm: "assets/images/calm.png",
  Mood.sad: "assets/images/sad.png",
  Mood.angry: "assets/images/angry.png",
  Mood.anxious: "assets/images/anxious.png",
};

class MoodButtons extends ConsumerStatefulWidget {
  const MoodButtons({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MoodButtonsState();
}

class _MoodButtonsState extends ConsumerState<MoodButtons> {
  void _onMoodTap(Mood newMood) {
    ref.read(postUploadProvider.notifier).updateMood(moodsStr[newMood]!);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(settingsProvider.notifier).isDark(context);
    return Row(
      spacing: Sizes.d4,
      children: [
        for (var mood in moods)
          Consumer(
            builder: (context, ref, child) {
              final selectedMood = ref.watch(postUploadProvider).mood;
              final isSelected = selectedMood == moodsStr[mood];
              return GestureDetector(
                onTap: () => _onMoodTap(mood),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.all(Sizes.d8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Sizes.d6,
                    ),
                    color: isSelected
                        ? isDark
                            ? AppColors.secondary
                            : AppColors.secondaryDarkest
                        : Colors.transparent,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        moodImgs[mood]!,
                        width: Sizes.d36,
                      ),
                      Gaps.v8,
                      SizedBox(
                        width: Sizes.d56,
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.neutral400),
                          textAlign: TextAlign.center,
                          child: Text(moodsStr[mood]!),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
