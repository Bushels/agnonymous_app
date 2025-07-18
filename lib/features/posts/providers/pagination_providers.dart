import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../core/models/post_model.dart';
import 'post_providers.dart';
import '../../../core/constants/app_constants.dart';

final postPagingControllerProvider = Provider.autoDispose<
    PagingController<int, Post>>((ref) {
  final PagingController<int, Post> pagingController =
      PagingController(firstPageKey: 0);

  void fetchPage(int pageKey) async {
    try {
      final newItems = await ref.read(postsProvider((limit: AppConstants.postsPerPage, offset: pageKey, category: null)).future);
      final isLastPage = newItems.length < AppConstants.postsPerPage;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  pagingController.addPageRequestListener(fetchPage);
  ref.onDispose(() => pagingController.dispose());
  return pagingController;
});