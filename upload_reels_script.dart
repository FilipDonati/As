// ========================================
// SCRIPT DART PER CARICARE REELS
// ========================================

// Questo script ti permette di caricare reels programmaticamente
// Eseguilo con: dart run lib/scripts/upload_reels.dart

import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

// CONFIGURAZIONE
const String SUPABASE_URL = 'https://tuoprogetto.supabase.co';
const String SUPABASE_SERVICE_KEY = 'tua-service-role-key'; // NON anon key!
const String USER_ID = 'id-utente-che-pubblica'; // ID dell'utente che pubblica

void main() async {
  print('🚀 Inizializzazione Supabase...');
  
  await Supabase.initialize(
    url: SUPABASE_URL,
    anonKey: SUPABASE_SERVICE_KEY,
  );
  
  final supabase = Supabase.instance.client;
  
  // ========================================
  // METODO 1: Carica singolo reel
  // ========================================
  
  print('\n📹 Caricamento singolo reel...');
  await uploadSingleReel(
    supabase: supabase,
    videoPath: '/path/to/video.mp4',
    title: 'Il mio primo reel',
    description: 'Praticando italiano con ORA 🇮🇹',
    userId: USER_ID,
  );
  
  // ========================================
  // METODO 2: Carica multipli reels da cartella
  // ========================================
  
  print('\n📂 Caricamento multipli reels...');
  await uploadMultipleReels(
    supabase: supabase,
    videoDirectory: '/path/to/videos',
    userId: USER_ID,
  );
  
  print('\n✅ Caricamento completato!');
  exit(0);
}

// ========================================
// FUNZIONE: Carica singolo reel
// ========================================

Future<void> uploadSingleReel({
  required SupabaseClient supabase,
  required String videoPath,
  required String title,
  String? description,
  required String userId,
}) async {
  try {
    final videoFile = File(videoPath);
    
    if (!await videoFile.exists()) {
      print('❌ Errore: File non trovato: $videoPath');
      return;
    }
    
    // 1. Upload video su Storage
    print('  📤 Upload video...');
    final fileName = '${DateTime.now().millisecondsSinceEpoch}_${videoFile.path.split('/').last}';
    final videoBytes = await videoFile.readAsBytes();
    
    await supabase.storage
        .from('reels')
        .uploadBinary('videos/$fileName', videoBytes);
    
    final videoUrl = supabase.storage
        .from('reels')
        .getPublicUrl('videos/$fileName');
    
    print('  ✅ Video caricato: $videoUrl');
    
    // 2. (Opzionale) Genera e carica thumbnail
    // Nota: Richiede package video_thumbnail
    String? thumbnailUrl;
    // TODO: Implementa generazione thumbnail se necessario
    
    // 3. Ottieni durata video
    // Nota: Richiede package video_player o ffmpeg
    final duration = await getVideoDuration(videoPath);
    
    // 4. Crea record nel database
    print('  💾 Salvataggio nel database...');
    final response = await supabase.from('reels').insert({
      'user_id': userId,
      'video_url': videoUrl,
      'thumbnail_url': thumbnailUrl,
      'title': title,
      'description': description,
      'duration': duration,
      'is_active': true,
    }).select().single();
    
    print('  ✅ Reel creato con ID: ${response['id']}');
    
  } catch (e) {
    print('  ❌ Errore durante upload: $e');
  }
}

// ========================================
// FUNZIONE: Carica multipli reels
// ========================================

Future<void> uploadMultipleReels({
  required SupabaseClient supabase,
  required String videoDirectory,
  required String userId,
}) async {
  final directory = Directory(videoDirectory);
  
  if (!await directory.exists()) {
    print('❌ Errore: Directory non trovata: $videoDirectory');
    return;
  }
  
  // Lista tutti i file .mp4 nella directory
  final videoFiles = await directory
      .list()
      .where((entity) => 
          entity is File && 
          entity.path.toLowerCase().endsWith('.mp4'))
      .cast<File>()
      .toList();
  
  print('📹 Trovati ${videoFiles.length} video da caricare');
  
  for (var i = 0; i < videoFiles.length; i++) {
    final file = videoFiles[i];
    final fileName = file.path.split('/').last;
    
    print('\n[${i + 1}/${videoFiles.length}] Caricamento: $fileName');
    
    await uploadSingleReel(
      supabase: supabase,
      videoPath: file.path,
      title: 'Reel ${i + 1}',
      description: 'Caricato da script automatico 🎬',
      userId: userId,
    );
    
    // Pausa per evitare rate limiting
    await Future.delayed(const Duration(seconds: 2));
  }
}

// ========================================
// FUNZIONE: Ottieni durata video
// ========================================

Future<int> getVideoDuration(String videoPath) async {
  // Metodo semplificato - ritorna durata di default
  // Per durata reale, usa ffmpeg o video_player
  
  // Esempio con ffmpeg (se installato):
  /*
  final result = await Process.run('ffprobe', [
    '-v', 'error',
    '-show_entries', 'format=duration',
    '-of', 'default=noprint_wrappers=1:nokey=1',
    videoPath,
  ]);
  
  if (result.exitCode == 0) {
    return double.parse(result.stdout.toString().trim()).toInt();
  }
  */
  
  // Default: 30 secondi
  return 30;
}

// ========================================
// ESEMPIO: Batch upload con metadata
// ========================================

Future<void> batchUploadWithMetadata({
  required SupabaseClient supabase,
  required String userId,
}) async {
  // Lista di video con i loro metadata
  final videos = [
    {
      'path': '/path/to/video1.mp4',
      'title': 'Lezione 1: Saluti',
      'description': 'Impara i saluti base in italiano 🇮🇹',
    },
    {
      'path': '/path/to/video2.mp4',
      'title': 'Lezione 2: Numeri',
      'description': 'Conta da 1 a 10 in italiano 🔢',
    },
    {
      'path': '/path/to/video3.mp4',
      'title': 'Lezione 3: Colori',
      'description': 'I colori dell\'arcobaleno 🌈',
    },
  ];
  
  for (var i = 0; i < videos.length; i++) {
    final video = videos[i];
    print('\n[${i + 1}/${videos.length}] Caricamento: ${video['title']}');
    
    await uploadSingleReel(
      supabase: supabase,
      videoPath: video['path']!,
      title: video['title']!,
      description: video['description'],
      userId: userId,
    );
    
    await Future.delayed(const Duration(seconds: 3));
  }
}

// ========================================
// UTILITY: Verifica reels caricati
// ========================================

Future<void> verifyUploadedReels(SupabaseClient supabase) async {
  print('\n🔍 Verifica reels nel database...');
  
  final response = await supabase
      .from('reels')
      .select('id, title, video_url, created_at, users(username)')
      .order('created_at', ascending: false)
      .limit(10);
  
  print('\n📊 Ultimi 10 reels:');
  for (var reel in response) {
    print('  - ${reel['title']} (by ${reel['users']['username']})');
    print('    URL: ${reel['video_url']}');
    print('    Data: ${reel['created_at']}');
  }
}