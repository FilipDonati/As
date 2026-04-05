// lib/presentation/screens/tab_account/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io';
import '../../../data/models/user_model.dart';
import '../../../data/models/reel_model.dart';
import '../../../data/local/user_repository.dart';
import '../../../data/remote/reel_repository.dart';
import '../../../services/db_client/storage_service.dart';
import '../tab_reel_screen/reels_screen.dart';
import '../videocall_screen.dart';
import '../../log_register/login_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String? userId;

  const ProfileScreen({super.key, this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserRepository _userRepository = UserRepository();
  final ReelRepository _reelRepository = ReelRepository();
  final StorageService _storageService = StorageService();

  UserModel? _profileUser;
  List<ReelModel> _userReels = [];
  bool _isLoadingProfile = true;
  bool _isLoadingReels = false;
  int _followersCount = 0;
  int _followingCount = 0;
  bool _isFollowing = false;
  bool _isOwnProfile = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _loadProfile();
    await _loadUserReels();
  }

  Future<void> _loadProfile() async {
    setState(() => _isLoadingProfile = true);
    try {
      if (widget.userId != null) {
        _profileUser = await _userRepository.getUserById(widget.userId!);
        _isOwnProfile = false;
        await Future.wait([
          _loadFollowersCount(widget.userId!),
          _loadFollowingCount(widget.userId!),
          _checkIfFollowing(widget.userId!),
        ]);
      } else {
        _profileUser = await _userRepository.watchCurrentUser().first;
        _isOwnProfile = true;
        if (_profileUser != null) {
          await Future.wait([
            _loadFollowersCount(_profileUser!.id),
            _loadFollowingCount(_profileUser!.id),
          ]);
        }
      }
    } catch (e) {
      debugPrint('Errore caricamento profilo: $e');
    } finally {
      if (mounted) setState(() => _isLoadingProfile = false);
    }
  }

  Future<void> _loadFollowersCount(String userId) async {
    try {
      final count = await _userRepository.getFollowersCount(userId);
      if (mounted) setState(() => _followersCount = count);
    } catch (e) {
      debugPrint('Errore followers count: $e');
    }
  }

  Future<void> _loadFollowingCount(String userId) async {
    try {
      final count = await _userRepository.getFollowingCount(userId);
      if (mounted) setState(() => _followingCount = count);
    } catch (e) {
      debugPrint('Errore following count: $e');
    }
  }

  Future<void> _checkIfFollowing(String userId) async {
    try {
      final following = await _userRepository.isFollowing(userId);
      if (mounted) setState(() => _isFollowing = following);
    } catch (e) {
      debugPrint('Errore check following: $e');
    }
  }

  Future<void> _loadUserReels() async {
    setState(() => _isLoadingReels = true);
    try {
      final userId = widget.userId ?? _profileUser?.id;
      if (userId != null) {
        final reels = await _reelRepository.getUserReels(userId);
        if (mounted) setState(() => _userReels = reels);
      }
    } catch (e) {
      debugPrint('Errore caricamento reels: $e');
    } finally {
      if (mounted) setState(() => _isLoadingReels = false);
    }
  }

  Future<void> _toggleFollow() async {
    if (_profileUser == null) return;
    try {
      if (_isFollowing) {
        await _userRepository.unfollowUser(_profileUser!.id);
        setState(() {
          _isFollowing = false;
          _followersCount--;
        });
      } else {
        await _userRepository.followUser(_profileUser!.id);
        setState(() {
          _isFollowing = true;
          _followersCount++;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Errore durante l\'operazione')),
        );
      }
    }
  }

  Future<void> _pickAndUpdateAvatar() async {
    final File? image = await _storageService.pickImage();
    if (image == null) return;
    try {
      final avatarUrl = await _userRepository.updateAvatar(image);
      if (mounted) {
        setState(() {
          _profileUser = _profileUser?.copyWith(avatarUrl: avatarUrl);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Errore aggiornamento avatar')),
        );
      }
    }
  }

  void _showAvatarOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Cambia foto profilo'),
              onTap: () {
                Navigator.pop(context);
                _pickAndUpdateAvatar();
              },
            ),
            if (_profileUser?.avatarUrl != null)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text(
                  'Rimuovi foto profilo',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
    );
  }

  void _showSettingsMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Impostazioni'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('Abbonamento'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showFollowersList() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _UserListSheet(
        title: 'Followers',
        loadUsers: () => _userRepository.getFollowers(
          widget.userId ?? _profileUser!.id,
        ),
      ),
    );
  }

  void _showFollowingList() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _UserListSheet(
        title: 'Seguiti',
        loadUsers: () => _userRepository.getFollowing(
          widget.userId ?? _profileUser!.id,
        ),
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    if (_isLoadingProfile) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final user = _profileUser;
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('Profilo non trovato')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(user.username),
        actions: [
          if (_isOwnProfile)
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: _showSettingsMenu,
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Header con info utente
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Avatar e stats
                    Row(
                      children: [
                        // Avatar
                        GestureDetector(
                          onTap: _isOwnProfile ? _showAvatarOptions : null,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: user.avatarUrl != null
                                    ? CachedNetworkImageProvider(user.avatarUrl!)
                                    : null,
                                child: user.avatarUrl == null
                                    ? Text(
                                        user.username[0].toUpperCase(),
                                        style: const TextStyle(fontSize: 32),
                                      )
                                    : null,
                              ),
                              if (_isOwnProfile)
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 32),
                        // Stats
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _StatColumn(
                                count: _userReels.length,
                                label: 'Reels',
                              ),
                              GestureDetector(
                                onTap: _showFollowersList,
                                child: _StatColumn(
                                  count: _followersCount,
                                  label: 'Followers',
                                ),
                              ),
                              GestureDetector(
                                onTap: _showFollowingList,
                                child: _StatColumn(
                                  count: _followingCount,
                                  label: 'Seguiti',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Nome e bio
                    if (user.displayName != null) ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          user.displayName!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                    if (user.bio != null) ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          user.bio!,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                    // Info aggiuntive
                    _buildUserInfo(user),
                    const SizedBox(height: 16),
                    // Pulsanti azione
                    if (_isOwnProfile)
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const EditProfileScreen(),
                                  ),
                                );
                              },
                              child: const Text('Modifica Profilo'),
                            ),
                          ),
                        ],
                      )
                    else
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _toggleFollow,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isFollowing
                                    ? Colors.grey[300]
                                    : primaryColor,
                                foregroundColor: _isFollowing
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              child: Text(
                                _isFollowing ? 'Non seguire più' : 'Segui',
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          OutlinedButton(
                            onPressed: () {},
                            child: const Icon(Icons.message_outlined),
                          ),
                          const SizedBox(width: 8),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ScreenVideoCall(),
                                ),
                              );
                            },
                            child: const Icon(Icons.video_call_outlined),
                          ),
                        ],
                      ),
                    // Badge abbonamento
                    if (user.isPremiumUser) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [primaryColor, secondaryColor],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, color: Colors.white, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              user.subscriptionType.value.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Divider(height: 1),
              // Grid reels
              _isLoadingReels
                  ? const Padding(
                      padding: EdgeInsets.all(32),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : _userReels.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.video_library_outlined,
                                size: 64,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _isOwnProfile
                                    ? 'Nessun reel pubblicato'
                                    : 'Nessun reel disponibile',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 9 / 16,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2,
                          ),
                          itemCount: _userReels.length,
                          itemBuilder: (context, index) {
                            final reel = _userReels[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const ScreenReels(),
                                  ),
                                );
                              },
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  if (reel.thumbnailUrl != null)
                                    CachedNetworkImage(
                                      imageUrl: reel.thumbnailUrl!,
                                      fit: BoxFit.cover,
                                    )
                                  else
                                    Container(
                                      color: Colors.grey[300],
                                      child: const Icon(
                                          Icons.play_circle_outline),
                                    ),
                                  Positioned(
                                    bottom: 4,
                                    left: 4,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.play_arrow,
                                            color: Colors.white,
                                            size: 12,
                                          ),
                                          const SizedBox(width: 2),
                                          Text(
                                            _formatCount(reel.viewsCount),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(UserModel user) {
    return Column(
      children: [
        if (user.age > 0)
          _InfoRow(
            icon: Icons.cake_outlined,
            text: '${user.age} anni',
          ),
        if (user.nationality != null)
          _InfoRow(
            icon: Icons.flag_outlined,
            text: user.nationality!,
          ),
        if (user.consecutiveLoginDays > 0)
          _InfoRow(
            icon: Icons.local_fire_department_outlined,
            text: '${user.consecutiveLoginDays} giorni di streak',
          ),
      ],
    );
  }
}

class _UserListSheet extends StatefulWidget {
  final String title;
  final Future<List<UserModel>> Function() loadUsers;

  const _UserListSheet({
    required this.title,
    required this.loadUsers,
  });

  @override
  State<_UserListSheet> createState() => _UserListSheetState();
}

class _UserListSheetState extends State<_UserListSheet> {
  List<UserModel> _users = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final users = await widget.loadUsers();
      if (mounted) setState(() => _users = users);
    } catch (e) {
      debugPrint('Errore caricamento utenti: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              widget.title,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _users.length,
                    itemBuilder: (context, index) {
                      final user = _users[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: user.avatarUrl != null
                              ? CachedNetworkImageProvider(user.avatarUrl!)
                              : null,
                          child: user.avatarUrl == null
                              ? Text(user.username[0].toUpperCase())
                              : null,
                        ),
                        title: Text(user.displayName ?? user.username),
                        subtitle: Text('@${user.username}'),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProfileScreen(userId: user.id),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final int count;
  final String label;

  const _StatColumn({
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}