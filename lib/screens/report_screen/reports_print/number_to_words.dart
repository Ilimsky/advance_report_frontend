// number_to_words.dart

/// Преобразует числовое значение в пропись
String numberToWords(String amount) {
  try {
    // Парсим число (учитываем, что может быть с дробной частью)
    double number = double.parse(amount.replaceAll(',', '.'));

    // Разделяем на целую и дробную части
    int integerPart = number.floor();
    int fractionalPart = ((number - integerPart) * 100).round();

    // Преобразуем целую часть
    String integerWords = _convertNumberToWords(integerPart);

    // Добавляем валюту с правильным склонением
    String currency = _getCurrencyWord(integerPart);

    String result = '$integerWords $currency';

    // Добавляем тыйыны если есть
    if (fractionalPart > 0) {
      String fractionalWords = _convertNumberToWords(fractionalPart);
      String coins = _getCoinsWord(fractionalPart);
      result += ' $fractionalWords $coins';
    } else {
      result += ' 00 тыйын';
    }

    // Делаем первую букву заглавной
    if (result.isNotEmpty) {
      result = result[0].toUpperCase() + result.substring(1);
    }

    return result;
  } catch (e) {
    // В случае ошибки возвращаем исходное значение
    return amount;
  }
}

/// Функция для склонения слова "сом"
String _getCurrencyWord(int number) {
  int lastDigit = number % 10;
  int lastTwoDigits = number % 100;

  if (lastTwoDigits >= 11 && lastTwoDigits <= 19) {
    return 'сом';
  }

  switch (lastDigit) {
    case 1:
      return 'сом,';
    case 2:
    case 3:
    case 4:
      return 'сом,';
    default:
      return 'сом,';
  }
}

/// Функция для склонения слова "тыйын"
String _getCoinsWord(int number) {
  int lastDigit = number % 10;
  int lastTwoDigits = number % 100;

  if (lastTwoDigits >= 11 && lastTwoDigits <= 19) {
    return 'тыйын';
  }

  switch (lastDigit) {
    case 1:
      return 'тыйын';
    case 2:
    case 3:
    case 4:
      return 'тыйын';
    default:
      return 'тыйын';
  }
}

/// Основная функция преобразования числа в слова
String _convertNumberToWords(int number) {
  if (number == 0) {
    return 'ноль';
  }

  List<String> units = [
    '', 'один', 'два', 'три', 'четыре', 'пять', 'шесть', 'семь', 'восемь', 'девять',
    'десять', 'одиннадцать', 'двенадцать', 'тринадцать', 'четырнадцать',
    'пятнадцать', 'шестнадцать', 'семнадцать', 'восемнадцать', 'девятнадцать'
  ];

  List<String> tens = [
    '', '', 'двадцать', 'тридцать', 'сорок', 'пятьдесят',
    'шестьдесят', 'семьдесят', 'восемьдесят', 'девяносто'
  ];

  List<String> hundreds = [
    '', 'сто', 'двести', 'триста', 'четыреста', 'пятьсот',
    'шестьсот', 'семьсот', 'восемьсот', 'девятьсот'
  ];

  List<String> thousands = ['', 'тысяча', 'тысячи', 'тысяч'];
  List<String> millions = ['', 'миллион', 'миллиона', 'миллионов'];

  String words = '';

  // Миллионы
  if (number >= 1000000) {
    int millionsPart = number ~/ 1000000;
    words += _convertNumberToWords(millionsPart) + ' ' + _getForm(millionsPart, millions) + ' ';
    number %= 1000000;
  }

  // Тысячи
  if (number >= 1000) {
    int thousandsPart = number ~/ 1000;
    words += _convertSmallNumberToWords(thousandsPart, true) + ' ' + _getForm(thousandsPart, thousands) + ' ';
    number %= 1000;
  }

  // Сотни, десятки и единицы
  if (number > 0) {
    words += _convertSmallNumberToWords(number, false);
  }

  return words.trim();
}

/// Функция для преобразования чисел до 1000
String _convertSmallNumberToWords(int number, bool isFemale) {
  List<String> units = [
    '', 'один', 'два', 'три', 'четыре', 'пять', 'шесть', 'семь', 'восемь', 'девять'
  ];

  List<String> unitsFemale = [
    '', 'одна', 'две', 'три', 'четыре', 'пять', 'шесть', 'семь', 'восемь', 'девять'
  ];

  List<String> teens = [
    'десять', 'одиннадцать', 'двенадцать', 'тринадцать', 'четырнадцать',
    'пятнадцать', 'шестнадцать', 'семнадцать', 'восемнадцать', 'девятнадцать'
  ];

  List<String> tens = [
    '', '', 'двадцать', 'тридцать', 'сорок', 'пятьдесят',
    'шестьдесят', 'семьдесят', 'восемьдесят', 'девяносто'
  ];

  List<String> hundreds = [
    '', 'сто', 'двести', 'триста', 'четыреста', 'пятьсот',
    'шестьсот', 'семьсот', 'восемьсот', 'девятьсот'
  ];

  String words = '';

  // Сотни
  if (number >= 100) {
    words += hundreds[number ~/ 100] + ' ';
    number %= 100;
  }

  // Десятки и единицы
  if (number >= 20) {
    words += tens[number ~/ 10] + ' ';
    number %= 10;
    if (number > 0) {
      words += (isFemale ? unitsFemale[number] : units[number]) + ' ';
    }
  } else if (number >= 10) {
    words += teens[number - 10] + ' ';
  } else if (number > 0) {
    words += (isFemale ? unitsFemale[number] : units[number]) + ' ';
  }

  return words;
}

/// Функция для получения правильной формы слова (падеж)
String _getForm(int number, List<String> forms) {
  int lastDigit = number % 10;
  int lastTwoDigits = number % 100;

  if (lastTwoDigits >= 11 && lastTwoDigits <= 19) {
    return forms[3];
  }

  switch (lastDigit) {
    case 1:
      return forms[1];
    case 2:
    case 3:
    case 4:
      return forms[2];
    default:
      return forms[3];
  }
}