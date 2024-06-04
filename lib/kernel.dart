import 'package:adir_web_app/utils/prefs_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class Launcher extends StatelessWidget {
  const Launcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      child: const Kernel(),
      create: (context) =>
          PrefsData(UserHolder(null), ApplicationPreferences(), DataHolder()),
    );
  }
}

class Kernel extends StatefulWidget {
  const Kernel({Key? key}) : super(key: key);

  @override
  State<Kernel> createState() => _KernelState();
}

class _KernelState extends State<Kernel> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(data: Theme.of(context), child: const MyApp());
  }
}
