import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum LanguageProficiency {
  a1,
  a2,
  b1,
  b2,
  c1,
  c2,
  native;

  String get label => switch (this) {
        a1 => 'A1',
        a2 => 'A2',
        b1 => 'B1',
        b2 => 'B2',
        c1 => 'C1',
        c2 => 'C2',
        native => 'Native',
      };
}
