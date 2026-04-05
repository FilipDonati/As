import 'package:flutter/material.dart';
import 'dart:async';

class ScreenReels extends StatefulWidget {
  const ScreenReels({super.key});

  @override
  State<ScreenReels> createState() => _ScreenReelsState();
}

class _ScreenReelsState extends State<ScreenReels>
    with TickerProviderStateMixin {
  int _currentIndex = 0;

  // Per-reel state tracked by index / author
  final Set<int> _likedReels = {};
  final Set<int> _savedReels = {};
  final Set<String> _followingAuthors = {};

  // Like animation
  bool _showLikeAnimation = false;
  late AnimationController _likeAnimationController;

  // View timer
  int _viewCount = 0;
  Timer? _viewTimer;

  final List<Map<String, dynamic>> _reels = [
    {
      'author': 'Mario Rossi',
      'region': 'Italia',
      'language': '🇮🇹',
      'likes': 245,
      'comments': 23,
      'shares': 12,
      'views': 1234,
      'color': const Color(0xFFFF6B9D),
      'description': 'Imparare l\'italiano è bellissimo! 🇮🇹✨',
      'hashtags': '#italiano #imparare #ORA',
      'duration': '0:15',
      'verified': true,
    },
    {
      'author': 'Laura Bianchi',
      'region': 'Italia',
      'language': '🇮🇹',
      'likes': 189,
      'comments': 15,
      'shares': 8,
      'views': 892,
      'color': const Color(0xFFFFA06B),
      'description': 'Espressioni italiane quotidiane 💬',
      'hashtags': '#espressioni #cultura',
      'duration': '0:22',
      'verified': false,
    },
    {
      'author': 'Giovanni Verdi',
      'region': 'Italia',
      'language': '🇮🇹',
      'likes': 567,
      'comments': 45,
      'shares': 28,
      'views': 2456,
      'color': const Color(0xFFFFD93D),
      'description': 'Grammatica italiana facile! 📚',
      'hashtags': '#grammatica #lezione',
      'duration': '0:18',
      'verified': true,
    },
    {
      'author': 'Sofia Romano',
      'region': 'Italia',
      'language': '🇮🇹',
      'likes': 432,
      'comments': 34,
      'shares': 19,
      'views': 1678,
      'color': const Color(0xFF6BCF7F),
      'description': 'Cucina italiana per principianti 🍝',
      'hashtags': '#cucina #vocabolario',
      'duration': '0:25',
      'verified': true,
    },
    {
      'author': 'Luca Ferrari',
      'region': 'Italia',
      'language': '🇮🇹',
      'likes': 678,
      'comments': 56,
      'shares': 34,
      'views': 3124,
      'color': const Color(0xFF7C3AED),
      'description': 'Modi di dire italiani divertenti 😄',
      'hashtags': '#modididire #divertente',
      'duration': '0:20',
      'verified': false,
    },
    {
      'author': 'Giulia Costa',
      'region': 'Italia',
      'language': '🇮🇹',
      'likes': 345,
      'comments': 28,
      'shares': 15,
      'views': 1456,
      'color': const Color(0xFF3B82F6),
      'description': 'Pronuncia perfetta in italiano 🎤',
      'hashtags': '#pronuncia #speaking',
      'duration': '0:17',
      'verified': true,
    },
    {
      'author': 'John Smith',
      'region': 'UK',
      'language': '🇬🇧',
      'likes': 892,
      'comments': 67,
      'shares': 42,
      'views': 4567,
      'color': const Color(0xFFFF6B9D),
      'description': 'British English expressions 🇬🇧',
      'hashtags': '#english #british',
      'duration': '0:23',
      'verified': true,
    },
    {
      'author': 'Emma Watson',
      'region': 'UK',
      'language': '🇬🇧',
      'likes': 1234,
      'comments': 98,
      'shares': 67,
      'views': 8901,
      'color': const Color(0xFF6BCF7F),
      'description': 'Daily English conversation tips 💭',
      'hashtags': '#conversation #tips',
      'duration': '0:19',
      'verified': true,
    },
    {
      'author': 'Oliver Brown',
      'region': 'UK',
      'language': '🇬🇧',
      'likes': 756,
      'comments': 45,
      'shares': 31,
      'views': 3456,
      'color': const Color(0xFFFFA06B),
      'description': 'English grammar made easy! 📖',
      'hashtags': '#grammar #learning',
      'duration': '0:21',
      'verified': false,
    },
    {
      'author': 'Sophie Turner',
      'region': 'UK',
      'language': '🇬🇧',
      'likes': 923,
      'comments': 72,
      'shares': 48,
      'views': 5234,
      'color': const Color(0xFF3B82F6),
      'description': 'Accent training for beginners 🗣️',
      'hashtags': '#accent #pronunciation',
      'duration': '0:16',
      'verified': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _likeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    // Auto-hide heart animation after it completes
    _likeAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 600), () {
          if (mounted) setState(() => _showLikeAnimation = false);
        });
      }
    });
    _startViewTimer();
  }

  @override
  void dispose() {
    _viewTimer?.cancel();
    _likeAnimationController.dispose();
    super.dispose();
  }

  void _startViewTimer() {
    _viewTimer?.cancel();
    _viewCount = 0;
    _viewTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _viewCount++);
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
      _showLikeAnimation = false;
    });
    _likeAnimationController.reset();
    _startViewTimer();
  }

  void _toggleLike() {
    setState(() {
      if (_likedReels.contains(_currentIndex)) {
        _likedReels.remove(_currentIndex);
        _reels[_currentIndex]['likes']--;
        _likeAnimationController.reset();
        _showLikeAnimation = false;
      } else {
        _likedReels.add(_currentIndex);
        _reels[_currentIndex]['likes']++;
        _showLikeAnimation = true;
        _likeAnimationController.forward(from: 0);
      }
    });
  }

  void _toggleSave() {
    setState(() {
      if (_savedReels.contains(_currentIndex)) {
        _savedReels.remove(_currentIndex);
      } else {
        _savedReels.add(_currentIndex);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _savedReels.contains(_currentIndex)
              ? 'Reel salvato! 💾'
              : 'Reel rimosso dai salvati',
        ),
        duration: const Duration(milliseconds: 1500),
        backgroundColor: const Color(0xFF7C3AED),
      ),
    );
  }

  void _toggleFollow() {
    final author = _reels[_currentIndex]['author'] as String;
    setState(() {
      if (_followingAuthors.contains(author)) {
        _followingAuthors.remove(author);
      } else {
        _followingAuthors.add(author);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _followingAuthors.contains(author)
              ? 'Hai iniziato a seguire $author! ✅'
              : 'Non segui più $author',
        ),
        duration: const Duration(milliseconds: 1500),
        backgroundColor: const Color(0xFF7C3AED),
      ),
    );
  }

  void _showComments() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildCommentsSheet(),
    );
  }

  void _showShareOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildShareSheet(),
    );
  }

  Widget _buildCommentsSheet() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_reels[_currentIndex]['comments']} Commenti',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 5,
              itemBuilder: (context, index) => _buildCommentItem(index),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey[200]!)),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Aggiungi un commento...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF7C3AED), Color(0xFFA855F7)],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white, size: 20),
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Commento pubblicato! 💬'),
                            backgroundColor: Color(0xFF7C3AED),
                          ),
                        );
                      },
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

  Widget _buildCommentItem(int index) {
    final comments = [
      {'user': 'Marco L.', 'text': 'Ottimo contenuto! 👏', 'time': '2h'},
      {'user': 'Giulia P.', 'text': 'Molto utile, grazie!', 'time': '3h'},
      {'user': 'Luca R.', 'text': 'Continua così! 🔥', 'time': '5h'},
      {'user': 'Sara M.', 'text': 'Fantastico! Ho imparato molto', 'time': '1d'},
      {'user': 'Andrea B.', 'text': 'Servono più video così!', 'time': '2d'},
    ];
    final comment = comments[index];
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF7C3AED), Color(0xFFA855F7)],
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                comment['user']![0],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment['user']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      comment['time']!,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(comment['text']!, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border, size: 18),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildShareSheet() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    'Condividi Reel',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildShareOption(
                          Icons.copy, 'Copia link', const Color(0xFF3B82F6)),
                      _buildShareOption(
                          Icons.message, 'Messaggio', const Color(0xFF6BCF7F)),
                      _buildShareOption(
                          Icons.share, 'Altro', const Color(0xFFFFA06B)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareOption(IconData icon, String label, Color color) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$label selezionato! 🔗'),
            backgroundColor: const Color(0xFF7C3AED),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 2),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  // Action button for right-side controls
  Widget _buildActionButton(
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              shape: BoxShape.circle,
              border: Border.all(color: color.withOpacity(0.5), width: 1.5),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          if (label.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView verticale per scorrere i reels
          PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _reels.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) => _buildReelPage(index),
          ),

          // Header fisso con logo ORA
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 10,
                left: 16,
                right: 16,
                bottom: 10,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [Color(0xFF7C3AED), Color(0xFFA855F7)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF7C3AED).withOpacity(0.5),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'O',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Reels',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.white),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Crea il tuo Reel! 🎥'),
                              backgroundColor: Color(0xFF7C3AED),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Page indicator — vertical dots on the right
          Positioned(
            right: 4,
            top: 0,
            bottom: 0,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(_reels.length, (i) {
                  final isActive = i == _currentIndex;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 4,
                    height: isActive ? 20 : 5,
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    decoration: BoxDecoration(
                      color: isActive
                          ? Colors.white
                          : Colors.white.withOpacity(0.35),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  );
                }),
              ),
            ),
          ),

          // Heart animation at centre (double-tap or like button)
          if (_showLikeAnimation)
            Center(
              child: IgnorePointer(
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.0, end: 1.2).animate(
                    CurvedAnimation(
                      parent: _likeAnimationController,
                      curve: Curves.elasticOut,
                    ),
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Color(0xFFFF6B9D),
                    size: 120,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildReelPage(int index) {
    final reel = _reels[index];
    final isLiked = _likedReels.contains(index);
    final isSaved = _savedReels.contains(index);
    final isFollowing =
        _followingAuthors.contains(reel['author'] as String);

    return GestureDetector(
      // Double-tap to like
      onDoubleTap: () {
        if (!isLiked) _toggleLike();
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1E1B4B),
              (reel['color'] as Color).withOpacity(0.3),
            ],
          ),
        ),
        child: Stack(
          children: [
            // CENTRE: Video placeholder
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          (reel['color'] as Color).withOpacity(0.5),
                          reel['color'] as Color,
                        ],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: (reel['color'] as Color).withOpacity(0.6),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.play_circle_outline,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.remove_red_eye,
                            color: Colors.white, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          '${reel['views']} views',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.access_time,
                            color: Colors.white, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          reel['duration'] as String,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // BOTTOM LEFT: User info + description
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 80,
              left: 16,
              right: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              reel['color'] as Color,
                              (reel['color'] as Color).withOpacity(0.7),
                            ],
                          ),
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Colors.white, width: 2.5),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  (reel['color'] as Color).withOpacity(0.5),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            (reel['author'] as String)[0],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    reel['author'] as String,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          color:
                                              Colors.black.withOpacity(0.5),
                                          blurRadius: 8,
                                        ),
                                      ],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (reel['verified'] as bool) ...[
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.verified,
                                    color: Color(0xFF3B82F6),
                                    size: 16,
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                Text(reel['language'] as String,
                                    style: const TextStyle(fontSize: 14)),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.25),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color:
                                            Colors.white.withOpacity(0.3)),
                                  ),
                                  child: Text(
                                    reel['region'] as String,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Follow button
                      GestureDetector(
                        onTap: _toggleFollow,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            gradient: isFollowing
                                ? null
                                : const LinearGradient(
                                    colors: [
                                      Color(0xFF7C3AED),
                                      Color(0xFFA855F7),
                                    ],
                                  ),
                            color: isFollowing ? Colors.grey[700] : null,
                            borderRadius: BorderRadius.circular(16),
                            border:
                                Border.all(color: Colors.white, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF7C3AED)
                                    .withOpacity(0.5),
                                blurRadius: 12,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Text(
                            isFollowing ? 'Segui già' : 'Segui',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    reel['description'] as String,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 8),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    reel['hashtags'] as String,
                    style: TextStyle(
                      color: const Color(0xFF3B82F6),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      shadows: [
                        Shadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // RIGHT: Action buttons
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 80,
              right: 12,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildActionButton(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    '${reel['likes']}',
                    const Color(0xFFFF6B9D),
                    _toggleLike,
                  ),
                  const SizedBox(height: 20),
                  _buildActionButton(
                    Icons.comment,
                    '${reel['comments']}',
                    const Color(0xFF3B82F6),
                    _showComments,
                  ),
                  const SizedBox(height: 20),
                  _buildActionButton(
                    Icons.share,
                    '${reel['shares']}',
                    const Color(0xFF6BCF7F),
                    _showShareOptions,
                  ),
                  const SizedBox(height: 20),
                  _buildActionButton(
                    isSaved ? Icons.bookmark : Icons.bookmark_border,
                    '',
                    const Color(0xFFFFD93D),
                    _toggleSave,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}