library bytes.src.buffer;


import "reader.dart";
import "buffer_impl.dart";


abstract class Buffer implements Reader, Sink<List<int>> {

  /// Create a new Buffer.
  ///
  /// Arguments:
  /// - [copy]: if true, this [Buffer] will always make a copy of data before
  ///     returning it
  factory Buffer({bool copy: false}) {
    return new BufferImpl(copy ?? false);
  }

  /// Appends [bytes] at the end of the buffer.
  @override
  void add(List<int> bytes);

  /// Appens a single [byte] at the end of the buffer.
  void addByte(int byte);

  /// Grow the buffer's capacity to guarantee space for another n bytes.
  void grow(int n);

  /// Clear the content of the buffer.
  void clear();

  /// Returns `true` if this buffer is empty.
  bool get isEmpty;

  /// Returns a view on the current content of the buffer.
  List<int> asBytes();

  /// Returns a copy of the current content of the buffer.
  List<int> copyBytes();

  /// Returns a view on the current content of the buffer and clears its
  /// contents.
  List<int> takeBytes();
}