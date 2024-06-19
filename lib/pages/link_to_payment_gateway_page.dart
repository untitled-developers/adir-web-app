import 'package:adir_web_app/pages/questions_page/questions_page.dart';
import 'package:adir_web_app/pages/questions_page/widgets/hello_im_lisa_widget.dart';
import 'package:adir_web_app/utils/prefs_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LinkToPaymentGatewayPage extends StatelessWidget {
  const LinkToPaymentGatewayPage({super.key});

  @override
  Widget build(BuildContext context) {
    String userName = Provider.of<PrefsData>(context).user?.firstName ?? 'User';
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            helloImLisaWidget(),
            const SizedBox(height: 100),
            Text('Hi, $userName'),
            Text('Thank You!', style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 50),
            Text('You will be redirected to our payment provider'),
            const SizedBox(height: 50),
            TextButton(
                onPressed: () {}, child: Text('Link to payment gateway')),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const QuestionsPage(index: 8))),
                  child: const Text('Proceed my application'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
