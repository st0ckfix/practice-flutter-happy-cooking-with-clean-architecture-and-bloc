import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraint) {
        final user = FirebaseAuth.instance.currentUser!;
        return Container(
          color: Colors.redAccent,
          height: constraint.maxHeight,
          width: constraint.maxWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                user.displayName ?? 'USER_54875X8a5d21',
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                user.email.toString(),
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                user.uid.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      }),
    );
  }
}
