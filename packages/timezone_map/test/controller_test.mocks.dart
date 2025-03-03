// Mocks generated by Mockito 5.4.2 from annotations
// in timezone_map/test/controller_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:timezone_map/src/location.dart' as _i5;
import 'package:timezone_map/src/service.dart' as _i2;
import 'package:timezone_map/src/source.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [GeoService].
///
/// See the documentation for Mockito's code generation for more information.
class MockGeoService extends _i1.Mock implements _i2.GeoService {
  MockGeoService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void addSource(_i3.GeoSource? source) => super.noSuchMethod(
        Invocation.method(
          #addSource,
          [source],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeSource(_i3.GeoSource? source) => super.noSuchMethod(
        Invocation.method(
          #removeSource,
          [source],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i4.Future<void> init() => (super.noSuchMethod(
        Invocation.method(
          #init,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<_i5.GeoLocation?> lookupLocation() => (super.noSuchMethod(
        Invocation.method(
          #lookupLocation,
          [],
        ),
        returnValue: _i4.Future<_i5.GeoLocation?>.value(),
      ) as _i4.Future<_i5.GeoLocation?>);
  @override
  _i4.Future<Iterable<_i5.GeoLocation>> searchLocation(String? location) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchLocation,
          [location],
        ),
        returnValue:
            _i4.Future<Iterable<_i5.GeoLocation>>.value(<_i5.GeoLocation>[]),
      ) as _i4.Future<Iterable<_i5.GeoLocation>>);
  @override
  _i4.Future<Iterable<_i5.GeoLocation>> searchCoordinates(
          _i5.LatLng? coordinates) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchCoordinates,
          [coordinates],
        ),
        returnValue:
            _i4.Future<Iterable<_i5.GeoLocation>>.value(<_i5.GeoLocation>[]),
      ) as _i4.Future<Iterable<_i5.GeoLocation>>);
  @override
  _i4.Future<Iterable<_i5.GeoLocation>> searchTimezone(String? timezone) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchTimezone,
          [timezone],
        ),
        returnValue:
            _i4.Future<Iterable<_i5.GeoLocation>>.value(<_i5.GeoLocation>[]),
      ) as _i4.Future<Iterable<_i5.GeoLocation>>);
  @override
  _i4.Future<void> cancelSearch() => (super.noSuchMethod(
        Invocation.method(
          #cancelSearch,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
