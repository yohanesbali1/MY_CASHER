import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get indonesia {
    return DateFormat('dd MMMM yyyy', 'id_ID').format(this);
  }

  String get fullIndonesia {
    return DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(this);
  }

  String get jam {
    return DateFormat('HH:mm', 'id_ID').format(this);
  }
}
