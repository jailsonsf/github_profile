import 'package:flutter/material.dart';
import 'package:github_profile/widgets/custom_button_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('GitHub Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Center(
            child: Container(
              width: 200,
              height: 200,
              child: Image.asset('assets/original.png'),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Digite o github username',
                suffixIcon: IconButton(
                  onPressed: _textEditingController.clear,
                  icon: const Icon(Icons.clear),
                ),
              ),
              onSubmitted: (text) {
                Navigator.of(context).pushNamed(
                  '/profile',
                  arguments: text,
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: CustomButtonWidget(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/profile',
                  arguments: _textEditingController.text,
                );
              },
              title: 'Buscar Perfil',
              titleSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
