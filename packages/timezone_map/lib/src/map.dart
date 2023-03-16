import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:vector_graphics/vector_graphics.dart';

import 'latlng.dart';

/// A widget that displays a map of the world.
class TimezoneMap extends StatelessWidget {
  /// Creates a map.
  const TimezoneMap({
    super.key,
    this.marker,
    this.offset,
    this.onPressed,
  });

  /// Coordinates of a map marker.
  final LatLng? marker;

  /// UTC-offset of the highlighted timezone.
  final double? offset;

  /// Called when the map is pressed at [coordinates].
  final void Function(LatLng coordinates)? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) async {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null && onPressed != null) {
          onPressed!(toLatLng(details.localPosition, box.size));
        }
      },
      child: MouseRegion(
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              const Positioned.fill(
                child: SvgPicture(
                  AssetBytesLoader('assets/map.svg.vec',
                      packageName: 'timezone_map'),
                  fit: BoxFit.fill,
                ),
              ),
              if (offset != null)
                Positioned.fill(
                  child: SvgPicture(
                    AssetBytesLoader(
                        'assets/tz_${_formatTimezoneOffset(offset!)}.svg.vec',
                        packageName: 'timezone_map'),
                    fit: BoxFit.fill,
                  ),
                ),
              if (marker != null)
                Positioned(
                  left: lng2x(marker!.longitude, constraints.maxWidth) - 12,
                  top: lat2y(marker!.latitude, constraints.maxHeight) - 24,
                  child: const Icon(Icons.place, color: Colors.red, size: 24),
                ),
            ],
          );
        }),
      ),
    );
  }
}

// Shortest double (%g) representation: 0, 1, 5.5, 5.75, ...
String _formatTimezoneOffset(double offset) {
  final format = NumberFormat(null, 'en_US'); // decimal separator = "."
  format.minimumFractionDigits = 0;
  format.maximumFractionDigits = 2;
  return format.format(offset);
}
