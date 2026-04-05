import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../controller/auth_controller.dart';
import '../../controller/user_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _displayNameController;
  late TextEditingController _bioController;
  late TextEditingController _phonePrefixController;
  late TextEditingController _phoneNumberController;

  String? _selectedNationality;
  String? _selectedLanguage;
  DateTime? _selectedDateOfBirth;

  bool _controllersInitialized = false;

  final List<String> _languages = [
    'en', 'it', 'es', 'fr', 'de', 'pt', 'ru', 'zh', 'ja', 'ar'
  ];

  final Map<String, String> _languageNames = {
    'en': 'English',
    'it': 'Italiano',
    'es': 'Español',
    'fr': 'Français',
    'de': 'Deutsch',
    'pt': 'Português',
    'ru': 'Русский',
    'zh': '中文',
    'ja': '日本語',
    'ar': 'العربية',
  };

  final List<String> _countries = [
    'IT', 'US', 'GB', 'FR', 'DE', 'ES', 'PT', 'BR', 'RU', 'CN', 'JP', 'IN'
  ];

  final Map<String, String> _countryNames = {
    'IT': 'Italia',
    'US': 'United States',
    'GB': 'United Kingdom',
    'FR': 'France',
    'DE': 'Germany',
    'ES': 'Spain',
    'PT': 'Portugal',
    'BR': 'Brazil',
    'RU': 'Russia',
    'CN': 'China',
    'JP': 'Japan',
    'IN': 'India',
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_controllersInitialized) {
      _controllersInitialized = true;
      final authController =
          Provider.of<AuthController>(context, listen: false);
      final user = authController.currentUser!;
      _displayNameController =
          TextEditingController(text: user.displayName);
      _bioController = TextEditingController(text: user.bio);
      _phonePrefixController =
          TextEditingController(text: user.phonePrefix);
      _phoneNumberController =
          TextEditingController(text: user.phoneNumber);
      _selectedNationality = user.nationality;
      _selectedLanguage = user.selectedLanguage;
      _selectedDateOfBirth = user.dateOfBirth;
    }
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _bioController.dispose();
    _phonePrefixController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateOfBirth ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDateOfBirth) {
      setState(() {
        _selectedDateOfBirth = picked;
      });
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      await context.read<UserController>().updateProfile(
            displayName: _displayNameController.text.trim().isEmpty
                ? null
                : _displayNameController.text.trim(),
            bio: _bioController.text.trim().isEmpty
                ? null
                : _bioController.text.trim(),
            phonePrefix: _phonePrefixController.text.trim().isEmpty
                ? null
                : _phonePrefixController.text.trim(),
            phoneNumber: _phoneNumberController.text.trim().isEmpty
                ? null
                : _phoneNumberController.text.trim(),
            nationality: _selectedNationality,
            selectedLanguage: _selectedLanguage,
            dateOfBirth: _selectedDateOfBirth,
          );
      if (!mounted) return;
    }
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Elimina Account'),
        content: const Text(
          'Sei sicuro di voler eliminare il tuo account? Questa azione è irreversibile.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Annulla'),
          ),
          TextButton(
            onPressed: () {
              // Implementa eliminazione account
              Navigator.pop(ctx);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Elimina'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authController =
        Provider.of<AuthController>(context, listen: false);
    final userController = Provider.of<UserController>(context);
    final user = authController.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifica Profilo'),
        actions: [
          TextButton(
            onPressed: userController.isLoading ? null : _saveProfile,
            child: userController.isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text(
                    'Salva',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Display Name
            TextFormField(
              controller: _displayNameController,
              decoration: const InputDecoration(
                labelText: 'Nome visualizzato',
                hintText: 'Il tuo nome',
                prefixIcon: Icon(Icons.person_outline),
              ),
              maxLength: 100,
            ),
            const SizedBox(height: 16),

            // Bio
            TextFormField(
              controller: _bioController,
              decoration: const InputDecoration(
                labelText: 'Bio',
                hintText: 'Raccontaci qualcosa di te',
                prefixIcon: Icon(Icons.description_outlined),
              ),
              maxLines: 4,
              maxLength: 500,
            ),
            const SizedBox(height: 16),

            // Data di nascita
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.cake_outlined),
              title: const Text('Data di nascita'),
              subtitle: Text(
                _selectedDateOfBirth != null
                    ? DateFormat('dd/MM/yyyy')
                        .format(_selectedDateOfBirth!)
                    : 'Non impostata',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _selectDate(context),
            ),
            const Divider(),

            // Phone Prefix + Number
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _phonePrefixController,
                    decoration: const InputDecoration(
                      labelText: 'Prefisso',
                      hintText: '+39',
                      prefixIcon: Icon(Icons.phone_outlined),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 5,
                  child: TextFormField(
                    controller: _phoneNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Numero di telefono',
                      hintText: '1234567890',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Nationality
            DropdownButtonFormField<String>(
              initialValue: _selectedNationality,
              decoration: const InputDecoration(
                labelText: 'Nazionalità',
                prefixIcon: Icon(Icons.flag_outlined),
              ),
              items: _countries.map((country) {
                return DropdownMenuItem(
                  value: country,
                  child: Text(_countryNames[country] ?? country),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedNationality = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // Language
            DropdownButtonFormField<String>(
              initialValue: _selectedLanguage,
              decoration: const InputDecoration(
                labelText: 'Lingua',
                prefixIcon: Icon(Icons.language_outlined),
              ),
              items: _languages.map((lang) {
                return DropdownMenuItem(
                  value: lang,
                  child: Text(_languageNames[lang] ?? lang),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value;
                });
              },
            ),
            const SizedBox(height: 32),

            // Info account
            if (user != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Informazioni Account',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _InfoRow(
                      label: 'Username',
                      value: user.username ?? '',
                    ),
                    _InfoRow(
                      label: 'Email',
                      value: user.email,
                    ),
                    _InfoRow(
                      label: 'Account creato',
                      value: DateFormat('dd/MM/yyyy')
                          .format(user.createdAt),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 24),

            // Delete account button
            TextButton(
              onPressed: _showDeleteAccountDialog,
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Elimina Account'),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}