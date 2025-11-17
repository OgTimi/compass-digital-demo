import 'package:compass_digital_demo/services/yelp_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Fetch restaurants returns a list', () async {
    final service = YelpService();
    final result = await service.fetchRestaurants('Toronto');
    expect(result.isNotEmpty, true);
  });
}
