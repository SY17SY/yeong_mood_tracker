import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeong_mood_tracker/models/f_post_model.dart';
import 'package:yeong_mood_tracker/repos/b_auth_repo.dart';
import 'package:yeong_mood_tracker/repos/f_post_repo.dart';

class PostViewModel extends StreamNotifier<List<PostModel>> {
  late final PostRepository _repository;

  @override
  Stream<List<PostModel>> build() {
    _repository = ref.read(postRepository);

    return _repository.getPosts();
  }

  Future<void> uploadPost({
    required Map<String, dynamic> data,
    List<File>? files,
  }) async {
    state = AsyncValue.loading();

    final uid = ref.read(authRepository).user!.uid;
    final uploadState = ref.read(postUploadProvider);

    state = await AsyncValue.guard(() async {
      final postId = _repository.generatePostId();

      final thumbUrl = files != null
          ? await _repository.uploadPost(
              file: files[0],
              uid: uid,
              postId: postId,
            )
          : null;
      final imageUrls = files != null
          ? await Future.wait(files.skip(1).map(
                (file) async => await _repository.uploadPost(
                  file: file,
                  uid: uid,
                  postId: postId,
                ),
              ))
          : null;

      var post = PostModel(
        id: postId,
        uid: uid,
        title: data["title"]!,
        mood: data["mood"]!,
        content: data["content"],
        thumbUrl: thumbUrl,
        imgUrls: imageUrls,
        isPrivate: data["isPrivate"],
        createdAt: Timestamp.fromDate(uploadState.createdAt),
      );
      await _repository.createPostWithId(post);

      return [post];
    });
  }

  Future<void> deletePost(String postId) async {
    final uid = ref.read(authRepository).user!.uid;
    await _repository.deletePost(postId);
    await _repository.deletePostFiles(uid: uid, postId: postId);
  }
}

class PostUploadState {
  final DateTime createdAt;

  PostUploadState({required this.createdAt});
}

class PostUploadViewModel extends StateNotifier<PostUploadState> {
  PostUploadViewModel()
      : super(PostUploadState(
          createdAt: DateTime.now().subtract(
            Duration(minutes: DateTime.now().minute % 10),
          ),
        ));

  void updateCreatedAt(DateTime dateTime) {
    state = PostUploadState(createdAt: dateTime);
  }

  void resetToNow() {
    final now = DateTime.now();
    state = PostUploadState(
      createdAt: now.subtract(Duration(minutes: now.minute % 10)),
    );
  }
}

final postProvider = StreamNotifierProvider<PostViewModel, List<PostModel>>(
  () => PostViewModel(),
);

final postUploadProvider =
    StateNotifierProvider<PostUploadViewModel, PostUploadState>(
  (ref) => PostUploadViewModel(),
);
