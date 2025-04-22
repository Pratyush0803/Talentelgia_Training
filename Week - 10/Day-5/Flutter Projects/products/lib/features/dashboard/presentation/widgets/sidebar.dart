import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';

class Sidebar extends StatelessWidget {
  final Function(int) onMenuItemTapped;
  final int selectedIndex;

  const Sidebar({
    super.key,
    required this.onMenuItemTapped,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Add Products', null),
      ('Add Category', null),
      ('Category Management', null),
    ];

    return Container(
      width: 280,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Blibkit',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Center(
              child: Text(
                'Admin Panel',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const Divider(color: Colors.grey, thickness: 1),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final (itemName, icon) = items[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      onMenuItemTapped(index);
                      switch (index) {
                        case 0:
                          context.go('/home/add-products');
                          break;
                        case 1:
                          context.go('/home/add-category');
                          break;
                        case 2:
                          context.go('/home/manage-categories');
                          break;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      selectedIndex == index ? Colors.green[100] : Colors.white,
                      foregroundColor: Colors.green[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: selectedIndex == index ? 4 : 0,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        itemName,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: selectedIndex == index
                              ? Colors.green[900]
                              : Colors.green[700],
                          fontWeight: selectedIndex == index
                              ? FontWeight.bold
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                print('Sidebar AuthBloc state: $state');
                if (state is AuthFailure) {
                  print('Logout failed: ${state.message}');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                } else if (state is AuthInitial) {
                  print('Redirecting to /login after logout');
                  context.go('/login');
                }
              },
              builder: (context, state) {
                final isLoading = state is AuthLoading;
                return ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                    print('Logout button pressed');
                    context.read<AuthBloc>().add(LogoutRequested());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[700],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  )
                      : const Text(
                    'Logout',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}