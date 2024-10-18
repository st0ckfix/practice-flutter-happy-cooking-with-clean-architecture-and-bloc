import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class FontFamilyPage extends StatelessWidget {
  const FontFamilyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
        title: const Text(
          'Change Font',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Default Font'),
            trailing: Icon(LineAwesomeIcons.check_solid),
          ),
          Divider(height: 2, thickness: 2,),
          ListTile(
            title: Text('System Font'),
            trailing: Icon(LineAwesomeIcons.check_solid),
          ),
        ],
      ),
    );
  }
}