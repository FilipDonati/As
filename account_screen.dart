import 'package:flutter/material.dart';
import 'package:login_ora/core/config/language_service.dart';
import 'package:intl/intl.dart';
import 'package:login_ora/presentation/screens/tab_account/aiuto_supporto.dart';
import 'package:login_ora/presentation/screens/tab_account/edit_profile_screen.dart';
import 'package:login_ora/presentation/screens/tab_account/notifiche.dart';
import 'package:login_ora/presentation/screens/tab_account/obiettivi.dart';
import 'package:login_ora/presentation/screens/tab_account/premium.dart';
import 'package:login_ora/presentation/screens/tab_account/privacy.dart';
import 'package:login_ora/presentation/screens/tab_account/statistiche.dart';
import 'package:login_ora/presentation/screens/tab_lezioni/lezioni_screen.dart';

class ScreenAccount extends StatefulWidget {
  const ScreenAccount({super.key});

  @override
  State<ScreenAccount> createState() => _ScreenAccountState();
}

class _ScreenAccountState extends State<ScreenAccount> {
  String _selectedLanguage = 'en';
  final LanguageService _languageService = LanguageService(); // NUOVO

  // Mappa traduzioni multilingua (mantenuta uguale)
  final Map<String, Map<String, String>> _translations = {
    'it': {
      'username': 'Nome utente',
      'email': 'Email',
      'bio': 'Bio',
      'noBio': 'Nessuna bio disponibile',
      'lastAccess': 'Ultimo accesso',
      'notAvailable': 'Non disponibile',
      'loginThisMonth': 'Login questo mese',
      'memberSince': 'Membro da',
      'preferredLanguage': 'Lingua preferita',
      'editProfile': 'MODIFICA PROFILO',
      'menu': 'MENU',
      'statistics': 'Statistiche',
      'statisticsSubtitle': 'Visualizza i tuoi progressi',
      'goals': 'Obiettivi',
      'goalsSubtitle': 'Imposta e raggiungi i tuoi obiettivi',
      'notifications': 'Notifiche',
      'notificationsSubtitle': 'Gestisci le tue notifiche',
      'premium': 'Premium',
      'premiumSubtitle': 'Sblocca funzionalità esclusive',
      'support': 'Supporto',
      'supportSubtitle': 'Hai bisogno di aiuto?',
      'privacy': 'Privacy & Sicurezza',
      'privacySubtitle': 'Gestisci la tua privacy',
      'logout': 'LOGOUT',
      'confirmLogout': 'Conferma Logout',
      'logoutMessage': 'Sei sicuro di voler uscire dal tuo account?',
      'cancel': 'Annulla',
      'days': 'giorni',
      'month': 'mese',
      'months': 'mesi',
      'year': 'anno',
      'years': 'anni',
    },
    'en': {
      'username': 'Username',
      'email': 'Email',
      'bio': 'Bio',
      'noBio': 'No bio available',
      'lastAccess': 'Last access',
      'notAvailable': 'Not available',
      'loginThisMonth': 'Logins this month',
      'memberSince': 'Member since',
      'preferredLanguage': 'Preferred language',
      'editProfile': 'EDIT PROFILE',
      'menu': 'MENU',
      'statistics': 'Statistics',
      'statisticsSubtitle': 'View your progress',
      'goals': 'Goals',
      'goalsSubtitle': 'Set and achieve your goals',
      'notifications': 'Notifications',
      'notificationsSubtitle': 'Manage your notifications',
      'premium': 'Premium',
      'premiumSubtitle': 'Unlock exclusive features',
      'support': 'Support',
      'supportSubtitle': 'Need help?',
      'privacy': 'Privacy & Security',
      'privacySubtitle': 'Manage your privacy',
      'logout': 'LOGOUT',
      'confirmLogout': 'Confirm Logout',
      'logoutMessage': 'Are you sure you want to log out of your account?',
      'cancel': 'Cancel',
      'days': 'days',
      'month': 'month',
      'months': 'months',
      'year': 'year',
      'years': 'years',
    },
    'es': {
      'username': 'Nombre de usuario',
      'email': 'Correo electrónico',
      'bio': 'Biografía',
      'noBio': 'Sin biografía disponible',
      'lastAccess': 'Último acceso',
      'notAvailable': 'No disponible',
      'loginThisMonth': 'Inicios de sesión este mes',
      'memberSince': 'Miembro desde',
      'preferredLanguage': 'Idioma preferido',
      'editProfile': 'EDITAR PERFIL',
      'menu': 'MENÚ',
      'statistics': 'Estadísticas',
      'statisticsSubtitle': 'Ver tu progreso',
      'goals': 'Objetivos',
      'goalsSubtitle': 'Establece y alcanza tus objetivos',
      'notifications': 'Notificaciones',
      'notificationsSubtitle': 'Gestionar tus notificaciones',
      'premium': 'Premium',
      'premiumSubtitle': 'Desbloquea funciones exclusivas',
      'support': 'Soporte',
      'supportSubtitle': '¿Necesitas ayuda?',
      'privacy': 'Privacidad y Seguridad',
      'privacySubtitle': 'Gestiona tu privacidad',
      'logout': 'CERRAR SESIÓN',
      'confirmLogout': 'Confirmar cierre de sesión',
      'logoutMessage': '¿Estás seguro de que quieres cerrar sesión?',
      'cancel': 'Cancelar',
      'days': 'días',
      'month': 'mes',
      'months': 'meses',
      'year': 'año',
      'years': 'años',
    },
    'fr': {
      'username': 'Nom d\'utilisateur',
      'email': 'E-mail',
      'bio': 'Bio',
      'noBio': 'Aucune bio disponible',
      'lastAccess': 'Dernier accès',
      'notAvailable': 'Non disponible',
      'loginThisMonth': 'Connexions ce mois-ci',
      'memberSince': 'Membre depuis',
      'preferredLanguage': 'Langue préférée',
      'editProfile': 'MODIFIER LE PROFIL',
      'menu': 'MENU',
      'statistics': 'Statistiques',
      'statisticsSubtitle': 'Voir vos progrès',
      'goals': 'Objectifs',
      'goalsSubtitle': 'Fixez et atteignez vos objectifs',
      'notifications': 'Notifications',
      'notificationsSubtitle': 'Gérer vos notifications',
      'premium': 'Premium',
      'premiumSubtitle': 'Débloquez des fonctionnalités exclusives',
      'support': 'Support',
      'supportSubtitle': 'Besoin d\'aide?',
      'privacy': 'Confidentialité et Sécurité',
      'privacySubtitle': 'Gérez votre confidentialité',
      'logout': 'DÉCONNEXION',
      'confirmLogout': 'Confirmer la déconnexion',
      'logoutMessage': 'Êtes-vous sûr de vouloir vous déconnecter?',
      'cancel': 'Annuler',
      'days': 'jours',
      'month': 'mois',
      'months': 'mois',
      'year': 'an',
      'years': 'ans',
    },
    'de': {
      'username': 'Benutzername',
      'email': 'E-Mail',
      'bio': 'Bio',
      'noBio': 'Keine Bio verfügbar',
      'lastAccess': 'Letzter Zugriff',
      'notAvailable': 'Nicht verfügbar',
      'loginThisMonth': 'Anmeldungen diesen Monat',
      'memberSince': 'Mitglied seit',
      'preferredLanguage': 'Bevorzugte Sprache',
      'editProfile': 'PROFIL BEARBEITEN',
      'menu': 'MENÜ',
      'statistics': 'Statistiken',
      'statisticsSubtitle': 'Sehen Sie Ihren Fortschritt',
      'goals': 'Ziele',
      'goalsSubtitle': 'Setzen und erreichen Sie Ihre Ziele',
      'notifications': 'Benachrichtigungen',
      'notificationsSubtitle': 'Verwalten Sie Ihre Benachrichtigungen',
      'premium': 'Premium',
      'premiumSubtitle': 'Exklusive Funktionen freischalten',
      'support': 'Support',
      'supportSubtitle': 'Brauchen Sie Hilfe?',
      'privacy': 'Datenschutz & Sicherheit',
      'privacySubtitle': 'Verwalten Sie Ihre Privatsphäre',
      'logout': 'ABMELDEN',
      'confirmLogout': 'Abmeldung bestätigen',
      'logoutMessage': 'Möchten Sie sich wirklich abmelden?',
      'cancel': 'Abbrechen',
      'days': 'Tage',
      'month': 'Monat',
      'months': 'Monate',
      'year': 'Jahr',
      'years': 'Jahre',
    },
  };

  String _t(String key) {
    return _translations[_selectedLanguage]?[key] ??
        _translations['it']?[key] ??
        key;
  }

  @override
  void initState() {
    super.initState();
    _loadUserLanguage();

    // NUOVO: Ascolta i cambiamenti di lingua
    _languageService.addListener(_onLanguageChanged);
  }

  @override
  void dispose() {
    // NUOVO: Rimuove il listener quando il widget viene distrutto
    _languageService.removeListener(_onLanguageChanged);
    super.dispose();
  }

  // NUOVO: Callback chiamato quando la lingua cambia
  void _onLanguageChanged() {
    setState(() {
      _selectedLanguage = _languageService.currentLanguage;
    });
    print('Account screen aggiornato con lingua: $_selectedLanguage');
  }

  Future<void> _loadUserLanguage() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      try {
        final response = await supabase
            .from('profiles')
            .select('lingua_scelta')
            .eq('id', user.id)
            .maybeSingle();

        if (response != null && response['lingua_scelta'] != null) {
          setState(() {
            _selectedLanguage = response['lingua_scelta'];
          });
          // NUOVO: Sincronizza con il service
          _languageService.setLanguage(_selectedLanguage);
        } else {
          // Fallback ai metadati utente
          final lang = user.userMetadata?['lingua_scelta'] ?? 'it';
          setState(() {
            _selectedLanguage = lang;
          });
          _languageService.setLanguage(lang);
        }
      } catch (e) {
        print('Errore caricamento lingua: $e');
        final lang = user.userMetadata?['lingua_scelta'] ?? 'it';
        setState(() {
          _selectedLanguage = lang;
        });
        _languageService.setLanguage(lang);
      }
    }
  }

  Future<void> _signOut(BuildContext context) async {
    await supabase.auth.signOut();
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const AuthPage()),
        (route) => false,
      );
    }
  }

  String _calculateMembershipDuration() {
    final user = supabase.auth.currentUser;
    if (user == null) return _t('notAvailable');

    try {
      final createdAt = DateTime.parse(user.createdAt);
      final now = DateTime.now();
      final difference = now.difference(createdAt);

      if (difference.inDays < 30) {
        return '${difference.inDays} ${_t('days')}';
      } else if (difference.inDays < 365) {
        final months = (difference.inDays / 30).floor();
        return '$months ${months == 1 ? _t('month') : _t('months')}';
      } else {
        final years = (difference.inDays / 365).floor();
        return '$years ${years == 1 ? _t('year') : _t('years')}';
      }
    } catch (e) {
      return _t('notAvailable');
    }
  }

  String _getLanguageDisplay(String? langCode) {
    const languageNames = {
      'it': '🇮🇹 Italiano',
      'en': '🇬🇧 English',
      'es': '🇪🇸 Español',
      'fr': '🇫🇷 Français',
      'de': '🇩🇪 Deutsch',
      'ru': '🇷🇺 Русский',
      'zh': '🇨🇳 中文',
      'bg': '🇧🇬 Български',
    };
    return languageNames[langCode] ?? '🌐 ${langCode ?? 'N/A'}';
  }

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 320,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: FutureBuilder<Map<String, dynamic>?>(
                future: _loadUserProfile(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _buildLoadingHeader();
                  }

                  final profile = snapshot.data;
                  final name =
                      profile?['nome_completo'] ?? user?.email?.split('@')[0];
                  final displayName =
                      profile?['display_name'] ?? profile?['nome_completo'];
                  final avatarUrl = profile?['avatar_url'];
                  final email = user?.email ?? _t('notAvailable');
                  final bio = profile?['bio'] ?? _t('noBio');
                  final loginCount = profile?['numero_login'] ?? 0;
                  final membershipDuration = _calculateMembershipDuration();

                  return _buildProfileHeader(
                    name: name ?? 'User',
                    displayName: displayName,
                    avatarUrl: avatarUrl,
                    email: email,
                    bio: bio,
                    loginCount: loginCount,
                    membershipDuration: membershipDuration,
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Pulsante Modifica Profilo
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () async {
                        // MODIFICATO: Quando torniamo dalla pagina di modifica, ricarichiamo la lingua
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfileScreen(),
                          ),
                        );

                        // Se la pagina di modifica ha restituito un risultato, ricarichiamo
                        if (result == true && mounted) {
                          await _loadUserLanguage();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7C3AED),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.edit, color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            _t('editProfile'),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Info Cards
                FutureBuilder<Map<String, dynamic>?>(
                  future: _loadUserProfile(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final profile = snapshot.data;
                    final lastAccess = profile?['ultimo_accesso'] != null
                        ? DateFormat(
                            'dd/MM/yyyy HH:mm',
                          ).format(DateTime.parse(profile!['ultimo_accesso']))
                        : _t('notAvailable');
                    final nationality =
                        profile?['nazionalita'] ?? _t('notAvailable');
                    final language = _getLanguageDisplay(
                      profile?['lingua_scelta'],
                    );

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          _buildInfoCard(
                            _t('email'),
                            user?.email ?? _t('notAvailable'),
                            Icons.email,
                            const Color(0xFF3B82F6),
                          ),
                          const SizedBox(height: 10),
                          _buildInfoCard(
                            _t('lastAccess'),
                            lastAccess,
                            Icons.access_time,
                            const Color(0xFF10B981),
                          ),
                          const SizedBox(height: 10),
                          _buildInfoCard(
                            _t('nationality'),
                            nationality,
                            Icons.public,
                            const Color(0xFFF59E0B),
                          ),
                          const SizedBox(height: 10),
                          _buildInfoCard(
                            _t('preferredLanguage'),
                            language,
                            Icons.language,
                            const Color(0xFFEC4899),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 30),

                // Menu Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _t('menu'),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                _buildMenuItem(
                  context,
                  Icons.bar_chart_rounded,
                  _t('statistics'),
                  _t('statisticsSubtitle'),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StatisticheScreen(),
                      ),
                    );
                  },
                  const Color(0xFF3B82F6),
                ),
                _buildMenuItem(
                  context,
                  Icons.flag_rounded,
                  _t('goals'),
                  _t('goalsSubtitle'),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ObiettiviScreen(),
                      ),
                    );
                  },
                  const Color(0xFFF59E0B),
                ),
                _buildMenuItem(
                  context,
                  Icons.notifications_active_rounded,
                  _t('notifications'),
                  _t('notificationsSubtitle'),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificheScreen(),
                      ),
                    );
                  },
                  const Color(0xFFEC4899),
                ),
                _buildMenuItem(
                  context,
                  Icons.workspace_premium_rounded,
                  _t('premium'),
                  _t('premiumSubtitle'),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PremiumScreen(),
                      ),
                    );
                  },
                  const Color(0xFF8B5CF6),
                ),
                _buildMenuItem(
                  context,
                  Icons.help_rounded,
                  _t('support'),
                  _t('supportSubtitle'),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AiutoSupportoScreen(),
                      ),
                    );
                  },
                  const Color(0xFF10B981),
                ),
                _buildMenuItem(
                  context,
                  Icons.lock_rounded,
                  _t('privacy'),
                  _t('privacySubtitle'),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrivacyScreen(),
                      ),
                    );
                  },
                  const Color(0xFFEF4444),
                ),

                const SizedBox(height: 20),

                // Logout Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.red, Colors.red[700]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () => _showLogoutDialog(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.logout,
                              color: Colors.white,
                              size: 22,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              _t('logout'),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              radius: 20,
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.2), color.withOpacity(0.1)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: Colors.grey[800],
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: color),
        onTap: onTap,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.logout, color: Colors.red, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _t('confirmLogout'),
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
        content: Text(
          _t('logoutMessage'),
          style: const TextStyle(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              _t('cancel'),
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.red, Colors.red[700]!]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                _signOut(context);
              },
              child: Text(
                _t('logout'),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF7C3AED), Color(0xFF6366F1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }

  Widget _buildProfileHeader({
    required String name,
    String? displayName,
    String? avatarUrl,
    required String email,
    required String bio,
    required int loginCount,
    required String membershipDuration,
  }) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF7C3AED), Color(0xFF6366F1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage: avatarUrl != null
                    ? NetworkImage(avatarUrl)
                    : null,
                child: avatarUrl == null
                    ? Text(
                        name[0].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7C3AED),
                        ),
                      )
                    : null,
              ),
              const SizedBox(height: 16),
              Text(
                displayName ?? name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                email,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.9),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  bio,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.95),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildStatCard(
                    loginCount.toString(),
                    _t('loginThisMonth'),
                    const Color(0xFF10B981),
                  ),
                  const SizedBox(width: 16),
                  _buildStatCard(
                    membershipDuration,
                    _t('memberSince'),
                    const Color(0xFFF59E0B),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>?> _loadUserProfile() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      try {
        final response = await supabase
            .from('profiles')
            .select()
            .eq('id', user.id)
            .maybeSingle();
        return response;
      } catch (e) {
        print('Errore caricamento profilo: $e');
        return null;
      }
    }
    return null;
  }
}
