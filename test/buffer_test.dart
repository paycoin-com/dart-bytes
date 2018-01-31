// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file of the Dart project.
library bytes.test.buffer;

import "dart:typed_data";

import "package:test/test.dart";

import "package:bytes/bytes.dart";

main() {
  test("Buffer", () {
    var b;
    testLength(n) {
      expect(b, hasLength(n));
      if (n == 0) {
        expect(b.isEmpty, isTrue);
      } else {
        expect(b.isEmpty, isFalse);
      }
    }

    b = new Buffer();
    testLength(0);

    b.addByte(0);
    testLength(1);

    b.add([1, 2, 3]);
    testLength(4);

    b.add(<int>[4, 5, 6]);
    testLength(7);

    b.add(new Uint8List.fromList([7, 8, 9]));
    testLength(10);

    b.add(new Uint16List.fromList([10, 11, 12]));
    testLength(13);

    var bytes = b.copyBytes();
    expect(bytes, new isInstanceOf<Uint8List>());
    expect(bytes, orderedEquals([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]));
    testLength(13);

    b.add("\x0d\x0e\x0f".codeUnits);
    testLength(16);

    bytes = b.takeBytes();
    testLength(0);
    expect(bytes, new isInstanceOf<Uint8List>());
    expect(bytes,
        orderedEquals([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]));

    b.addByte(0);
    testLength(1);

    b.clear();
    testLength(0);

    b.addByte(0);
    testLength(1);
  });

  // two tests that I had from Dartcoin
  test("byte_sink_1", () {
    Buffer bs = new Buffer();
    bs.add(new Uint8List.fromList([1, 2, 3]));
    expect(bs.length, equals(3));
    bs.add([4, 5, 6, 7]);
    expect(bs.length, equals(7));
    bs.addByte(8);
    expect(bs.asBytes(), equals([1, 2, 3, 4, 5, 6, 7, 8]));
  });

  test("byte_sink_2", () {
    Buffer bs = new Buffer();
    bs.add([4, 5, 6, 7]);
    expect(bs.length, equals(4));
    bs.add(new Uint8List.fromList([1, 2, 3]));
    bs.addByte(8);
    expect(bs.asBytes(), equals([4, 5, 6, 7, 1, 2, 3, 8]));
  });
}
