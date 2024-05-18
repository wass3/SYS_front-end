// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class LargeCardList extends StatelessWidget {
  const LargeCardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        LargeCard(),
        const SizedBox(height: 16),
        LargeCard(),
        const SizedBox(height: 16),
        LargeCard(),
        const SizedBox(height: 16),
        LargeCard(),
      ],
    );
  }
}

class LargeCard extends StatelessWidget {
  const LargeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xff333534),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Large Card',
              style: TextStyle(color: const Color(0xff050d09), fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce consectetur tortor vitae dolor laoreet, et pretium ligula aliquet.',
              style: TextStyle(color: const Color(0xff050d09)),
            ),
          ],
        ),
      ),
    );
  }
}
