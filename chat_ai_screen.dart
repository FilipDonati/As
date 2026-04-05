import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ScreenChatAI extends StatefulWidget {
  const ScreenChatAI({super.key});

  @override
  State<ScreenChatAI> createState() => _ScreenChatAIState();
}

class _ScreenChatAIState extends State<ScreenChatAI> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;
  int _messageCount = 0;
  final int _maxTrialMessages = 10;
  String _selectedLanguage = 'it';

  // Mappa completa delle 26 lingue europee con traduzioni
  final Map<String, Map<String, dynamic>> _languages = {
    'en': {
      'name': 'English',
      'flag': '🇬🇧',
      'translations': {
        'welcome': 'Hello! 👋 I\'m your multilingual AI assistant. In Trial you can send up to {count} messages. How can I help you today?',
        'writeMessage': 'Write a message...',
        'limitReached': 'Limit reached - Upgrade to continue',
        'upgradeDialogTitle': 'Limit Reached',
        'upgradeMessage': 'You\'ve reached the limit of {count} messages in the Trial version.',
        'premiumFeatures': 'With Premium you get',
        'unlimitedMessages': 'Unlimited messages',
        'multilingualAI': 'AI personalized for each language',
        'realTimeCorrections': 'Real-time corrections',
        'progressAnalysis': 'Progress analysis',
        'targetedExercises': 'Targeted exercises',
        'upgradeToPremium': 'UPGRADE TO PREMIUM',
        'continueTrial': 'Continue with Trial',
        'messagesRemaining': '{count} messages remaining',
        'aiResponses': {
          'greeting': 'Hello! 😊 How are you? Want to practice a conversation in a specific language?',
          'howAreYou': 'I\'m doing great, thank you! 🌟 I\'m here to help you practice languages.',
          'help': 'I can help you practice conversations in 26 languages! 📚',
          'thanks': 'You\'re welcome! 😊 You have {count} messages left!',
          'generic': [
            'Interesting! 🤔 You have {count} Trial messages remaining.',
            'I understand! 💡 With Premium you could have unlimited conversations!',
          ],
        },
      },
    },
    'it': {
      'name': 'Italiano',
      'flag': '🇮🇹',
      'translations': {
        'welcome': 'Ciao! 👋 Sono il tuo assistente AI multilingua. Nella versione Trial puoi inviare fino a {count} messaggi. Come posso aiutarti oggi?',
        'writeMessage': 'Scrivi un messaggio...',
        'limitReached': 'Limite raggiunto - Upgrade per continuare',
        'upgradeDialogTitle': 'Limite Raggiunto',
        'upgradeMessage': 'Hai raggiunto il limite di {count} messaggi nella versione Trial.',
        'premiumFeatures': 'Con Premium ottieni',
        'unlimitedMessages': 'Messaggi illimitati',
        'multilingualAI': 'AI personalizzata per ogni lingua',
        'realTimeCorrections': 'Correzioni in tempo reale',
        'progressAnalysis': 'Analisi progressi',
        'targetedExercises': 'Esercizi mirati',
        'upgradeToPremium': 'PASSA A PREMIUM',
        'continueTrial': 'Continua con Trial',
        'messagesRemaining': '{count} messaggi rimanenti',
        'aiResponses': {
          'greeting': 'Ciao! 😊 Come stai? Vuoi esercitarti con una conversazione in una lingua specifica?',
          'howAreYou': 'Sto benissimo, grazie! 🌟 Sono qui per aiutarti a praticare le lingue.',
          'help': 'Posso aiutarti a praticare conversazioni in 26 lingue! 📚',
          'thanks': 'Prego! 😊 Hai ancora {count} messaggi disponibili!',
          'generic': [
            'Interessante! 🤔 Hai ancora {count} messaggi Trial disponibili.',
            'Capisco! 💡 Con Premium potresti avere conversazioni illimitate!',
          ],
        },
      },
    },
    'de': {
      'name': 'Deutsch',
      'flag': '🇩🇪',
      'translations': {
        'welcome': '🇩🇪 Welcome! You can send up to {count} messages.',
        'writeMessage': 'Write message...',
        'limitReached': 'Limit reached',
        'upgradeDialogTitle': 'Limit Reached',
        'upgradeMessage': 'Limit of {count} messages reached.',
        'premiumFeatures': 'Premium Features',
        'unlimitedMessages': 'Unlimited messages',
        'multilingualAI': 'AI for each language',
        'realTimeCorrections': 'Real-time corrections',
        'progressAnalysis': 'Progress analysis',
        'targetedExercises': 'Targeted exercises',
        'upgradeToPremium': 'UPGRADE TO PREMIUM',
        'continueTrial': 'Continue Trial',
        'messagesRemaining': '{count} messages left',
        'aiResponses': {
          'greeting': 'Hello! 😊 How can I help?',
          'howAreYou': 'Great! 🌟',
          'help': 'I support 26 languages! 📚',
          'thanks': 'Welcome! 😊 {count} messages left!',
          'generic': [
            'Interesting! 🤔 {count} messages left.',
            'With Premium: unlimited! 💡',
          ],
        },
      },
    },
    'es': {
      'name': 'Español',
      'flag': '🇪🇸',
      'translations': {
        'welcome': '🇪🇸 Welcome! You can send up to {count} messages.',
        'writeMessage': 'Write message...',
        'limitReached': 'Limit reached',
        'upgradeDialogTitle': 'Limit Reached',
        'upgradeMessage': 'Limit of {count} messages reached.',
        'premiumFeatures': 'Premium Features',
        'unlimitedMessages': 'Unlimited messages',
        'multilingualAI': 'AI for each language',
        'realTimeCorrections': 'Real-time corrections',
        'progressAnalysis': 'Progress analysis',
        'targetedExercises': 'Targeted exercises',
        'upgradeToPremium': 'UPGRADE TO PREMIUM',
        'continueTrial': 'Continue Trial',
        'messagesRemaining': '{count} messages left',
        'aiResponses': {
          'greeting': 'Hello! 😊 How can I help?',
          'howAreYou': 'Great! 🌟',
          'help': 'I support 26 languages! 📚',
          'thanks': 'Welcome! 😊 {count} messages left!',
          'generic': [
            'Interesting! 🤔 {count} messages left.',
            'With Premium: unlimited! 💡',
          ],
        },
      },
    },
    'fr': {
      'name': 'Français',
      'flag': '🇫🇷',
      'translations': {
        'welcome': '🇫🇷 Welcome! You can send up to {count} messages.',
        'writeMessage': 'Write message...',
        'limitReached': 'Limit reached',
        'upgradeDialogTitle': 'Limit Reached',
        'upgradeMessage': 'Limit of {count} messages reached.',
        'premiumFeatures': 'Premium Features',
        'unlimitedMessages': 'Unlimited messages',
        'multilingualAI': 'AI for each language',
        'realTimeCorrections': 'Real-time corrections',
        'progressAnalysis': 'Progress analysis',
        'targetedExercises': 'Targeted exercises',
        'upgradeToPremium': 'UPGRADE TO PREMIUM',
        'continueTrial': 'Continue Trial',
        'messagesRemaining': '{count} messages left',
        'aiResponses': {
          'greeting': 'Hello! 😊 How can I help?',
          'howAreYou': 'Great! 🌟',
          'help': 'I support 26 languages! 📚',
          'thanks': 'Welcome! 😊 {count} messages left!',
          'generic': [
            'Interesting! 🤔 {count} messages left.',
            'With Premium: unlimited! 💡',
          ],
        },
      },
    },
    'ru': {
      'name': 'Русский',
      'flag': '🇷🇺',
      'translations': {
        'welcome': '🇷🇺 Welcome! You can send up to {count} messages.',
        'writeMessage': 'Write message...',
        'limitReached': 'Limit reached',
        'upgradeDialogTitle': 'Limit Reached',
        'upgradeMessage': 'Limit of {count} messages reached.',
        'premiumFeatures': 'Premium Features',
        'unlimitedMessages': 'Unlimited messages',
        'multilingualAI': 'AI for each language',
        'realTimeCorrections': 'Real-time corrections',
        'progressAnalysis': 'Progress analysis',
        'targetedExercises': 'Targeted exercises',
        'upgradeToPremium': 'UPGRADE TO PREMIUM',
        'continueTrial': 'Continue Trial',
        'messagesRemaining': '{count} messages left',
        'aiResponses': {
          'greeting': 'Hello! 😊 How can I help?',
          'howAreYou': 'Great! 🌟',
          'help': 'I support 26 languages! 📚',
          'thanks': 'Welcome! 😊 {count} messages left!',
          'generic': [
            'Interesting! 🤔 {count} messages left.',
            'With Premium: unlimited! 💡',
          ],
        },
      },
    },
    'zh': {
      'name': '中文',
      'flag': '🇨🇳',
      'translations': {
        'welcome': '🇨🇳 Welcome! You can send up to {count} messages.',
        'writeMessage': 'Write message...',
        'limitReached': 'Limit reached',
        'upgradeDialogTitle': 'Limit Reached',
        'upgradeMessage': 'Limit of {count} messages reached.',
        'premiumFeatures': 'Premium Features',
        'unlimitedMessages': 'Unlimited messages',
        'multilingualAI': 'AI for each language',
        'realTimeCorrections': 'Real-time corrections',
        'progressAnalysis': 'Progress analysis',
        'targetedExercises': 'Targeted exercises',
        'upgradeToPremium': 'UPGRADE TO PREMIUM',
        'continueTrial': 'Continue Trial',
        'messagesRemaining': '{count} messages left',
        'aiResponses': {
          'greeting': 'Hello! 😊 How can I help?',
          'howAreYou': 'Great! 🌟',
          'help': 'I support 26 languages! 📚',
          'thanks': 'Welcome! 😊 {count} messages left!',
          'generic': [
            'Interesting! 🤔 {count} messages left.',
            'With Premium: unlimited! 💡',
          ],
        },
      },
    },
    'bg': {
      'name': 'Български',
      'flag': '🇧🇬',
      'translations': {
        'welcome': '🇧🇬 Welcome! You can send up to {count} messages.',
        'writeMessage': 'Write message...',
        'limitReached': 'Limit reached',
        'upgradeDialogTitle': 'Limit Reached',
        'upgradeMessage': 'Limit of {count} messages reached.',
        'premiumFeatures': 'Premium Features',
        'unlimitedMessages': 'Unlimited messages',
        'multilingualAI': 'AI for each language',
        'realTimeCorrections': 'Real-time corrections',
        'progressAnalysis': 'Progress analysis',
        'targetedExercises': 'Targeted exercises',
        'upgradeToPremium': 'UPGRADE TO PREMIUM',
        'continueTrial': 'Continue Trial',
        'messagesRemaining': '{count} messages left',
        'aiResponses': {
          'greeting': 'Hello! 😊 How can I help?',
          'howAreYou': 'Great! 🌟',
          'help': 'I support 26 languages! 📚',
          'thanks': 'Welcome! 😊 {count} messages left!',
          'generic': [
            'Interesting! 🤔 {count} messages left.',
            'With Premium: unlimited! 💡',
          ],
        },
      },
    },
    'cs': {
      'name': 'Čeština',
      'flag': '🇨🇿',
      'translations': {
        'welcome': '🇨🇿 Welcome! You can send up to {count} messages.',
        'writeMessage': 'Write message...',
        'limitReached': 'Limit reached',
        'upgradeDialogTitle': 'Limit Reached',
        'upgradeMessage': 'Limit of {count} messages reached.',
        'premiumFeatures': 'Premium Features',
        'unlimitedMessages': 'Unlimited messages',
        'multilingualAI': 'AI for each language',
        'realTimeCorrections': 'Real-time corrections',
        'progressAnalysis': 'Progress analysis',
        'targetedExercises': 'Targeted exercises',
        'upgradeToPremium': 'UPGRADE TO PREMIUM',
        'continueTrial': 'Continue Trial',
        'messagesRemaining': '{count} messages left',
        'aiResponses': {
          'greeting': 'Hello! 😊 How can I help?',
          'howAreYou': 'Great! 🌟',
          'help': 'I support 26 languages! 📚',
          'thanks': 'Welcome! 😊 {count} messages left!',
          'generic': [
            'Interesting! 🤔 {count} messages left.',
            'With Premium: unlimited! 💡',
          ],
        },
      },
    },
    'da': {
      'name': 'Dansk',
      'flag': '🇩🇰',
      'translations': {
        'welcome': '🇩🇰 Welcome! You can send up to {count} messages.',
        'writeMessage': 'Write message...',
        'limitReached': 'Limit reached',
        'upgradeDialogTitle': 'Limit Reached',
        'upgradeMessage': 'Limit of {count} messages reached.',
        'premiumFeatures': 'Premium Features',
        'unlimitedMessages': 'Unlimited messages',
        'multilingualAI': 'AI for each language',
        'realTimeCorrections': 'Real-time corrections',
        'progressAnalysis': 'Progress analysis',
        'targetedExercises': 'Targeted exercises',
        'upgradeToPremium': 'UPGRADE TO PREMIUM',
        'continueTrial': 'Continue Trial',
        'messagesRemaining': '{count} messages left',
        'aiResponses': {
          'greeting': 'Hello! 😊 How can I help?',
          'howAreYou': 'Great! 🌟',
          'help': 'I support 26 languages! 📚',
          'thanks': 'Welcome! 😊 {count} messages left!',
          'generic': [
            'Interesting! 🤔 {count} messages left.',
            'With Premium: unlimited! 💡',
          ],
        },
      },
    },
    'nl': {
      'name': 'Nederlands',
      'flag': '🇳🇱',
      'translations': {
        'welcome': '🇳🇱 Welcome! You can send up to {count} messages.',
        'writeMessage': 'Write message...',
        'limitReached': 'Limit reached',
        'upgradeDialogTitle': 'Limit Reached',
        'upgradeMessage': 'Limit of {count} messages reached.',
        'premiumFeatures': 'Premium Features',
        'unlimitedMessages': 'Unlimited messages',
        'multilingualAI': 'AI for each language',
        'realTimeCorrections': 'Real-time corrections',
        'progressAnalysis': 'Progress analysis',
        'targetedExercises': 'Targeted exercises',
        'upgradeToPremium': 'UPGRADE TO PREMIUM',
        'continueTrial': 'Continue Trial',
        'messagesRemaining': '{count} messages left',
        'aiResponses': {
          'greeting': 'Hello! 😊 How can I help?',
          'howAreYou': 'Great! 🌟',
          'help': 'I support 26 languages! 📚',
          'thanks': 'Welcome! 😊 {count} messages left!',
          'generic': [
            'Interesting! 🤔 {count} messages left.',
            'With Premium: unlimited! 💡',
          ],
        },
      },
    },
    'et': {
      'name': 'Eesti',
      'flag': '🇪🇪',
      'translations': {
        'welcome': '🇪🇪 Welcome! You can send up to {count} messages.',
        'writeMessage': 'Write message...',
        'limitReached': 'Limit reached',
        'upgradeDialogTitle': 'Limit Reached',
        'upgradeMessage': 'Limit of {count} messages reached.',
        'premiumFeatures': 'Premium Features',
        'unlimitedMessages': 'Unlimited messages',
        'multilingualAI': 'AI for each language',
        'realTimeCorrections': 'Real-time corrections',
        'progressAnalysis': 'Progress analysis',
        'targetedExercises': 'Targeted exercises',
        'upgradeToPremium': 'UPGRADE TO PREMIUM',
        'continueTrial': 'Continue Trial',
        'messagesRemaining': '{count} messages left',
        'aiResponses': {
          'greeting': 'Hello! 😊 How can I help?',
          'howAreYou': 'Great! 🌟',
          'help': 'I support 26 languages! 📚',
          'thanks': 'Welcome! 😊 {count} messages left!',
          'generic': [
            'Interesting! 🤔 {count} messages left.',
            'With Premium: unlimited! 💡',
          ],
        },
      },
    },
    'fi': {
      'name': 'Suomi',
      'flag': '🇫🇮',
      'translations': {
        'welcome': '🇫🇮 Welcome! You can send up to {count} messages.',
        'writeMessage': 'Write message...',
        'limitReached': 'Limit reached',
        'upgradeDialogTitle': 'Limit Reached',
        'upgradeMessage': 'Limit of {count} messages reached.',
        'premiumFeatures': 'Premium Features',
        'unlimitedMessages': 'Unlimited messages',
        'multilingualAI': 'AI for each language',
        'realTimeCorrections': 'Real-time corrections',
        'progressAnalysis': 'Progress analysis',
        'targetedExercises': 'Targeted exercises',
        'upgradeToPremium': 'UPGRADE TO PREMIUM',
        'continueTrial': 'Continue Trial',
        'messagesRemaining': '{count} messages left',
        'aiResponses': {
          'greeting': 'Hello! 😊 How can I help?',
          'howAreYou': 'Great! 🌟',
          'help': 'I support 26 languages! 📚',
          'thanks': 'Welcome! 😊 {count} messages left!',
          'generic': [
            'Interesting! 🤔 {count} messages left.',
            'With Premium: unlimited! 💡',
          ],
        },
      },
    },
    'el': {
      'name': 'Ελληνικά',
      'flag': '🇬🇷',
      'translations': {
        'welcome': '🇬🇷 Welcome! You can send up to {count} messages.',
        'writeMessage': 'Write message...',
        'limitReached': 'Limit reached',
        'upgradeDialogTitle': 'Limit Reached',
        'upgradeMessage': 'Limit of {count} messages reached.',
        'premiumFeatures': 'Premium Features',
        'unlimitedMessages': 'Unlimited messages',
        'multilingualAI': 'AI for each language',
        'realTimeCorrections': 'Real-time corrections',
        'progressAnalysis': 'Progress analysis',
        'targetedExercises': 'Targeted exercises',
        'upgradeToPremium': 'UPGRADE TO PREMIUM',
        'continueTrial': 'Continue Trial',
        'messagesRemaining': '{count} messages left',
        'aiResponses': {
          'greeting': 'Hello! 😊 How can I help?',
          'howAreYou': 'Great! 🌟',
          'help': 'I support 26 languages! 📚',
          'thanks': 'Welcome! 😊 {count} messages left!',
          'generic': [
            'Interesting! 🤔 {count} messages left.',
            'With Premium: unlimited! 💡',
          ],
        },
      },
    },
    'hu': {
      'name': 'Magyar',
      'flag': '🇭🇺',
      'translations': {
        'welcome': '🇭🇺 Welcome! You can send up to {count} messages.',
        'writeMessage': 'Write message...',
        'limitReached': 'Limit reached',
        'upgradeDialogTitle': 'Limit Reached',
        'upgradeMessage': 'Limit of {count} messages reached.',
        'premiumFeatures': 'Premium Features',
        'unlimitedMessages': 'Unlimited messages',
        'multilingualAI': 'AI for each language',
        'realTimeCorrections': 'Real-time corrections',
        'progressAnalysis': 'Progress analysis',
        'targetedExercises': 'Targeted exercises',
        'upgradeToPremium': 'UPGRADE TO PREMIUM',
        'continueTrial': 'Continue Trial',
        'messagesRemaining': '{count} messages left',
        'aiResponses': {
          'greeting': 'Hello! 😊 How can I help?',
          'howAreYou': 'Great! 🌟',
          'help': 'I support 26 languages! 📚',
          'thanks': 'Welcome! 😊 {count} messages left!',
          'generic': [
            'Interesting! 🤔 {count} messages left.',
            'With Premium: unlimited! 💡',
          ],
        },
      },
    },
    'ga': {
      'name': 'Gaeilge',
      'flag': '🇮🇪',
      'translations': {
        'welcome': '🇮🇪 Welcome! You can send up to {count} messages.',
        'writeMessage': 'Write message...',
        'limitReached': 'Limit reached',
        'upgradeDialogTitle': 'Limit Reached',
        'upgradeMessage': 'Limit of {count} messages reached.',
        'premiumFeatures': 'Premium Features',
        'unlimitedMessages': 'Unlimited messages',
        'multilingualAI': 'AI for each language',
        'realTimeCorrections': 'Real-time corrections',
        'progressAnalysis': 'Progress analysis',
        'targetedExercises': 'Targeted exercises',
        'upgradeToPremium': 'UPGRADE TO PREMIUM',
        'continueTrial': 'Continue Trial',
        'messagesRemaining': '{count} messages left',
        'aiResponses': {
          'greeting': 'Hello! 😊 How can I help?',
          'howAreYou': 'Great! 🌟',
          'help': 'I support 26 languages! 📚',
          'thanks': 'Welcome! 😊 {count} messages left!',
          'generic': [
            'Interesting! 🤔 {count} messages left.',
            'With Premium: unlimited! 💡',
          ],
        },
      },
    },
    'lv': {
      'name': 'Latviešu',
      'flag': '🇱🇻',
      'translations': {
        'welcome': '🇱🇻 Welcome! You can send up to {count} messages.',
        'writeMessage': 'Write message...',
        'limitReached': 'Limit reached',
        'upgradeDialogTitle': 'Limit Reached',
        'upgradeMessage': 'Limit of {count} messages reached.',
        'premiumFeatures': 'Premium Features',
        'unlimitedMessages': 'Unlimited messages',
        'multilingualAI': 'AI for each language',
        'realTimeCorrections': 'Real-time corrections',
        'progressAnalysis': 'Progress analysis',
        'targetedExercises': 'Targeted exercises',
        'upgradeToPremium': 'UPGRADE TO PREMIUM',
        'continueTrial': 'Continue Trial',
        'messagesRemaining': '{count} messages left',
        'aiResponses': {
          'greeting': 'Hello! 😊 How can I help?',
          'howAreYou': 'Great! 🌟',
          'help': 'I support 26 languages! 📚',
          'thanks': 'Welcome! 😊 {count} messages left!',
          'generic': [
            'Interesting! 🤔 {count} messages left.',
            'With Premium: unlimited! 💡',
          ],
        },
      },
    },
    'lt': {
      'name': 'Lietuvių',
      'flag': '🇱🇹',
      'translations': {
        'welcome': '🇱🇹 Welcome! You can send up to {count} messages.',
        'writeMessage': 'Write message...',
        'limitReached': 'Limit reached',
        'upgradeDialogTitle': 'Limit Reached',
        'upgradeMessage': 'Limit of {count} messages reached.',
        'premiumFeatures': 'Premium Features',
        'unlimitedMessages': 'Unlimited messages',
        'multilingualAI': 'AI for each language',
        'realTimeCorrections': 'Real-time corrections',
        'progressAnalysis': 'Progress analysis',
        'targetedExercises': 'Targeted exercises',
        'upgradeToPremium': 'UPGRADE TO PREMIUM',
        'continueTrial': 'Continue Trial',
        'messagesRemaining': '{count} messages left',
        'aiResponses': {
          'greeting': 'Hello! 😊 How can I help?',
          'howAreYou': 'Great! 🌟',
          'help': 'I support 26 languages! 📚',
          'thanks': 'Welcome! 😊 {count} messages left!',
          'generic': [
            'Interesting! 🤔 {count} messages left.',
            'With Premium: unlimited! 💡',
          ],
        },
      },
    },
    'mt': {
      'name': 'Malti',
      'flag': '🇲🇹',
      'translations': {
        'welcome': '🇲🇹 Welcome! You can send up to {count} messages.',
        'writeMessage': 'Write message...',
        'limitReached': 'Limit reached',
        'upgradeDialogTitle': 'Limit Reached',
        'upgradeMessage': 'Limit of {count} messages reached.',
        'premiumFeatures': 'Premium Features',
        'unlimitedMessages': 'Unlimited messages',
        'multilingualAI': 'AI for each language',
        'realTimeCorrections': 'Real-time corrections',
        'progressAnalysis': 'Progress analysis',
        'targetedExercises': 'Targeted exercises',
        'upgradeToPremium': 'UPGRADE TO PREMIUM',
        'continueTrial': 'Continue Trial',
        'messagesRemaining': '{count} messages left',
        'aiResponses': {
          'greeting': 'Hello! 😊 How can I help?',
          'howAreYou': 'Great! 🌟',
          'help': 'I support 26 languages! 📚',
          'thanks': 'Welcome! 😊 {count} messages left!',
          'generic': [
            'Interesting! 🤔 {count} messages left.',
            'With Premium: unlimited! 💡',
          ],
        },
      },
    },
    'pl': {
      'name': 'Polski',
      'flag': '🇵🇱',
      'translations': {
        'welcome': '🇵🇱 Welcome! You can send up to {count} messages.',
        'writeMessage': 'Write message...',
        'limitReached': 'Limit reached',
        'upgradeDialogTitle': 'Limit Reached',
        'upgradeMessage': 'Limit of {count} messages reached.',
        'premiumFeatures': 'Premium Features',
        'unlimitedMessages': 'Unlimited messages',
        'multilingualAI': 'AI for each language',
        'realTimeCorrections': 'Real-time corrections',
        'progressAnalysis': 'Progress analysis',
        'targetedExercises': 'Targeted exercises',
        'upgradeToPremium': 'UPGRADE TO PREMIUM',
        'continueTrial': 'Continue Trial',
        'messagesRemaining': '{count} messages left',
        'aiResponses': {
          'greeting': 'Hello! 😊 How can I help?',
          'howAreYou': 'Great! 🌟',
          'help': 'I support 26 languages! 📚',
          'thanks': 'Welcome! 😊 {count} messages left!',
          'generic': [
            'Interesting! 🤔 {count} messages left.',
            'With Premium: unlimited! 💡',
          ],
        },
      },
    },
    'pt': {
      'name': 'Português',
      'flag': '🇵🇹',
      'translations': {
        'welcome': '🇵🇹 Welcome! You can send up to {count} messages.',
        'writeMessage': 'Write message...',
        'limitReached': 'Limit reached',
        'upgradeDialogTitle': 'Limit Reached',
        'upgradeMessage': 'Limit of {count} messages reached.',
        'premiumFeatures': 'Premium Features',
        'unlimitedMessages': 'Unlimited messages',
        'multilingualAI': 'AI for each language',
        'realTimeCorrections': 'Real-time corrections',
        'progressAnalysis': 'Progress analysis',
        'targetedExercises': 'Targeted exercises',
        'upgradeToPremium': 'UPGRADE TO PREMIUM',
        'continueTrial': 'Continue Trial',
        'messagesRemaining': '{count} messages left',
        'aiResponses': {
          'greeting': 'Hello! 😊 How can I help?',
          'howAreYou': 'Great! 🌟',
          'help': 'I support 26 languages! 📚',
          'thanks': 'Welcome! 😊 {count} messages left!',
          'generic': [
            'Interesting! 🤔 {count} messages left.',
            'With Premium: unlimited! 💡',
          ],
        },
      },
    },
    'ro': {
      'name': 'Română',
      'flag': '🇷🇴',
      'translations': {
        'welcome': '🇷🇴 Welcome! You can send up to {count} messages.',
        'writeMessage': 'Write message...',
        'limitReached': 'Limit reached',
        'upgradeDialogTitle': 'Limit Reached',
        'upgradeMessage': 'Limit of {count} messages reached.',
        'premiumFeatures': 'Premium Features',
        'unlimitedMessages': 'Unlimited messages',
        'multilingualAI': 'AI for each language',
        'realTimeCorrections': 'Real-time corrections',
        'progressAnalysis': 'Progress analysis',
        'targetedExercises': 'Targeted exercises',
        'upgradeToPremium': 'UPGRADE TO PREMIUM',
        'continueTrial': 'Continue Trial',
        'messagesRemaining': '{count} messages left',
        'aiResponses': {
          'greeting': 'Hello! 😊 How can I help?',
          'howAreYou': 'Great! 🌟',
          'help': 'I support 26 languages! 📚',
          'thanks': 'Welcome! 😊 {count} messages left!',
          'generic': [
            'Interesting! 🤔 {count} messages left.',
            'With Premium: unlimited! 💡',
          ],
        },
      },
    },
    'sk': {
      'name': 'Slovenčina',
      'flag': '🇸🇰',
      'translations': {
        'welcome': '🇸🇰 Welcome! You can send up to {count} messages.',
        'writeMessage': 'Write message...',
        'limitReached': 'Limit reached',
        'upgradeDialogTitle': 'Limit Reached',
        'upgradeMessage': 'Limit of {count} messages reached.',
        'premiumFeatures': 'Premium Features',
        'unlimitedMessages': 'Unlimited messages',
        'multilingualAI': 'AI for each language',
        'realTimeCorrections': 'Real-time corrections',
        'progressAnalysis': 'Progress analysis',
        'targetedExercises': 'Targeted exercises',
        'upgradeToPremium': 'UPGRADE TO PREMIUM',
        'continueTrial': 'Continue Trial',
        'messagesRemaining': '{count} messages left',
        'aiResponses': {
          'greeting': 'Hello! 😊 How can I help?',
          'howAreYou': 'Great! 🌟',
          'help': 'I support 26 languages! 📚',
          'thanks': 'Welcome! 😊 {count} messages left!',
          'generic': [
            'Interesting! 🤔 {count} messages left.',
            'With Premium: unlimited! 💡',
          ],
        },
      },
    },
    'sl': {
      'name': 'Slovenščina',
      'flag': '🇸🇮',
      'translations': {
        'welcome': '🇸🇮 Welcome! You can send up to {count} messages.',
        'writeMessage': 'Write message...',
        'limitReached': 'Limit reached',
        'upgradeDialogTitle': 'Limit Reached',
        'upgradeMessage': 'Limit of {count} messages reached.',
        'premiumFeatures': 'Premium Features',
        'unlimitedMessages': 'Unlimited messages',
        'multilingualAI': 'AI for each language',
        'realTimeCorrections': 'Real-time corrections',
        'progressAnalysis': 'Progress analysis',
        'targetedExercises': 'Targeted exercises',
        'upgradeToPremium': 'UPGRADE TO PREMIUM',
        'continueTrial': 'Continue Trial',
        'messagesRemaining': '{count} messages left',
        'aiResponses': {
          'greeting': 'Hello! 😊 How can I help?',
          'howAreYou': 'Great! 🌟',
          'help': 'I support 26 languages! 📚',
          'thanks': 'Welcome! 😊 {count} messages left!',
          'generic': [
            'Interesting! 🤔 {count} messages left.',
            'With Premium: unlimited! 💡',
          ],
        },
      },
    },
    'sv': {
      'name': 'Svenska',
      'flag': '🇸🇪',
      'translations': {
        'welcome': '🇸🇪 Welcome! You can send up to {count} messages.',
        'writeMessage': 'Write message...',
        'limitReached': 'Limit reached',
        'upgradeDialogTitle': 'Limit Reached',
        'upgradeMessage': 'Limit of {count} messages reached.',
        'premiumFeatures': 'Premium Features',
        'unlimitedMessages': 'Unlimited messages',
        'multilingualAI': 'AI for each language',
        'realTimeCorrections': 'Real-time corrections',
        'progressAnalysis': 'Progress analysis',
        'targetedExercises': 'Targeted exercises',
        'upgradeToPremium': 'UPGRADE TO PREMIUM',
        'continueTrial': 'Continue Trial',
        'messagesRemaining': '{count} messages left',
        'aiResponses': {
          'greeting': 'Hello! 😊 How can I help?',
          'howAreYou': 'Great! 🌟',
          'help': 'I support 26 languages! 📚',
          'thanks': 'Welcome! 😊 {count} messages left!',
          'generic': [
            'Interesting! 🤔 {count} messages left.',
            'With Premium: unlimited! 💡',
          ],
        },
      },
    },
    'hr': {
      'name': 'Hrvatski',
      'flag': '🇭🇷',
      'translations': {
        'welcome': '🇭🇷 Welcome! You can send up to {count} messages.',
        'writeMessage': 'Write message...',
        'limitReached': 'Limit reached',
        'upgradeDialogTitle': 'Limit Reached',
        'upgradeMessage': 'Limit of {count} messages reached.',
        'premiumFeatures': 'Premium Features',
        'unlimitedMessages': 'Unlimited messages',
        'multilingualAI': 'AI for each language',
        'realTimeCorrections': 'Real-time corrections',
        'progressAnalysis': 'Progress analysis',
        'targetedExercises': 'Targeted exercises',
        'upgradeToPremium': 'UPGRADE TO PREMIUM',
        'continueTrial': 'Continue Trial',
        'messagesRemaining': '{count} messages left',
        'aiResponses': {
          'greeting': 'Hello! 😊 How can I help?',
          'howAreYou': 'Great! 🌟',
          'help': 'I support 26 languages! 📚',
          'thanks': 'Welcome! 😊 {count} messages left!',
          'generic': [
            'Interesting! 🤔 {count} messages left.',
            'With Premium: unlimited! 💡',
          ],
        },
      },
    },
  };

  @override
  void initState() {
    super.initState();
    _detectSystemLanguage();
    _sendWelcomeMessage();
  }

  void _detectSystemLanguage() {
    final systemLocale = ui.window.locale.languageCode;
    if (_languages.containsKey(systemLocale)) {
      setState(() {
        _selectedLanguage = systemLocale;
      });
    } else {
      setState(() {
        _selectedLanguage = 'it';
      });
    }
  }

  String _t(String key) {
    final translations = _languages[_selectedLanguage]?['translations'] as Map<String, dynamic>?;
    if (translations == null) return key;
    
    final value = translations[key];
    if (value == null) return key;
    
    return value.toString().replaceAll('{count}', (_maxTrialMessages - _messageCount).toString());
  }

  void _sendWelcomeMessage() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _messages.add({
            'sender': 'ai',
            'message': _t('welcome'),
            'timestamp': DateTime.now(),
          });
        });
        _scrollToBottom();
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    
    if (message.isEmpty) return;
    
    if (_messageCount >= _maxTrialMessages) {
      _showUpgradeDialog();
      return;
    }

    setState(() {
      _messages.add({
        'sender': 'user',
        'message': message,
        'timestamp': DateTime.now(),
      });
      _messageCount++;
      _isTyping = true;
    });

    _messageController.clear();
    _scrollToBottom();
    
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _messages.add({
            'sender': 'ai',
            'message': _generateAIResponse(message),
            'timestamp': DateTime.now(),
          });
          _isTyping = false;
        });
        _scrollToBottom();
      }
    });
  }

  String _generateAIResponse(String userMessage) {
    final lowerMessage = userMessage.toLowerCase();
    final aiResponses = _languages[_selectedLanguage]?['translations']?['aiResponses'] as Map<String, dynamic>?;
    
    if (aiResponses == null) return 'Response not available';

    final greetings = ['ciao', 'salve', 'hello', 'hi', 'hej', 'hola', 'bonjour', 'hallo'];
    final howAreYouPhrases = ['come stai', 'come va', 'how are you', 'como estas'];
    final helpPhrases = ['aiuto', 'help', 'ayuda', 'hilfe', 'aide'];
    final thanksPhrases = ['grazie', 'thank', 'merci', 'danke'];
    
    if (greetings.any((g) => lowerMessage.contains(g))) {
      return (aiResponses['greeting'] as String? ?? '').replaceAll('{count}', (_maxTrialMessages - _messageCount).toString());
    }
    if (howAreYouPhrases.any((p) => lowerMessage.contains(p))) {
      return aiResponses['howAreYou'] as String? ?? '';
    }
    if (helpPhrases.any((p) => lowerMessage.contains(p))) {
      return aiResponses['help'] as String? ?? '';
    }
    if (thanksPhrases.any((p) => lowerMessage.contains(p))) {
      return (aiResponses['thanks'] as String? ?? '').replaceAll('{count}', (_maxTrialMessages - _messageCount).toString());
    }
    
    final genericResponses = aiResponses['generic'] as List<dynamic>?;
    if (genericResponses != null && genericResponses.isNotEmpty) {
      String response = genericResponses[_messageCount % genericResponses.length] as String;
      return response.replaceAll('{count}', (_maxTrialMessages - _messageCount).toString());
    }
    
    return 'Response not available';
  }

  void _showUpgradeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFFA06B), Color(0xFFFFD93D)],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.workspace_premium, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _t('upgradeDialogTitle'),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _t('upgradeMessage'),
                style: TextStyle(fontSize: 15, color: Colors.grey[700]),
              ),
              const SizedBox(height: 20),
              Text(
                _t('premiumFeatures'),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 12),
              _buildFeature(Icons.all_inclusive, _t('unlimitedMessages')),
              _buildFeature(Icons.translate, _t('multilingualAI')),
              _buildFeature(Icons.auto_fix_high, _t('realTimeCorrections')),
              _buildFeature(Icons.analytics, _t('progressAnalysis')),
              _buildFeature(Icons.fitness_center, _t('targetedExercises')),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(_t('continueTrial'), style: TextStyle(color: Colors.grey[600])),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7C3AED),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              _t('upgradeToPremium'),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeature(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF7C3AED)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 14, color: Colors.grey[800])),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Color(0xFF7C3AED), Color(0xFFA855F7)]),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.smart_toy, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('AI Chat', style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold)),
                Text(_t('messagesRemaining'), style: TextStyle(color: Colors.grey[600], fontSize: 11)),
              ],
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Text(_languages[_selectedLanguage]?['flag'] ?? '🌐', style: const TextStyle(fontSize: 24)),
            onSelected: (String languageCode) {
              setState(() {
                _selectedLanguage = languageCode;
                _messages.clear();
                _messageCount = 0;
                _sendWelcomeMessage();
              });
            },
            itemBuilder: (BuildContext context) {
              return _languages.entries.map((entry) {
                return PopupMenuItem<String>(
                  value: entry.key,
                  child: Row(
                    children: [
                      Text(entry.value['flag'], style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 12),
                      Text(entry.value['name']),
                    ],
                  ),
                );
              }).toList();
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? const Center(child: CircularProgressIndicator(color: Color(0xFF7C3AED)))
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length + (_isTyping ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == _messages.length && _isTyping) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(4),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildTypingDot(),
                                const SizedBox(width: 6),
                                _buildTypingDot(),
                                const SizedBox(width: 6),
                                _buildTypingDot(),
                              ],
                            ),
                          ),
                        );
                      }
                      
                      final message = _messages[index];
                      final isUser = message['sender'] == 'user';
                      
                      return Align(
                        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                          decoration: BoxDecoration(
                            gradient: isUser
                                ? const LinearGradient(colors: [Color(0xFF7C3AED), Color(0xFFA855F7)])
                                : null,
                            color: isUser ? null : Colors.grey[100],
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(20),
                              topRight: const Radius.circular(20),
                              bottomLeft: Radius.circular(isUser ? 20 : 4),
                              bottomRight: Radius.circular(isUser ? 4 : 20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isUser ? const Color(0xFF7C3AED).withOpacity(0.3) : Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Text(
                            message['message']!,
                            style: TextStyle(color: isUser ? Colors.white : Colors.black87, fontSize: 15, height: 1.4),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 10, offset: const Offset(0, -2))],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 120),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextField(
                        controller: _messageController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textCapitalization: TextCapitalization.sentences,
                        enabled: _messageCount < _maxTrialMessages,
                        style: const TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          hintText: _messageCount >= _maxTrialMessages
                              ? _t('limitReached')
                              : _t('writeMessage'),
                          hintStyle: TextStyle(fontSize: 14, color: Colors.grey[500]),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: _messageCount < _maxTrialMessages
                          ? const LinearGradient(colors: [Color(0xFF7C3AED), Color(0xFFA855F7)])
                          : LinearGradient(colors: [Colors.grey[400]!, Colors.grey[400]!]),
                      shape: BoxShape.circle,
                      boxShadow: _messageCount < _maxTrialMessages
                          ? [BoxShadow(color: const Color(0xFF7C3AED).withOpacity(0.3), blurRadius: 8, spreadRadius: 1)]
                          : [],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white, size: 22),
                      onPressed: _messageCount < _maxTrialMessages ? _sendMessage : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingDot() {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      builder: (context, double value, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: Colors.grey[400], shape: BoxShape.circle),
        );
      },
    );
  }
}