import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class CommentsBloc {
  CommentsBloc() {
    _commentsFetcher.stream
        .transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }

  final _repository = Repository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  Stream<Map<int, Future<ItemModel>>> get itemWithComments =>
      _commentsOutput.stream;

  void Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  _commentsTransformer() =>
      ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
        (cache, id, _) => cache
          ..[id] = _repository.fetchItem(id)
          ..[id]?.then((item) {
            item.kids.forEach((kidId) => fetchItemWithComments(kidId));
          }),
        <int, Future<ItemModel>>{},
      );

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}
