import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:yeong_mood_tracker/constants/colors.dart';
import 'package:yeong_mood_tracker/constants/constants.dart';
import 'package:yeong_mood_tracker/constants/sizes.dart';
import 'package:yeong_mood_tracker/constants/text.dart';
import 'package:yeong_mood_tracker/view_models/f_post_vm.dart';
import 'package:yeong_mood_tracker/views/f_upload/f_camera_screen.dart';
import 'package:yeong_mood_tracker/widgets/bottom_modal_datetime.dart';

enum Mood { happy, excited, calm, sad, angry, anxious }

const moods = {
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

class UploadScreen extends ConsumerStatefulWidget {
  static const routeName = "upload";
  static const routeUrl = "/upload";

  const UploadScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UploadScreenState();
}

class _UploadScreenState extends ConsumerState<UploadScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final PageController _pageController = PageController();

  Mood? myMood;
  List<XFile>? imgs;
  bool _isPrivate = true;
  bool _isWriting = false;

  void _startWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  void _stopWriting() {
    setState(() {
      _isWriting = false;
    });
  }

  void _onCancelTap() async {
    await showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text("이 화면을 나가시겠습니까?"),
        content: Text("작성된 내용이 저장되지 않습니다."),
        actions: [
          CupertinoDialogAction(
            onPressed: () => context.pop(),
            isDestructiveAction: true,
            child: Text("아니오"),
          ),
          CupertinoDialogAction(
            onPressed: () {
              _stopWriting();
              context.pop();
              context.pop();
            },
            child: Text("예"),
          )
        ],
      ),
    );
  }

  void _togglePrivate() {
    setState(() {
      _isPrivate = !_isPrivate;
    });
  }

  Future<void> _onTimePickerPressed() async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const BottomModalDatetime(),
    );
  }

  Future<void> _onCameraPressed() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CameraScreen()),
    );

    if (result == null) return;

    if (imgs == null) {
      imgs = [result];
    } else {
      imgs!.add(result);
      _pageController.jumpToPage(imgs!.length);
    }

    setState(() {});
  }

  void _onDeletePressed(XFile img) {
    setState(() {
      imgs!.remove(img);
    });
  }

  Future<void> _onSubmitTap() async {
    if (_titleController.text.isEmpty || myMood == null) {
      return;
    }
    final data = {
      "title": _titleController.text,
      "mood": moods[myMood],
      "content": _contentController.text,
      "isPrivate": _isPrivate,
    };
    await ref.read(postProvider.notifier).uploadPost(data: data);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Consumer(
          builder: (context, ref, child) {
            final createdAt = ref.watch(postUploadProvider).createdAt;
            return TtitleMedium18(
              "${createdAt.month}월 ${createdAt.day}일 ${weekdays[createdAt.weekday]}요일",
            );
          },
        ),
        elevation: 0.5,
        leading: TextButton(
          onPressed: _onCancelTap,
          child: TbodyMedium16("Cancel", color: AppColors.neutral500),
        ),
        leadingWidth: Sizes.d100,
        actions: [
          IconButton(
            onPressed: _onSubmitTap,
            icon: FaIcon(
              FontAwesomeIcons.check,
              color: _isWriting ? AppColors.neutral900 : AppColors.neutral500,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    Sizes.d24,
                    Sizes.d24,
                    Sizes.d24,
                    Sizes.d60,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: Sizes.d10,
                    children: [],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.fromLTRB(Sizes.d24, Sizes.d6, Sizes.d24, 0),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _togglePrivate,
                  child: TlabelLarge14(_isPrivate ? "비공개" : "공개"),
                ),
                IconButton(
                  onPressed: _onCameraPressed,
                  icon: FaIcon(FontAwesomeIcons.camera),
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Consumer(
                builder: (context, ref, child) {
                  final createdAt = ref.watch(postUploadProvider).createdAt;
                  return TextButton(
                    onPressed: _onTimePickerPressed,
                    child: TtitleSmall16(
                      "${createdAt.hour}시 ${createdAt.minute}분",
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
