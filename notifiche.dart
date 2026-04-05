import 'package:flutter/material.dart';

class NotificheScreen extends StatefulWidget {
  const NotificheScreen({super.key});

  @override
  State<NotificheScreen> createState() => _NotificheScreenState();
}

class _NotificheScreenState extends State<NotificheScreen> {
  bool notificheGenerali = true;
  bool promemoria = true;
  bool progressi = false;
  bool nuoveLezioni = true;
  bool social = false;
  bool email = true;
  bool suoni = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: const Color(0xFFFFA06B),
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Notifiche',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFFA06B),
                      Color(0xFFFF6B9D),
                      Color(0xFFFFD93D),
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.notifications,
                    size: 80,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info Box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFA06B).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFFFA06B).withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, color: Color(0xFFFFA06B)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Personalizza le tue notifiche per restare aggiornato',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Notifiche Push
                  Text(
                    'NOTIFICHE PUSH',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildNotificationToggle(
                    'Notifiche Generali',
                    'Abilita tutte le notifiche',
                    notificheGenerali,
                    (val) => setState(() => notificheGenerali = val),
                    Icons.notifications_active,
                    const Color(0xFFFFA06B),
                  ),
                  _buildNotificationToggle(
                    'Promemoria Studio',
                    'Ricevi promemoria per studiare',
                    promemoria,
                    (val) => setState(() => promemoria = val),
                    Icons.alarm,
                    const Color(0xFF7C3AED),
                  ),
                  _buildNotificationToggle(
                    'Aggiornamenti Progressi',
                    'Notifiche sui tuoi progressi',
                    progressi,
                    (val) => setState(() => progressi = val),
                    Icons.trending_up,
                    const Color(0xFF6BCF7F),
                  ),
                  _buildNotificationToggle(
                    'Nuove Lezioni',
                    'Avvisi su nuovi contenuti',
                    nuoveLezioni,
                    (val) => setState(() => nuoveLezioni = val),
                    Icons.new_releases,
                    const Color(0xFFFFD93D),
                  ),
                  _buildNotificationToggle(
                    'Social e Community',
                    'Aggiornamenti dalla community',
                    social,
                    (val) => setState(() => social = val),
                    Icons.people,
                    const Color(0xFF3B82F6),
                  ),

                  const SizedBox(height: 30),

                  // Email
                  Text(
                    'EMAIL',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildNotificationToggle(
                    'Notifiche Email',
                    'Ricevi aggiornamenti via email',
                    email,
                    (val) => setState(() => email = val),
                    Icons.email,
                    const Color(0xFF7C3AED),
                  ),

                  const SizedBox(height: 30),

                  // Audio
                  Text(
                    'AUDIO',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildNotificationToggle(
                    'Suoni Notifiche',
                    'Abilita suoni per le notifiche',
                    suoni,
                    (val) => setState(() => suoni = val),
                    Icons.volume_up,
                    const Color(0xFFFF6B9D),
                  ),

                  const SizedBox(height: 30),

                  // Orari Promemoria
                  Text(
                    'ORARI PROMEMORIA',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildTimeSelector('Mattina', '09:00', Icons.wb_sunny, const Color(0xFFFFD93D)),
                  _buildTimeSelector('Pomeriggio', '15:00', Icons.wb_cloudy, const Color(0xFFFFA06B)),
                  _buildTimeSelector('Sera', '20:00', Icons.nights_stay, const Color(0xFF7C3AED)),

                  const SizedBox(height: 40),

                  // Pulsante Salva
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('✅ Impostazioni salvate!'),
                            backgroundColor: Color(0xFF6BCF7F),
                          ),
                        );
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFA06B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.save, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'SALVA IMPOSTAZIONI',
                            style: TextStyle(
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
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationToggle(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 26),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.grey[800],
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: color,
        ),
      ),
    );
  }

  Widget _buildTimeSelector(String label, String time, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.grey[800],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('⏰ Funzionalità in arrivo!'),
                  backgroundColor: color,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Text(
                    time,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: color,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.access_time, color: color, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}