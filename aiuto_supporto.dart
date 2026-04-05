import 'package:flutter/material.dart';

class AiutoSupportoScreen extends StatelessWidget {
  const AiutoSupportoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: const Color(0xFF3B82F6),
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Aiuto e Supporto',
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
                      Color(0xFF3B82F6),
                      Color(0xFF7C3AED),
                      Color(0xFFA855F7),
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.help,
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
                  // Search Bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cerca nella guida...',
                        border: InputBorder.none,
                        icon: const Icon(Icons.search, color: Color(0xFF3B82F6)),
                        suffixIcon: Icon(Icons.mic, color: Colors.grey[400]),
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('🔍 Funzionalità di ricerca in arrivo!'),
                            backgroundColor: Color(0xFF3B82F6),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),

                  // FAQ Popolari
                  Text(
                    'DOMANDE FREQUENTI',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildFAQItem(
                    context,
                    'Come posso cambiare lingua di studio?',
                    'Vai su Account > Cambia Lingua e seleziona la lingua desiderata.',
                    Icons.language,
                    const Color(0xFF3B82F6),
                  ),
                  _buildFAQItem(
                    context,
                    'Come funziona la prova gratuita Premium?',
                    'Hai 7 giorni gratuiti per testare tutte le funzionalità Premium. Puoi annullare in qualsiasi momento.',
                    Icons.workspace_premium,
                    const Color(0xFFFF6B9D),
                  ),
                  _buildFAQItem(
                    context,
                    'Posso usare ORA offline?',
                    'Con Premium puoi scaricare lezioni e usarle offline quando vuoi.',
                    Icons.cloud_download,
                    const Color(0xFF7C3AED),
                  ),
                  _buildFAQItem(
                    context,
                    'Come resetto la mia password?',
                    'Clicca su "Password dimenticata" nella schermata di login e segui le istruzioni.',
                    Icons.lock_reset,
                    const Color(0xFFFFD93D),
                  ),
                  _buildFAQItem(
                    context,
                    'Posso trasferire il mio abbonamento?',
                    'Sì, contatta il supporto per trasferire il tuo abbonamento su un altro account.',
                    Icons.swap_horiz,
                    const Color(0xFF6BCF7F),
                  ),

                  const SizedBox(height: 30),

                  // Contatti
                  Text(
                    'CONTATTACI',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildContactCard(
                    context,
                    'Email',
                    'support@ora-app.com',
                    'Risposta entro 24 ore',
                    Icons.email,
                    const Color(0xFF3B82F6),
                  ),
                  _buildContactCard(
                    context,
                    'Chat Live',
                    'Disponibile 24/7',
                    'Ricevi assistenza immediata',
                    Icons.chat,
                    const Color(0xFF6BCF7F),
                  ),
                  _buildContactCard(
                    context,
                    'WhatsApp',
                    '+39 123 456 7890',
                    'Scrivici su WhatsApp',
                    Icons.phone,
                    const Color(0xFF6BCF7F),
                  ),
                  _buildContactCard(
                    context,
                    'Community',
                    'Forum e Discussioni',
                    'Connettiti con altri utenti',
                    Icons.people,
                    const Color(0xFF7C3AED),
                  ),

                  const SizedBox(height: 30),

                  // Risorse
                  Text(
                    'RISORSE UTILI',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildResourceCard(
                    context,
                    'Guida Introduttiva',
                    'Impara le basi di ORA',
                    Icons.school,
                    const Color(0xFFFFD93D),
                  ),
                  _buildResourceCard(
                    context,
                    'Video Tutorial',
                    'Guide video passo-passo',
                    Icons.play_circle,
                    const Color(0xFFFF6B9D),
                  ),
                  _buildResourceCard(
                    context,
                    'Blog',
                    'Articoli e consigli per l\'apprendimento',
                    Icons.article,
                    const Color(0xFF3B82F6),
                  ),
                  _buildResourceCard(
                    context,
                    'Centro Sviluppatori',
                    'Documentazione API',
                    Icons.code,
                    const Color(0xFF7C3AED),
                  ),

                  const SizedBox(height: 30),

                  // Segnala Problema
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => _showReportDialog(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6B9D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.bug_report, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'SEGNALA UN PROBLEMA',
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

  Widget _buildFAQItem(BuildContext context, String question, String answer, IconData icon, Color color) {
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
      child: ExpansionTile(
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
          question,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.grey[800],
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              answer,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(BuildContext context, String title, String subtitle, String description, IconData icon, Color color) {
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
        contentPadding: const EdgeInsets.all(16),
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
            fontSize: 16,
            color: Colors.grey[800],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 13,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 18, color: color),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('📞 Apertura di $title...'),
              backgroundColor: color,
            ),
          );
        },
      ),
    );
  }

  Widget _buildResourceCard(BuildContext context, String title, String description, IconData icon, Color color) {
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
          description,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 18, color: color),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('📖 Apertura di $title...'),
              backgroundColor: color,
            ),
          );
        },
      ),
    );
  }

  void _showReportDialog(BuildContext context) {
    final subjectController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFF6B9D).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.bug_report, color: Color(0xFFFF6B9D), size: 24),
            ),
            const SizedBox(width: 12),
            const Text('Segnala Problema', style: TextStyle(fontSize: 20)),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: subjectController,
                decoration: InputDecoration(
                  labelText: 'Oggetto',
                  hintText: 'Descrivi brevemente il problema',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.title, color: Color(0xFF3B82F6)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Descrizione',
                  hintText: 'Fornisci maggiori dettagli...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(bottom: 80),
                    child: Icon(Icons.description, color: Color(0xFF3B82F6)),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              subjectController.dispose();
              descriptionController.dispose();
              Navigator.pop(context);
            },
            child: Text('Annulla', style: TextStyle(color: Colors.grey[600])),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF6B9D), Color(0xFFFFA06B)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('✅ Segnalazione inviata! Ti contatteremo presto.'),
                    backgroundColor: Color(0xFF6BCF7F),
                  ),
                );
                subjectController.dispose();
                descriptionController.dispose();
              },
              child: const Text(
                'INVIA',
                style: TextStyle(
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
}