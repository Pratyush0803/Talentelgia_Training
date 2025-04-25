import 'package:blibkit_warehouse/features/settings/presentation/widgets/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';

class SettingsScreen extends StatefulWidget {
  static final name = "Settings";
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 35, top: 25, right: 35),
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            String initial = "A";
            String? photoUrl;
            String email = "";

            if (state is SettingsLoaded) {
              email = state.settingsEntity.email;
              photoUrl = state.settingsEntity.userImage.isNotEmpty
                  ? state.settingsEntity.userImage
                  : null;
              initial = email.isNotEmpty ? email[0].toUpperCase() : "A";
            } else if (state is SettingsError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              });
            }

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: CircleAvatar(
                            backgroundColor: const Color(0xFFCFF9CF),
                            radius: 40,
                            backgroundImage: photoUrl != null
                                ? NetworkImage(photoUrl)
                                : null,
                            child: photoUrl == null
                                ? Text(
                              initial,
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            )
                                : null,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: IconButton(
                            onPressed: () {
                            },
                            icon: HugeIcon(
                              icon: HugeIcons.strokeRoundedUserEdit01,
                              color: Colors.black,
                              size: 28,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  email.isNotEmpty ? email : "Loading...",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 30),
                _buildMenuItem(
                  icon: LucideIcons.user,
                  title: "Edit Profile",
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: LucideIcons.bell,
                  title: "Notifications",
                  onTap: () {
                    context.goNamed(NotificationScreen.name);
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
                  icon: LucideIcons.settings,
                  title: "Settings",
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
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    if (context.mounted) {
                      context.go('/login');
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 15),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}