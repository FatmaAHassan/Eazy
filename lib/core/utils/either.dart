class Either<L, R> {
  final L? _left;
  final R? _right;

  Either._({L? left, R? right})
      : _left = left,
        _right = right;

  /// Factory methods
  static Either<L, R> left<L, R>(L value) => Either._(left: value);
  static Either<L, R> right<L, R>(R value) => Either._(right: value);

  /// Getters
  bool get isLeft => _left != null;
  bool get isRight => _right != null;

  L get getLeft => _left as L;
  R get getRight => _right as R;

  /// `when` function (cleaner than if/else)
  T when<T>({
    required T Function(L failure) failure,
    required T Function(R success) success,
  }) {
    if (_left != null) {
      return failure(_left as L);
    } else {
      return success(_right as R);
    }
  }
  T fold<T>(T Function(L l) leftOp, T Function(R r) rightOp) {
    if (_left != null) {
      return leftOp(_left as L);
    } else {
      return rightOp(_right as R);
    }
  }

}
