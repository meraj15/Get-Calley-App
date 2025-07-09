import '../model/language_model.dart';

class LanguageSelectorViewModel {
  final List<LanguageModel> languages = [
    LanguageModel(name: 'English', native: 'Hi'),
    LanguageModel(name: 'Hindi', native: 'नमस्ते'),
    LanguageModel(name: 'Bengali', native: 'হ্যালো'),
    LanguageModel(name: 'Kannada', native: 'ನಮಸ್ಕಾರ'),
    LanguageModel(name: 'Punjabi', native: 'ਸਤ ਸ੍ਰੀ ਅਕਾਲ'),
    LanguageModel(name: 'Tamil', native: 'வணக்கம்'),
    LanguageModel(name: 'Telugu', native: 'హలో'),
    LanguageModel(name: 'French', native: 'Bonjour'),
    LanguageModel(name: 'Spanish', native: 'Hola'),
  ];
}
