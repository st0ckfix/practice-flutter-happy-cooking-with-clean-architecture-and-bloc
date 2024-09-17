import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:happy_cooking/features/phone_vertify/presentation/cubit/count_cubit.dart';

final CountCubit countCubit = CountCubit();
final FirebaseAuth auth = FirebaseAuth.instance;

class VertifyPage extends StatefulWidget {
  const VertifyPage({super.key});
  @override
  createState() => _VertifyPageState();
}

class _VertifyPageState extends State<VertifyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
