import 'package:flutter/material.dart';

import '../../../core/components/spaces.dart';

class ItemWidget extends StatelessWidget {
  final String value;
  const ItemWidget({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: CircleAvatar(
              backgroundColor: Color(0xffB2B2B2),
              radius: 3,
            ),
          ),
          const SpaceWidth(8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: Color(0xffB2B2B2),
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
