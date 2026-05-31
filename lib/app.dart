import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:translator/translator.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Translator App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const TranslatorPage(),
    );
  }
}

class TranslatorPage extends StatefulWidget {
  const TranslatorPage({super.key});

  @override
  State<TranslatorPage> createState() => _TranslatorPageState();
}

class _TranslatorPageState extends State<TranslatorPage> {
  final TextEditingController _textController = TextEditingController();
  String _translatedText = '';
  bool _isLoading = false;
  bool _isListening = false;

  final GoogleTranslator _translator = GoogleTranslator();
  late stt.SpeechToText _speechToText;

  @override
  void initState() {
    super.initState();
    _speechToText = stt.SpeechToText();
  }

  Future<void> _translate(String languageCode) async {
    if (_textController.text.isEmpty) {
      setState(() {
        _translatedText = '';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _translatedText = '';
    });

    try {
      var translation = await _translator.translate(
        _textController.text,
        from: 'auto',
        to: languageCode,
      );
      
      setState(() {
        _translatedText = translation.text;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _translatedText = 'Error: $e';
        _isLoading = false;
      });
      print('Translation error: $e');
    }
  }

  Future<void> _startListening() async {
    if (kIsWeb) {
      print('Speech to text is not supported on web');
      return;
    }
    
    if (!_isListening) {
      bool available = await _speechToText.initialize(
        onError: (error) => print('Error: $error'),
        onStatus: (status) => print('Status: $status'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speechToText.listen(
          onResult: (result) {
            setState(() {
              _textController.text = result.recognizedWords;
            });
          },
          localeId: 'en_US',
        );
      }
    } else {
      setState(() => _isListening = false);
      _speechToText.stop();
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    if (!kIsWeb) {
      _speechToText.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translator App'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Flag buttons - Row 1
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildFlagButton('Spain', '🇪🇸', 'es'),
                  _buildFlagButton('France', '🇫🇷', 'fr'),
                  _buildFlagButton('USA', '🇺🇸', 'en'),
                ],
              ),
              const SizedBox(height: 16),
              // Flag buttons - Row 2
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildFlagButton('Brazil', '🇧🇷', 'pt'),
                  _buildFlagButton('Germany', '🇩🇪', 'de'),
                  _buildFlagButton('Italy', '🇮🇹', 'it'),
                ],
              ),
              const SizedBox(height: 40),
              // Text input field with mic button
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Insira o texto que deseje traduzir',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                      maxLines: 3,
                    ),
                  ),
                  const SizedBox(width: 12),
                  if (!kIsWeb)
                    FloatingActionButton(
                      onPressed: _startListening,
                      backgroundColor: _isListening ? Colors.red : Colors.blue,
                      child: Icon(_isListening ? Icons.mic : Icons.mic_none),
                    ),
                ],
              ),
              const SizedBox(height: 40),
              // Translated text display
              if (_isLoading)
                const CircularProgressIndicator()
              else if (_translatedText.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Traduzido:',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _translatedText,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFlagButton(String country, String flag, String languageCode) {
    return ElevatedButton(
      onPressed: () => _translate(languageCode),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            flag,
            style: const TextStyle(fontSize: 32),
          ),
          const SizedBox(height: 4),
          Text(country),
        ],
      ),
    );
  }
}
