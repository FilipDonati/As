// lib/presentation/screens/tab_videocall/incoming_call_screen.dart
import 'package:flutter/material.dart';
import '../videocall_screen.dart';

class IncomingCallScreen extends StatefulWidget {
  /// Display name of the caller (shown as primary label).
  final String callerName;

  /// Username of the caller (shown as @handle).
  final String callerUsername;

  /// Optional avatar URL for the caller's profile picture.
  final String? callerAvatarUrl;

  /// Called when the user accepts the incoming call.
  final Future<void> Function()? onAccept;

  /// Called when the user rejects the incoming call.
  final Future<void> Function()? onReject;

  const IncomingCallScreen({
    super.key,
    required this.callerName,
    required this.callerUsername,
    this.callerAvatarUrl,
    this.onAccept,
    this.onReject,
  });

  @override
  State<IncomingCallScreen> createState() => _IncomingCallScreenState();
}

class _IncomingCallScreenState extends State<IncomingCallScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;
  bool _isBusy = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleReject() async {
    if (_isBusy) return;
    setState(() => _isBusy = true);
    try {
      await widget.onReject?.call();
    } finally {
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  Future<void> _handleAccept() async {
    if (_isBusy) return;
    setState(() => _isBusy = true);
    try {
      await widget.onAccept?.call();
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ScreenVideoCall()),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isBusy = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Errore durante l\'accettazione della chiamata: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 60),

            // Caller info
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Pulsing avatar
                  ScaleTransition(
                    scale: _pulseAnimation,
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: primaryColor,
                          width: 3,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 65,
                        backgroundImage: widget.callerAvatarUrl != null
                            ? NetworkImage(widget.callerAvatarUrl!)
                            : null,
                        child: widget.callerAvatarUrl == null
                            ? const Icon(Icons.person, size: 60)
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Caller name
                  Text(
                    widget.callerName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Caller username
                  Text(
                    '@${widget.callerUsername}',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Status label
                  const Text(
                    'Chiamata in arrivo...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            // Action buttons
            Padding(
              padding: const EdgeInsets.all(40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Reject
                  _CallActionButton(
                    icon: Icons.call_end,
                    label: 'Rifiuta',
                    color: Colors.red,
                    onTap: _isBusy ? null : _handleReject,
                  ),

                  // Accept
                  _CallActionButton(
                    icon: Icons.call,
                    label: 'Accetta',
                    color: Colors.green,
                    onTap: _isBusy ? null : _handleAccept,
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

class _CallActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const _CallActionButton({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: onTap == null ? color.withOpacity(0.4) : color,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(icon, color: Colors.white, size: 32),
            onPressed: onTap,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }
}