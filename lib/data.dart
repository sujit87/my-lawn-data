/// Facilitates immutable, equatable, serializable data classes.
library data;

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// A `Data` is an immutable, equatable,
/// and serializable collection of properties.
@immutable
abstract class Data extends Equatable {
  /// Returns a [List] of names of properties held by this [Data].
  ///
  /// Ordering is important, and must match that of [props].
  ///
  /// This facilitates JSON conversion, via [toMap].
  ///
  /// Any properties not listed are excluded from serialization.
  List<String> get propsNames => null;

  /// Returns a [List] of properties held by this [Data].
  ///
  /// Ordering is important only if you also override
  /// [propsNames], for use with [toMap].
  ///
  /// This facilitates equality checking.
  ///
  /// Any properties not listed are excluded
  /// from equatability and serialization.
  @override
  List<Object> get props;

  /// @nodoc
  @override
  bool get stringify => true;

  /// Returns a [Map] of properties held by this [Data],
  /// where [propsNames] represents keys and [props] values.
  ///
  /// This facilitates JSON conversion.
  Map<String, dynamic> toMap() {
    assert(
      props != null && propsNames != null,
      'props and propsNames must not be null',
    );

    assert(
      props.length == propsNames.length,
      'props and propsNames are not the same length',
    );

    return {
      for (int i = 0; i < propsNames.length; i++)
        propsNames[i]: props[i] is Data ? (props[i] as Data).toMap() : props[i],
    };
  }
}
