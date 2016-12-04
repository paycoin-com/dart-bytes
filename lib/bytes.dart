library bytes;


import "dart:math";
import "dart:typed_data";

// Reader
part "src/reader.dart";
part "src/reader_base.dart";
part "src/reader_impl.dart";

// Buffer
part "src/buffer.dart";
part "src/buffer_impl.dart";


/// An [Exception] that is throws when trying to read more bytes than available.
class EndOfFileException implements Exception {
  @override
  String toString() => "EOF";
}