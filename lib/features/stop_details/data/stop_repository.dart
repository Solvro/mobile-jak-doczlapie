import 'package:jak_doczlapie/features/home/data/stop.dart';
import 'package:jak_doczlapie/features/home/data/stops_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stop_repository.g.dart';

@riverpod
Future<Stop> stopRepository(Ref ref, int id) async {
  final stops = await ref.watch(stopsRepositoryProvider.future);
  return stops.firstWhere((stop) => id == stop.id);
}
