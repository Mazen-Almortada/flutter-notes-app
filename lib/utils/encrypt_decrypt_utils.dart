import 'dart:convert';

class Crypto {
  static String encryptText(String text, String key) {
    final keyBytes = utf8.encode(key);
    final textBytes = utf8.encode(text);
    final encryptedBytes = List<int>.generate(textBytes.length, (i) {
      return textBytes[i] ^ keyBytes[i % keyBytes.length];
    });
    return base64Encode(encryptedBytes);
  }

  static String decryptText(String encryptedText, String key) {
    final keyBytes = utf8.encode(key);
    final encryptedBytes = base64Decode(encryptedText);
    final decryptedBytes = List<int>.generate(encryptedBytes.length, (i) {
      return encryptedBytes[i] ^ keyBytes[i % keyBytes.length];
    });
    return utf8.decode(decryptedBytes);
  }
}
