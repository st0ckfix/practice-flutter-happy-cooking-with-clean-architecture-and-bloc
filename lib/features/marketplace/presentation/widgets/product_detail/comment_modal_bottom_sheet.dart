import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommentModalBottomSheet extends StatefulWidget {
  const CommentModalBottomSheet({
    super.key,
  });

  @override
  State<CommentModalBottomSheet> createState() => _CommentModalBottomSheetState();
}

class _CommentModalBottomSheetState extends State<CommentModalBottomSheet> {
  final FocusNode _focusNode = FocusNode();
  double _currentChildSize = 0.55;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _currentChildSize = 1.0;
        });
      } else {
        setState(() {
          _currentChildSize = 0.55;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: _currentChildSize,
      maxChildSize: 1,
      snap: true,
      expand: false,
      snapSizes: const [0.55, 1],
      builder: (context, scrollController) {
        return Stack(
          children: [
            ListView(
              controller: scrollController,
              padding: const EdgeInsets.only(top: 40, bottom: 30),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            minRadius: 15,
                            maxRadius: 15,
                            backgroundColor: Colors.amber,
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(),
                              ),
                              child: const ListTile(
                                title: Text('John Cena'),
                                subtitle: Text.rich(
                                  TextSpan(
                                    text: 'I feel the same way',
                                    children: [
                                      TextSpan(
                                        text: '\n5 days ago',
                                        style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                ),
                                isThreeLine: true,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        minRadius: 15,
                        maxRadius: 15,
                        backgroundColor: Colors.amber,
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(),
                          ),
                          child: const ListTile(
                            title: Text('Wick Yu'),
                            subtitle: Text.rich(
                              TextSpan(
                                text: 'Yick !!!',
                                children: [
                                  TextSpan(
                                    text: '\n2 days ago',
                                    style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                            ),
                            isThreeLine: true,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  const Divider(thickness: 1, height: 1),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: TextField(
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.send),
                        ),
                        hintText: 'Write a comment...',
                        border: const OutlineInputBorder(),
                      ),
                      focusNode: _focusNode,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                child: const Column(
                  children: [
                    Text('Comment (2)'),
                    SizedBox(height: 10),
                    Divider(thickness: 1, height: 1),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
