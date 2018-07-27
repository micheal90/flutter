// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('BorderSide - asserts when constructed incorrectly', () {
    expect(
      const BorderSide(),
      const BorderSide(
        color: const Color(0xFF000000),
        width: 1.0,
        style: BorderStyle.solid,
      ),
    );
    expect(() => new BorderSide(color: nonconst(null)), throwsAssertionError);
    expect(() => new BorderSide(width: nonconst(null)), throwsAssertionError);
    expect(() => new BorderSide(style: nonconst(null)), throwsAssertionError);
    expect(() => new BorderSide(width: nonconst(-1.0)), throwsAssertionError);
    expect(
      const BorderSide(width: -0.0),
      const BorderSide(
        color: const Color(0xFF000000),
        width: 0.0,
        style: BorderStyle.solid,
      ),
    );
  });
  test('BorderSide - merging', () {
    const BorderSide blue = const BorderSide(color: const Color(0xFF0000FF));
    const BorderSide blue2 = const BorderSide(color: const Color(0xFF0000FF), width: 2.0);
    const BorderSide green = const BorderSide(color: const Color(0xFF00FF00));
    const BorderSide green2 = const BorderSide(color: const Color(0xFF00FF00), width: 2.0);
    const BorderSide green3 = const BorderSide(color: const Color(0xFF00FF00), width: 3.0);
    const BorderSide green5 = const BorderSide(color: const Color(0xFF00FF00), width: 5.0);
    const BorderSide none = const BorderSide(style: BorderStyle.none);
    const BorderSide none2 = const BorderSide(color: const Color(0xFF0000FF), width: 2.0, style: BorderStyle.none);
    const BorderSide none3 = const BorderSide(style: BorderStyle.none, width: 3.0);
    const BorderSide side2 = const BorderSide(width: 2.0);
    const BorderSide side3 = const BorderSide(width: 3.0);
    const BorderSide side5 = const BorderSide(width: 5.0);
    const BorderSide solid = const BorderSide(style: BorderStyle.solid);
    const BorderSide yellowNone = const BorderSide(style: BorderStyle.none, color: const Color(0xFFFFFF00), width: 0.0);
    // canMerge
    expect(      BorderSide.canMerge(BorderSide.none, BorderSide.none), isTrue);
    expect(      BorderSide.canMerge(BorderSide.none, side2), isTrue);
    expect(      BorderSide.canMerge(BorderSide.none, yellowNone), isTrue);
    expect(      BorderSide.canMerge(green, blue), isFalse);
    expect(      BorderSide.canMerge(green2, blue2), isFalse);
    expect(      BorderSide.canMerge(green2, green3), isTrue);
    expect(      BorderSide.canMerge(green2, none2), isFalse);
    expect(      BorderSide.canMerge(none3, BorderSide.none), isTrue);
    expect(      BorderSide.canMerge(none3, side2), isFalse);
    expect(      BorderSide.canMerge(none3, yellowNone), isTrue);
    expect(() => BorderSide.canMerge(null, null), throwsAssertionError);
    expect(() => BorderSide.canMerge(null, side2), throwsAssertionError);
    expect(      BorderSide.canMerge(side2, BorderSide.none), isTrue);
    expect(      BorderSide.canMerge(side2, none3), isFalse);
    expect(() => BorderSide.canMerge(side2, null), throwsAssertionError);
    expect(      BorderSide.canMerge(side2, side3), isTrue);
    expect(      BorderSide.canMerge(side2, yellowNone), isTrue);
    expect(      BorderSide.canMerge(side3, side2), isTrue);
    expect(      BorderSide.canMerge(solid, none), isFalse);
    expect(      BorderSide.canMerge(yellowNone, side2), isTrue);
    expect(      BorderSide.canMerge(yellowNone, yellowNone), isTrue);
    // merge, for the same combinations
    expect(      BorderSide.merge(BorderSide.none, BorderSide.none), BorderSide.none);
    expect(      BorderSide.merge(BorderSide.none, side2), side2);
    expect(      BorderSide.merge(BorderSide.none, yellowNone), BorderSide.none);
    expect(() => BorderSide.merge(green, blue), throwsAssertionError);
    expect(() => BorderSide.merge(green2, blue2), throwsAssertionError);
    expect(      BorderSide.merge(green2, green3), green5);
    expect(() => BorderSide.merge(green2, none2), throwsAssertionError);
    expect(      BorderSide.merge(none3, BorderSide.none), none3);
    expect(() => BorderSide.merge(none3, side2), throwsAssertionError);
    expect(      BorderSide.merge(none3, yellowNone), none3);
    expect(() => BorderSide.merge(null, null), throwsAssertionError);
    expect(() => BorderSide.merge(null, side2), throwsAssertionError);
    expect(      BorderSide.merge(side2, BorderSide.none), side2);
    expect(() => BorderSide.merge(side2, none3), throwsAssertionError);
    expect(() => BorderSide.merge(side2, null), throwsAssertionError);
    expect(      BorderSide.merge(side2, side3), side5);
    expect(      BorderSide.merge(side2, yellowNone), side2);
    expect(      BorderSide.merge(side3, side2), side5);
    expect(() => BorderSide.merge(solid, none), throwsAssertionError);
    expect(      BorderSide.merge(yellowNone, side2), side2);
    expect(      BorderSide.merge(yellowNone, yellowNone), BorderSide.none);
  });
  test('BorderSide - asserts when copied incorrectly', () {
    const BorderSide green2 = const BorderSide(color: const Color(0xFF00FF00), width: 2.0);
    const BorderSide blue3 = const BorderSide(color: const Color(0xFF0000FF), width: 3.0);
    const BorderSide blue2 = const BorderSide(color: const Color(0xFF0000FF), width: 2.0);
    const BorderSide green3 = const BorderSide(color: const Color(0xFF00FF00), width: 3.0);
    const BorderSide none2 = const BorderSide(color: const Color(0xFF00FF00), width: 2.0, style: BorderStyle.none);
    expect(green2.copyWith(color: const Color(0xFF0000FF), width: 3.0), blue3);
    expect(green2.copyWith(width: 3.0), green3);
    expect(green2.copyWith(color: const Color(0xFF0000FF)), blue2);
    expect(green2.copyWith(style: BorderStyle.none), none2);
  });
  test('BorderSide - scale', () {
    const BorderSide side3 = const BorderSide(width: 3.0, color: const Color(0xFF0000FF));
    const BorderSide side6 = const BorderSide(width: 6.0, color: const Color(0xFF0000FF));
    const BorderSide none = const BorderSide(style: BorderStyle.none, width: 0.0, color: const Color(0xFF0000FF));
    expect(side3.scale(2.0), side6);
    expect(side6.scale(0.5), side3);
    expect(side6.scale(0.0), none);
    expect(side6.scale(-1.0), none);
    expect(none.scale(2.0), none);
  });
  test('BorderSide - toPaint', () {
    final Paint paint1 = const BorderSide(width: 2.5, color: const Color(0xFFFFFF00), style: BorderStyle.solid).toPaint();
    expect(paint1.strokeWidth, 2.5);
    expect(paint1.style, PaintingStyle.stroke);
    expect(paint1.color, const Color(0xFFFFFF00));
    expect(paint1.blendMode, BlendMode.srcOver);
    final Paint paint2 = const BorderSide(width: 2.5, color: const Color(0xFFFFFF00), style: BorderStyle.none).toPaint();
    expect(paint2.strokeWidth, 0.0);
    expect(paint2.style, PaintingStyle.stroke);
    expect(paint2.color, const Color(0x00000000));
    expect(paint2.blendMode, BlendMode.srcOver);
  });
  test('BorderSide - won\'t lerp into negative widths', () {
    const BorderSide side0 = const BorderSide(width: 0.0);
    const BorderSide side1 = const BorderSide(width: 1.0);
    const BorderSide side2 = const BorderSide(width: 2.0);
    expect(BorderSide.lerp(side2, side1, 10.0), BorderSide.none);
    expect(BorderSide.lerp(side1, side2, -10.0), BorderSide.none);
    expect(BorderSide.lerp(side0, side1, 2.0), side2);
    expect(BorderSide.lerp(side1, side0, 2.0), BorderSide.none);
    expect(BorderSide.lerp(side2, side1, 2.0), side0);
  });
  test('BorderSide - toString', () {
    expect(
      const BorderSide(color: const Color(0xFFAABBCC), width: 1.2345).toString(),
      'BorderSide(Color(0xffaabbcc), 1.2, BorderStyle.solid)',
    );
  });
}
