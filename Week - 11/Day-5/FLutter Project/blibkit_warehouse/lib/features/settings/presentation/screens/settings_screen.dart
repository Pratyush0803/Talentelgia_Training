import 'package:blibkit_warehouse/features/settings/presentation/widgets/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';

class SettingsScreen extends StatefulWidget {
  static const name = "Settings";

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SettingsBloc>().add(LoadUserProfile());
  }

  @override
  Widget build(BuildContext context) {
    // Theme colors
    const primaryColor = Color(0xFF4CAF50); // Softer green
    // Light green

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 28,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Main Content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: BlocBuilder<SettingsBloc, SettingsState>(
                  builder: (context, state) {
                    String initial = "A";
                    String? photoUrl;
                    String email = "";

                    if (state is SettingsLoaded) {
                      email = state.settingsEntity.email;
                      photoUrl =
                          state.settingsEntity.userImage.isNotEmpty
                              ? state.settingsEntity.userImage
                              : null;
                      initial = email.isNotEmpty ? email[0].toUpperCase() : "A";
                    } else if (state is SettingsError) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.redAccent,
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      });
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Profile Header
                        Container(
                          decoration: BoxDecoration(
                            color: primaryColor, // Solid color
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.only(bottom: 24),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 48,
                                    backgroundImage:
                                        photoUrl != null
                                            ? NetworkImage(photoUrl)
                                            : null,
                                    child:
                                        photoUrl == null
                                            ? Text(
                                              initial,
                                              style: const TextStyle(
                                                fontSize: 45,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            )
                                            : null,
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        // Implement edit profile photo logic
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                        ),
                                        child: const Icon(
                                          LucideIcons.edit,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      email.isNotEmpty ? email : "Loading...",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Manage your account",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Menu Items
                        ...[
                          _buildMenuItem(
                            icon: LucideIcons.user,
                            title: "Edit Profile",
                            onTap: () {},
                          ),
                          _buildMenuItem(
                            icon: LucideIcons.bell,
                            title: "Notifications",
                            onTap: () {},
                          ),
                          _buildMenuItem(
                            icon: LucideIcons.mapPin,
                            title: "Location",
                            onTap: () {
                              context.goNamed(LocationScreen.name);
                            },
                          ),
                          _buildMenuItem(
                            icon: LucideIcons.fileText,
                            title: "Order History",
                            onTap: () {},
                          ),
                          _buildMenuItem(
                            icon: LucideIcons.languages,
                            title: "Language",
                            onTap: () {},
                          ),
                          _buildMenuItem(
                            icon: LucideIcons.shieldQuestion,
                            title: "Help Center",
                            onTap: () {},
                          ),
                          _buildMenuItem(
                            icon: LucideIcons.arrowRightSquare,
                            title: "Log Out",
                            textColor: Colors.redAccent,
                            onTap: () async {
                              await FirebaseAuth.instance.signOut();
                              if (context.mounted) {
                                context.go('/login');
                              }
                            },
                          ),
                        ].asMap().entries.map((entry) {
                          final index = entry.key;
                          final widget = entry.value;
                          return widget
                              .animate()
                              .fadeIn(duration: 300.ms, delay: (100 * index).ms)
                              .slideY(begin: 0.2, end: 0, duration: 300.ms);
                        }),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color textColor = Colors.black87,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xFF4CAF50),
        size: 24,
        semanticLabel: title,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: textColor,
        ),
      ),
      trailing: const Icon(
        LucideIcons.chevronRight,
        color: Colors.grey,
        size: 20,
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      tileColor: Colors.white,
      visualDensity: VisualDensity.compact,
    );
  }
}
