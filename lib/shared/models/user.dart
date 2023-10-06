import 'package:isar/isar.dart';

@embedded
class Phone {
  String? code;
  String? number;
  String? formattedNumber;

  Phone({
    this.code,
    this.number,
    this.formattedNumber,
  });

  factory Phone.fromMap(Map<String, dynamic> phoneData) {
    return Phone(
      code: phoneData['code'],
      number: phoneData['number'],
      formattedNumber: phoneData['formattedNumber'],
    );
  }
  String get rawNumber => '$code$number';

  String getFormattedNumber() => formattedNumber ?? '$code $number';

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'number': number,
      'formattedNumber': formattedNumber,
      'rawNumber': rawNumber,
    };
  }
}

@collection
class User {
  Id isarId = Isar.autoIncrement;
  final String id;
  final String name;
  final String avatarUrl;
  final String phone;

  @Enumerated(EnumType.value, 'value')
  UserActivityStatus activityStatus;

  User({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.phone,
    required this.activityStatus,
  });

  factory User.fromMap(Map<String, dynamic> userData) {
    return User(
      id: userData['id'],
      name: userData['name'],
      avatarUrl: userData['avatarUrl'],
      phone: userData['phone'],
      activityStatus: UserActivityStatus.fromValue(userData['activityStatus']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'avatarUrl': avatarUrl,
      'phone': phone,
      'activityStatus': activityStatus.value,
    };
  }

  @override
  String toString() {
    return name;
  }
}

enum UserActivityStatus {
  online('Online'),
  offline('Offline');

  final String value;
  const UserActivityStatus(this.value);

  factory UserActivityStatus.fromValue(String value) {
    final res = UserActivityStatus.values.where(
      (element) => element.value == value,
    );

    if (res.isEmpty) {
      throw 'ValueError: $value is not a valid status code';
    }

    return res.first;
  }
}
