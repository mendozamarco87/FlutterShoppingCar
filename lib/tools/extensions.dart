import 'package:intl/intl.dart';

extension IterableExtensions<T> on Iterable<T> {

  T? get firstOrNull {
    if (this.isEmpty) return null;
    return this.first;
  }

}

extension StringExtensions on String {
  static const diacritics =
      'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
  static const nonDiacritics =
      'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

  String get withoutDiatrics => this.splitMapJoin('',
      onNonMatch: (char) => char.isNotEmpty && diacritics.contains(char)
          ? nonDiacritics[diacritics.indexOf(char)]
          : char);
}

extension DoubleExtensions on double {

  String toStringMoneyFormat() {
    return "\$" + toStringAsFixed(2);
  }

  String toStringFormatted() {
    return NumberFormat("0.##").format(this);
  }
}