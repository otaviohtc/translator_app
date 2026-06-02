# Translator App

Uma aplicação Flutter moderna para tradução de textos e reconhecimento de voz com suporte a 9 idiomas diferentes.

*A modern Flutter application for text translation and voice recognition with support for 9 different languages.*

---

## Visão Geral / Overview

Este projeto demonstra a integração de dois conceitos fundamentais no desenvolvimento mobile moderno:

- **Tradução de Texto**: Utiliza a API do Google Translate via pacote `translator`
- **Reconhecimento de Voz**: Implementa speech-to-text com o pacote `speech_to_text`

This project demonstrates the integration of two fundamental concepts in modern mobile development:

- **Text Translation**: Uses Google Translate API through the `translator` package
- **Voice Recognition**: Implements speech-to-text with the `speech_to_text` package

---

## Recursos / Features

- Tradução em tempo real para 9 idiomas diferentes / Real-time translation for 9 different languages
- Reconhecimento de voz integrado / Integrated voice recognition
- Interface responsiva com Material Design 3 / Responsive interface with Material Design 3
- Suporte para múltiplas plataformas (Android, iOS, Web) / Multi-platform support (Android, iOS, Web)
- Tratamento robusto de erros / Robust error handling
- Interface clean e intuitiva / Clean and intuitive interface

### Idiomas Suportados / Supported Languages

| Idioma / Language | Código / Code |
|---|---|
| Português | pt |
| Inglês | en |
| Espanhol | es |
| Francês | fr |
| Alemão | de |
| Italiano | it |
| Grego | el |
| Japonês | ja |
| Russo | ru |

---

## Tópicos de Aprendizado / Learning Topics

Este projeto explora os seguintes conceitos principais:

### 1. Integração com APIs Externas
- Requisições HTTP assíncronas
- Tratamento de respostas de API
- Gerenciamento de erros de conectividade

### 2. Speech to Text (Reconhecimento de Voz)
- Inicialização e permissões de microfone
- Captura de áudio em tempo real
- Conversão de fala para texto

### 3. State Management
- StatefulWidget e setState()
- Lifecycle de widgets (initState, dispose)
- Gerenciamento de estado assíncrono

### 4. UI/UX com Flutter
- Material Design 3
- Layouts responsivos (GridView, Row, Column)
- Temas e esquemas de cores customizados

### 5. Tratamento de Erros e Exceções
- Try-catch em operações assíncronas
- Validação de entrada de usuário
- Feedback ao usuário com SnackBars

---

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  translator: ^0.1.7
  speech_to_text: ^7.0.0
```

---

## Como Usar / How to Use

### Pré-requisitos / Prerequisites

- Flutter SDK (^3.11.1)
- Dart SDK (incluído com Flutter)
- Um dispositivo ou emulador Android/iOS ou navegador web

### Instalação / Installation

```bash
# Clone o repositório
git clone <repository-url>

# Navegue para o diretório
cd translator_app

# Instale as dependências
flutter pub get

# Execute a aplicação
flutter run
```

### Uso da Aplicação / Application Usage

1. **Selecione um idioma**: Toque em um dos botões de idioma na grade
2. **Digite ou fale**: 
   - Digite o texto diretamente no campo de entrada, OU
   - Use o botão de microfone para falar o texto
3. **Obtenha a tradução**: O texto será traduzido automaticamente para o idioma selecionado

---

## Estrutura do Projeto / Project Structure

```
lib/
├── main.dart          # Ponto de entrada da aplicação
└── app.dart           # Widget principal e lógica da aplicação
```

### Componentes Principais / Main Components

- **GoogleTranslator**: Gerencia as requisições de tradução
- **SpeechToText**: Controla o reconhecimento de voz
- **TranslatorPage**: Interface principal da aplicação
- **Theme customizado**: Material Design 3 com cores Indigo

---

## Configuração Importante / Important Configuration

### Permissões de Microfone / Microphone Permissions

Para usar o reconhecimento de voz, certifique-se de que as permissões estão configuradas:

**Android** (`android/app/src/main/AndroidManifest.xml`):
```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.INTERNET" />
```

**iOS** (`ios/Runner/Info.plist`):
```xml
<key>NSMicrophoneUsageDescription</key>
<string>Este aplicativo precisa de acesso ao microfone para reconhecimento de voz</string>
```

---

## Limitações / Limitations

- Speech-to-text não é suportado em navegadores web
- Requer conexão com internet para tradução
- Idioma de reconhecimento de voz fixado em português (pt_BR)

---

## Recursos para Aprendizado / Learning Resources

- [Flutter Documentation](https://docs.flutter.dev)
- [Translator Package](https://pub.dev/packages/translator)
- [Speech to Text Package](https://pub.dev/packages/speech_to_text)
- [Material Design 3 in Flutter](https://docs.flutter.dev/ui/design-systems/material-3)

---

## Licença / License

Este projeto é de código aberto e disponível sob a licença MIT.

This project is open source and available under the MIT License.
