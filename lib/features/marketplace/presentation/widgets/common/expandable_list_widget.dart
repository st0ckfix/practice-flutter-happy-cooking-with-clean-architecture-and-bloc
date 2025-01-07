import 'package:flutter/material.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/inkwell_text_widget.dart';

class ExpandableListWidget extends StatefulWidget {
  const ExpandableListWidget({
    super.key,
    required this.listWidget,
    required this.collapsePositions,
    this.expanseWidget,
    this.collapseWidget,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final List<Widget> listWidget;
  final List<int> collapsePositions;
  final Widget? expanseWidget;
  final Widget? collapseWidget;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  State<ExpandableListWidget> createState() => _ExpandableListWidgetState();
}

class _ExpandableListWidgetState extends State<ExpandableListWidget> {
  List<Widget> collapseListWidget = [];
  List<Widget> expanseListWidget = [];
  bool isExpanded = false;
  bool holdOldWidget = false;

  void onExpanse() {
    setState(
      () => isExpanded = true,
    );
  }

  void onCollapse() {
    setState(
      () => isExpanded = false,
    );
  }

  void initList() {
    collapseListWidget.clear();
    for (final item in widget.listWidget.indexed) {
      if (widget.collapsePositions.contains(item.$1)) {
        collapseListWidget.add(item.$2);
      }
    }
    collapseListWidget.add(
      widget.expanseWidget == null
          ? InkWellTextWidget(
              'Show more',
              margin: const EdgeInsets.symmetric(vertical: 10),
              onClick: () => onExpanse(),
            )
          : InkWell(
              onTap: () => onExpanse,
              child: widget.expanseWidget,
            ),
    );
    expanseListWidget = List<Widget>.from(widget.listWidget)
      ..add(
        widget.collapseWidget == null
            ? InkWellTextWidget(
                'Show less',
                margin: const EdgeInsets.symmetric(vertical: 10),
                onClick: () => onCollapse(),
              )
            : InkWell(
                onTap: () => onCollapse,
                child: widget.collapseWidget,
              ),
      );
  }

  @override
  void initState() {
    super.initState();
    initList();
  }

  @override
  void didUpdateWidget(covariant ExpandableListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.collapsePositions != widget.collapsePositions) {
      initList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: widget.crossAxisAlignment,
      children: isExpanded ? expanseListWidget : collapseListWidget,
    );
  }
}
