// lib/presentation/screens/tab_reel_screen/create_reel_screen.dart
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import '../../../data/remote/reel_repository.dart';
import '../../../services/db_client/storage_service.dart';

class CreateReelScreen extends StatefulWidget {
  const CreateReelScreen({super.key});

  @override
  State<CreateReelScreen> createState() => _CreateReelScreenState();
}

class _CreateReelScreenState extends State<CreateReelScreen> {
  final ReelRepository _reelRepository = ReelRepository();
  final StorageService _storageService = StorageService();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  File? _videoFile;
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _pickVideo();
  }

  Future<void> _pickVideo() async {
    try {
      final videoFile = await _storageService.pickVideo();

      if (videoFile == null) {
        if (mounted) Navigator.pop(context);
        return;
      }

      setState(() {
        _videoFile = videoFile;
      });

      await _initializeVideo();
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  Future<void> _initializeVideo() async {
    if (_videoFile == null) return;

    _videoController = VideoPlayerController.file(_videoFile!);
    await _videoController!.initialize();
    _videoController!.setLooping(true);
    _videoController!.play();

    if (mounted) {
      setState(() {
        _isVideoInitialized = true;
      });
    }
  }

  Future<void> _publishReel() async {
    if (_videoFile == null) return;

    setState(() => _isLoading = true);

    try {
      final duration = _videoController?.value.duration.inSeconds ?? 0;

      await _reelRepository.createReel(
        videoFile: _videoFile!,
        title: _titleController.text.trim().isEmpty
            ? null
            : _titleController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        duration: duration,
      );

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Reel pubblicato con successo!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore durante la pubblicazione: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Nuovo Reel', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _publishReel,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'Pubblica',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ],
      ),
      body: _videoFile == null
          ? const Center(
              child: CircularProgressIndicator(color: Colors.white),
            )
          : Column(
              children: [
                // Video Preview
                Expanded(
                  flex: 3,
                  child: _isVideoInitialized && _videoController != null
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              if (_videoController!.value.isPlaying) {
                                _videoController!.pause();
                              } else {
                                _videoController!.play();
                              }
                            });
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              AspectRatio(
                                aspectRatio:
                                    _videoController!.value.aspectRatio,
                                child: VideoPlayer(_videoController!),
                              ),
                              if (!_videoController!.value.isPlaying)
                                Icon(
                                  Icons.play_arrow,
                                  size: 64,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                            ],
                          ),
                        )
                      : const Center(
                          child:
                              CircularProgressIndicator(color: Colors.white),
                        ),
                ),

                // Form
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Dettagli',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _titleController,
                            decoration: InputDecoration(
                              labelText: 'Titolo (opzionale)',
                              hintText: 'Aggiungi un titolo accattivante',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            maxLength: 100,
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              labelText: 'Descrizione (opzionale)',
                              hintText: 'Descrivi il tuo reel',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            maxLines: 3,
                            maxLength: 500,
                          ),
                          const SizedBox(height: 16),
                          // Video info
                          if (_isVideoInitialized && _videoController != null)
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.info_outline, size: 20),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Durata: ${_videoController!.value.duration.inSeconds}s',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}