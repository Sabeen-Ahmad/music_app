import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/components/MyDrawer.dart';
import 'package:music_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('S E T T I N G S'),
        centerTitle: true,
      ),body: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12)
      ),
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.all(25,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //dark mode
            Text('Dark mode',style: TextStyle(fontWeight: FontWeight.bold,),),
            //switch
            CupertinoSwitch(
              // Step 3: Access the provider using context

            value: Provider.of<ThemeProvider>(context, listen:false).isDarkMode,

                onChanged: (value)=> Provider.of<ThemeProvider>(context, listen:false).toggleTheme(),
            ),
            //light mode
           ],
        ),
      ),
    );
  }
}
