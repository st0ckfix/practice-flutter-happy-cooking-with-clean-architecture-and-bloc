import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/config/theme/size.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const Column(
        children: [
          ThemeWidget(),
          Divider(
            thickness: 2,
            height: 2,
          ),
          FontWidget(),
          Divider(
            thickness: 2,
            height: 2,
          ),
          LanguageWidget()
        ],
      ),
    );
  }
}

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(formHeight),
          child: Text(
            'Language',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            children: [
              Text(
                'Language Display',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ListTile(
                    title: Text(
                      
                      'English',
                      textAlign: TextAlign.end,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class FontWidget extends StatelessWidget {
  const FontWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(formHeight),
          child: Text(
            'Fonts',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            children: [
              Text(
                'Font Family',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ListTile(
                    title: Text(
                      'Default font',
                      textAlign: TextAlign.end,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            children: [
              Text(
                'Font Size',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ListTile(
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(formHeight),
          child: Text(
            'Theme',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(
          child: Row(
            children: [
              ThemSelectWidget(
                label: 'Light',
                widget: ThemeBackgroundWidget(
                  gradient: LinearGradient(colors: [Colors.white, Colors.white]),
                  textColor: Colors.black,
                ),
              ),
              ThemSelectWidget(
                label: 'Dark',
                widget: ThemeBackgroundWidget(
                  gradient: LinearGradient(colors: [Colors.black, Colors.black]),
                  textColor: Colors.white,
                ),
              ),
              ThemSelectWidget(
                label: 'System',
                widget: SizedBox(
                  height: 88,
                  child: Row(
                    children: [
                      ClipRect(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          widthFactor: 0.5,
                          child: ThemeBackgroundWidget(gradient: LinearGradient(colors: [Colors.white, Colors.white]), textColor: Colors.black),
                        ),
                      ),
                      ClipRect(
                        child: Align(
                          alignment: Alignment.centerRight,
                          widthFactor: 0.5,
                          child: ThemeBackgroundWidget(gradient: LinearGradient(colors: [Colors.black, Colors.black]), textColor: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ThemSelectWidget extends StatelessWidget {
  const ThemSelectWidget({
    super.key,
    required this.label,
    required this.widget,
  });

  final String label;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          widget,
          ListTile(
            leading: Radio(
              value: false,
              groupValue: [1, 2, 3],
              onChanged: (value) {},
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
            ),
            contentPadding: EdgeInsets.zero,
            title: Text(label),
          )
        ],
      ),
    );
  }
}

class ThemeBackgroundWidget extends StatelessWidget {
  const ThemeBackgroundWidget({
    super.key,
    required this.gradient,
    required this.textColor,
  });

  final Gradient gradient;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        gradient: gradient,
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 10,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            'This is a \ndisplay of \nsome text',
            style: TextStyle(color: textColor),
          )
        ],
      ),
    );
  }
}
