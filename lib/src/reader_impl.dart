part of bytes;

/// An implementation of [Reader] that always copies data before returning it.
class _ReaderImpl extends ReaderBase {

  /// Store the bytes.
  ByteBuffer _buffer;
  int _offset = 0;
  bool _copy;

  _ReaderImpl(this._buffer, this._offset, this._copy);

  @override
  int get remainingLength => _buffer.lengthInBytes - _offset;

  @override
  int get length => _buffer.lengthInBytes;

  @override
  List<int> readBytes(int n) {
    if (n < 0) throw new ArgumentError.value(n, "n", "negative");
    if (remainingLength < n) throw new EndOfFileException();

    Uint8List result = _buffer.asUint8List(_offset, n);
    if (_copy) {
      result = new Uint8List.fromList(result);
    }
    _offset += n;
    return result;
  }

  @override
  int readBytesInto(List<int> b) {
    int num = min(remainingLength, b.length);
    b.setRange(0, num, _buffer.asUint8List(_offset, num));
    _offset += num;
    return num;
  }
}