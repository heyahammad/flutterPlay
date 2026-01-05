import 'package:uuid/uuid.dart' as uuid;

const pid = uuid.Uuid();

class Place {
  Place({required this.title}) : id = pid.v4();
  final String title;
  final String id;
}
