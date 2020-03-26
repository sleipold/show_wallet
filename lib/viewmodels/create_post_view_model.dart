import 'package:flutter/foundation.dart';
import 'package:showwallet/locator.dart';
import 'package:showwallet/models/post.dart';
import 'package:showwallet/services/dialog_service.dart';
import 'package:showwallet/services/firestore_service.dart';
import 'package:showwallet/services/navigation_service.dart';
import 'package:showwallet/viewmodels/base_model.dart';

class CreatePostViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Post _editingPost;

  bool get _editing => _editingPost != null;

  Future addPost({@required String title}) async {
    setBusy(true);

    var result;

    if (!_editing) {
      result = await _firestoreService
          .addPost(Post(title: title, userId: currentUser.id));
    } else {
      result = await _firestoreService.updatePost(Post(
        title: title,
        userId: _editingPost.userId,
        documentId: _editingPost.documentId,
      ));
    }

    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Could not create post',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Post successfully Added',
        description: 'Your post has been created',
      );
    }

    _navigationService.pop();
  }

  void setEditingPost(Post editingPost) {
    _editingPost = editingPost;
  }
}
