import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Modello Account Backend
class AccountBackend {
  final String id;
  final String username;
  final String displayName;
  final String bio;
  final String profileImageUrl;
  final String country;
  final String languageFlag;
  final int followers;
  final int following;
  final int posts;
  final bool isVerified;
  final DateTime joinedDate;

  AccountBackend({
    required this.id,
    required this.username,
    required this.displayName,
    required this.bio,
    required this.profileImageUrl,
    required this.country,
    required this.languageFlag,
    required this.followers,
    required this.following,
    required this.posts,
    this.isVerified = false,
    required this.joinedDate,
  });
}

// Modello Reel con info account
class ReelData {
  final String id;
  final AccountBackend account;
  final String description;
  final String? videoUrl;
  final int likes;
  final int comments;
  final int shares;
  final int saves;
  final Color themeColor;
  final DateTime createdAt;

  ReelData({
    required this.id,
    required this.account,
    required this.description,
    this.videoUrl,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.saves,
    required this.themeColor,
    required this.createdAt,
  });
}

class ScreenReels extends StatefulWidget {
  const ScreenReels({super.key});

  @override
  State<ScreenReels> createState() => _ScreenReelsState();
}

class _ScreenReelsState extends State<ScreenReels> {
  int _currentIndex = 0;
  final ImagePicker _picker = ImagePicker();
  
  // Set per tracciare gli account seguiti
  final Set<String> _followedAccounts = {};
  
  // Database simulato di account backend
  final List<AccountBackend> _accounts = [
    AccountBackend(
      id: 'acc_001',
      username: '@mario.rossi',
      displayName: 'Mario Rossi',
      bio: 'Language enthusiast 🇮🇹 | Teaching Italian',
      profileImageUrl: 'https://i.pravatar.cc/150?img=12',
      country: 'Italia',
      languageFlag: '🇮🇹',
      followers: 12500,
      following: 234,
      posts: 89,
      isVerified: true,
      joinedDate: DateTime(2023, 3, 15),
    ),
    AccountBackend(
      id: 'acc_002',
      username: '@laura.bianchi',
      displayName: 'Laura Bianchi',
      bio: 'Polyglot 🌍 | 5 languages | Travel lover',
      profileImageUrl: 'https://i.pravatar.cc/150?img=45',
      country: 'Italia',
      languageFlag: '🇮🇹',
      followers: 8900,
      following: 567,
      posts: 124,
      isVerified: false,
      joinedDate: DateTime(2023, 6, 20),
    ),
    AccountBackend(
      id: 'acc_003',
      username: '@giovanni.verdi',
      displayName: 'Giovanni Verdi',
      bio: 'Italian teacher | Online courses 📚',
      profileImageUrl: 'https://i.pravatar.cc/150?img=33',
      country: 'Italia',
      languageFlag: '🇮🇹',
      followers: 25000,
      following: 189,
      posts: 245,
      isVerified: true,
      joinedDate: DateTime(2022, 11, 8),
    ),
    AccountBackend(
      id: 'acc_004',
      username: '@sofia.romano',
      displayName: 'Sofia Romano',
      bio: 'Content creator 🎥 | Language tips daily',
      profileImageUrl: 'https://i.pravatar.cc/150?img=27',
      country: 'Italia',
      languageFlag: '🇮🇹',
      followers: 15600,
      following: 423,
      posts: 178,
      isVerified: true,
      joinedDate: DateTime(2023, 1, 12),
    ),
    AccountBackend(
      id: 'acc_005',
      username: '@luca.ferrari',
      displayName: 'Luca Ferrari',
      bio: 'Native speaker | Conversation practice 💬',
      profileImageUrl: 'https://i.pravatar.cc/150?img=51',
      country: 'Italia',
      languageFlag: '🇮🇹',
      followers: 19800,
      following: 312,
      posts: 203,
      isVerified: false,
      joinedDate: DateTime(2023, 4, 25),
    ),
    AccountBackend(
      id: 'acc_006',
      username: '@giulia.costa',
      displayName: 'Giulia Costa',
      bio: 'Language coach | DM for lessons 📩',
      profileImageUrl: 'https://i.pravatar.cc/150?img=38',
      country: 'Italia',
      languageFlag: '🇮🇹',
      followers: 11200,
      following: 278,
      posts: 156,
      isVerified: true,
      joinedDate: DateTime(2023, 2, 18),
    ),
    AccountBackend(
      id: 'acc_007',
      username: '@john.smith',
      displayName: 'John Smith',
      bio: 'English tutor 🇬🇧 | IELTS preparation',
      profileImageUrl: 'https://i.pravatar.cc/150?img=14',
      country: 'UK',
      languageFlag: '🇬🇧',
      followers: 34500,
      following: 156,
      posts: 312,
      isVerified: true,
      joinedDate: DateTime(2022, 8, 5),
    ),
    AccountBackend(
      id: 'acc_008',
      username: '@emma.watson',
      displayName: 'Emma Watson',
      bio: 'British accent expert | Pronunciation tips 🗣️',
      profileImageUrl: 'https://i.pravatar.cc/150?img=41',
      country: 'UK',
      languageFlag: '🇬🇧',
      followers: 45600,
      following: 234,
      posts: 389,
      isVerified: true,
      joinedDate: DateTime(2022, 5, 14),
    ),
    AccountBackend(
      id: 'acc_009',
      username: '@oliver.brown',
      displayName: 'Oliver Brown',
      bio: 'Cambridge certified | Business English 💼',
      profileImageUrl: 'https://i.pravatar.cc/150?img=60',
      country: 'UK',
      languageFlag: '🇬🇧',
      followers: 28900,
      following: 445,
      posts: 267,
      isVerified: false,
      joinedDate: DateTime(2023, 7, 22),
    ),
    AccountBackend(
      id: 'acc_010',
      username: '@sophie.turner',
      displayName: 'Sophie Turner',
      bio: 'ESL teacher | Fun learning methods 🎨',
      profileImageUrl: 'https://i.pravatar.cc/150?img=29',
      country: 'UK',
      languageFlag: '🇬🇧',
      followers: 37800,
      following: 567,
      posts: 421,
      isVerified: true,
      joinedDate: DateTime(2022, 10, 30),
    ),
  ];

  // Lista reels con dati completi
  late List<ReelData> _reels;

  @override
  void initState() {
    super.initState();
    _initializeReels();
  }

  void _initializeReels() {
    _reels = [
      ReelData(
        id: 'reel_001',
        account: _accounts[0],
        description: 'Praticando italiano con ORA 🇮🇹✨\nImpara le espressioni quotidiane!',
        likes: 2450,
        comments: 234,
        shares: 89,
        saves: 156,
        themeColor: const Color(0xFFFF6B9D),
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      ReelData(
        id: 'reel_002',
        account: _accounts[1],
        description: 'Italian pronunciation tips 🗣️\n#languagelearning #italiano',
        likes: 1890,
        comments: 156,
        shares: 67,
        saves: 123,
        themeColor: const Color(0xFFFFA06B),
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      ReelData(
        id: 'reel_003',
        account: _accounts[2],
        description: 'Top 10 Italian phrases for beginners 🇮🇹\nSalva questo video!',
        likes: 5670,
        comments: 445,
        shares: 234,
        saves: 389,
        themeColor: const Color(0xFFFFD93D),
        createdAt: DateTime.now().subtract(const Duration(hours: 12)),
      ),
      ReelData(
        id: 'reel_004',
        account: _accounts[3],
        description: 'Grammar made easy! 📚\nFollow for more tips',
        likes: 4320,
        comments: 334,
        shares: 178,
        saves: 267,
        themeColor: const Color(0xFF6BCF7F),
        createdAt: DateTime.now().subtract(const Duration(hours: 18)),
      ),
      ReelData(
        id: 'reel_005',
        account: _accounts[4],
        description: 'Real conversation practice 💬\nStudy with me!',
        likes: 6780,
        comments: 567,
        shares: 312,
        saves: 445,
        themeColor: const Color(0xFF7C3AED),
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      ReelData(
        id: 'reel_006',
        account: _accounts[5],
        description: 'Italian culture & traditions 🇮🇹🍕\n#italianlife',
        likes: 3450,
        comments: 289,
        shares: 134,
        saves: 201,
        themeColor: const Color(0xFF3B82F6),
        createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 6)),
      ),
      ReelData(
        id: 'reel_007',
        account: _accounts[6],
        description: 'British English vs American English 🇬🇧🇺🇸\nSpot the difference!',
        likes: 8920,
        comments: 678,
        shares: 445,
        saves: 556,
        themeColor: const Color(0xFFFF6B9D),
        createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 12)),
      ),
      ReelData(
        id: 'reel_008',
        account: _accounts[7],
        description: 'Pronunciation masterclass 🗣️\nPerfect your accent!',
        likes: 12340,
        comments: 989,
        shares: 667,
        saves: 778,
        themeColor: const Color(0xFF6BCF7F),
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      ReelData(
        id: 'reel_009',
        account: _accounts[8],
        description: 'Business English essentials 💼\n#corporateenglish',
        likes: 7560,
        comments: 456,
        shares: 289,
        saves: 334,
        themeColor: const Color(0xFFFFA06B),
        createdAt: DateTime.now().subtract(const Duration(days: 2, hours: 8)),
      ),
      ReelData(
        id: 'reel_010',
        account: _accounts[9],
        description: 'Fun idioms & expressions 🎨\nEnglish made fun!',
        likes: 9230,
        comments: 723,
        shares: 445,
        saves: 567,
        themeColor: const Color(0xFF3B82F6),
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ];
  }

  void _toggleFollow(String accountId) {
    setState(() {
      if (_followedAccounts.contains(accountId)) {
        _followedAccounts.remove(accountId);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Non segui più questo account'),
            backgroundColor: Colors.grey[700],
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        _followedAccounts.add(accountId);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Ora segui questo account!'),
            backgroundColor: Color(0xFF6BCF7F),
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }

  Future<void> _showCameraOptions() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1E1B4B),
                Color(0xFF7C3AED),
              ],
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Crea contenuto',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                _buildCameraOption(
                  icon: Icons.videocam,
                  title: 'Registra Video',
                  subtitle: 'Crea un nuovo Reel video',
                  color: const Color(0xFFFF6B9D),
                  onTap: () => _captureVideo(),
                ),
                const SizedBox(height: 12),
                _buildCameraOption(
                  icon: Icons.camera_alt,
                  title: 'Scatta Foto',
                  subtitle: 'Crea un Reel con foto',
                  color: const Color(0xFF6BCF7F),
                  onTap: () => _capturePhoto(),
                ),
                const SizedBox(height: 12),
                _buildCameraOption(
                  icon: Icons.photo_library,
                  title: 'Galleria',
                  subtitle: 'Scegli dalla galleria',
                  color: const Color(0xFF3B82F6),
                  onTap: () => _pickFromGallery(),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCameraOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color, color.withOpacity(0.6)],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.4),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(icon, color: Colors.white, size: 30),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.7),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _captureVideo() async {
    Navigator.pop(context);
    try {
      final XFile? video = await _picker.pickVideo(
        source: ImageSource.camera,
        maxDuration: const Duration(seconds: 60),
      );
      if (video != null) {
        _showSuccessMessage('Video registrato! 🎥');
        // Qui puoi implementare l'upload del video
      }
    } catch (e) {
      _showErrorMessage('Errore durante la registrazione: $e');
    }
  }

  Future<void> _capturePhoto() async {
    Navigator.pop(context);
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );
      if (photo != null) {
        _showSuccessMessage('Foto scattata! 📸');
        // Qui puoi implementare l'upload della foto
      }
    } catch (e) {
      _showErrorMessage('Errore durante lo scatto: $e');
    }
  }

  Future<void> _pickFromGallery() async {
    Navigator.pop(context);
    try {
      final XFile? media = await _picker.pickVideo(
        source: ImageSource.gallery,
      );
      if (media != null) {
        _showSuccessMessage('Media selezionato! 🖼️');
        // Qui puoi implementare l'upload
      }
    } catch (e) {
      _showErrorMessage('Errore nella selezione: $e');
    }
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF6BCF7F),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showAccountInfo(ReelData reel) {
    final account = reel.account;
    final isFollowing = _followedAccounts.contains(account.id);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1E1B4B),
                  Color(0xFF7C3AED),
                ],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Profile Image & Verified Badge
                  Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: reel.themeColor.withOpacity(0.5),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 48,
                          backgroundColor: reel.themeColor,
                          child: Text(
                            account.displayName[0],
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      if (account.isVerified)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF7C3AED),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.verified,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Username & Display Name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        account.displayName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (account.isVerified) ...[
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.verified,
                          color: Color(0xFF6BCF7F),
                          size: 24,
                        ),
                      ],
                    ],
                  ),
                  
                  const SizedBox(height: 4),
                  
                  Text(
                    account.username,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Country & Language
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        account.languageFlag,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          account.country,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatColumn('Posts', account.posts.toString()),
                      _buildStatColumn(
                        'Followers',
                        _formatNumber(account.followers),
                      ),
                      _buildStatColumn(
                        'Following',
                        _formatNumber(account.following),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Bio
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      account.bio,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Follow Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _toggleFollow(account.id);
                          setModalState(() {}); // Update modal state
                          setState(() {}); // Update parent state
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isFollowing
                              ? Colors.white.withOpacity(0.2)
                              : const Color(0xFF7C3AED),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side: BorderSide(
                              color: isFollowing
                                  ? Colors.white.withOpacity(0.5)
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          elevation: isFollowing ? 0 : 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isFollowing ? Icons.check : Icons.person_add,
                              size: 22,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              isFollowing ? 'Stai seguendo' : 'Segui',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Joined Date
                  Text(
                    'Iscritto da ${_formatDate(account.joinedDate)}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  String _formatDate(DateTime date) {
    final months = [
      'Gen', 'Feb', 'Mar', 'Apr', 'Mag', 'Giu',
      'Lug', 'Ago', 'Set', 'Ott', 'Nov', 'Dic'
    ];
    return '${months[date.month - 1]} ${date.year}';
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
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final reel = _reels[index];
              return _buildReelPage(reel);
            },
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo + Titolo
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF7C3AED),
                              Color(0xFFA855F7),
                            ],
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
                  // Bottone camera
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt, color: Colors.white),
                      onPressed: _showCameraOptions,
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

  Widget _buildReelPage(ReelData reel) {
    final isFollowing = _followedAccounts.contains(reel.account.id);
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1E1B4B),
            reel.themeColor.withOpacity(0.3),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Centro: Video Placeholder
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
                        reel.themeColor.withOpacity(0.5),
                        reel.themeColor,
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: reel.themeColor.withOpacity(0.6),
                        blurRadius: 30,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  '🎬 Video Content',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          
          // Bottom: Info Autore
          Positioned(
            bottom: 20,
            left: 16,
            right: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar + Nome + Segui
                GestureDetector(
                  onTap: () => _showAccountInfo(reel),
                  child: Row(
                    children: [
                      // Avatar
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: reel.themeColor,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: reel.themeColor.withOpacity(0.5),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          backgroundColor: reel.themeColor,
                          child: Text(
                            reel.account.displayName[0],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Nome + Badge + Region
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  reel.account.displayName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black54,
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                ),
                                if (reel.account.isVerified) ...[
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.verified,
                                    color: Color(0xFF6BCF7F),
                                    size: 18,
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                Text(
                                  reel.account.languageFlag,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.25),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    reel.account.country,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Bottone Segui
                      GestureDetector(
                        onTap: () => _toggleFollow(reel.account.id),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            gradient: isFollowing
                                ? null
                                : const LinearGradient(
                                    colors: [
                                      Color(0xFF7C3AED),
                                      Color(0xFFA855F7),
                                    ],
                                  ),
                            color: isFollowing
                                ? Colors.white.withOpacity(0.2)
                                : null,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            boxShadow: isFollowing
                                ? []
                                : [
                                    BoxShadow(
                                      color: const Color(0xFF7C3AED)
                                          .withOpacity(0.5),
                                      blurRadius: 12,
                                      spreadRadius: 1,
                                    ),
                                  ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isFollowing ? Icons.check : Icons.add,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                isFollowing ? 'Segui' : 'Segui',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                // Descrizione
                Text(
                  reel.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                    shadows: [
                      Shadow(
                        color: Colors.black54,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          
          // Destra: Azioni Laterali
          Positioned(
            bottom: 100,
            right: 16,
            child: Column(
              children: [
                _buildActionButton(
                  Icons.favorite_border,
                  _formatNumber(reel.likes),
                  const Color(0xFFFF6B9D),
                ),
                const SizedBox(height: 28),
                _buildActionButton(
                  Icons.comment,
                  _formatNumber(reel.comments),
                  const Color(0xFF3B82F6),
                ),
                const SizedBox(height: 28),
                _buildActionButton(
                  Icons.share,
                  _formatNumber(reel.shares),
                  const Color(0xFF6BCF7F),
                ),
                const SizedBox(height: 28),
                _buildActionButton(
                  Icons.bookmark_border,
                  _formatNumber(reel.saves),
                  const Color(0xFFFFD93D),
                ),
              ],
            ),
          ),
          
          // Indicatore Pagina
          Positioned(
            right: 8,
            top: MediaQuery.of(context).size.height / 2 - 60,
            child: Column(
              children: List.generate(_reels.length, (index) {
                bool isActive = index == _currentIndex;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  width: 4,
                  height: isActive ? 28 : 10,
                  decoration: BoxDecoration(
                    gradient: isActive
                        ? const LinearGradient(
                            colors: [
                              Color(0xFF7C3AED),
                              Color(0xFFA855F7),
                            ],
                          )
                        : null,
                    color: isActive ? null : Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: const Color(0xFF7C3AED).withOpacity(0.6),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ]
                        : [],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.4),
                color.withOpacity(0.15),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            shape: BoxShape.circle,
            border: Border.all(
              color: color.withOpacity(0.6),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 12,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 28,
          ),
        ),
        if (label.isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              shadows: [
                Shadow(
                  color: Colors.black54,
                  blurRadius: 6,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}