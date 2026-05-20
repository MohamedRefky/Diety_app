import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Core/utils/Colors.dart';
import '../../Auth/views/login_view.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../view/contact_us_view.dart';
import '../widget/styles.dart';

class ProfileActions extends StatelessWidget {
  const ProfileActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUnauthenticated) {
          // If unauthenticated (logged out or deleted), redirect to login/signup.
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginView()),
            (Route<dynamic> route) => false,
          );
        } else if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Column(
        children: [
          _buildActionRow(
            context,
            title: 'Contact With Us',
            icon: Icons.message_outlined,
            color: Colors.blue,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ContactUsView()),
              );
            },
          ),
          const SizedBox(height: 8),
          _buildActionRow(
            context,
            title: 'Log out',
            icon: Icons.logout,
            color: AppColors.white,
            onTap: () => context.read<ProfileCubit>().logout(),
          ),
          const SizedBox(height: 8),
          _buildActionRow(
            context,
            title: 'Delete Account',
            icon: Icons.delete,
            color: Colors.red,
            onTap: () async {
              final profileCubit = context.read<ProfileCubit>();
              bool confirmDelete = await _showConfirmationDialog(context);
              if (confirmDelete) {
                profileCubit.deleteAccount();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionRow(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        color: const Color(0xff151724),
        child: Row(
          mainAxisAlignment: title == 'Contact With Us' ? MainAxisAlignment.center : MainAxisAlignment.end,
          children: [
            Text(
              title,
              style: getbodyStyle(fontSize: 18, color: title == 'Contact With Us' ? Colors.blue : null),
            ),
            IconButton(
              onPressed: onTap,
              icon: Icon(icon, color: color),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm Delete'),
            content: const Text('Are you sure you want to delete your account?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Delete', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ) ??
        false;
  }
}
