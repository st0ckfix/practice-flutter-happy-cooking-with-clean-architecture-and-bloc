import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SelectMode { single, multi, nullableSingle, nullableMulti }

extension SelectModeExtensions on SelectMode {
  List<int> getInitialState(dynamic itemInit) {
    switch (this) {
      case SelectMode.single || SelectMode.multi:
        return itemInit ?? [0];
      case SelectMode.nullableSingle || SelectMode.nullableMulti:
        return itemInit ?? [-1];
    }
  }

  bool isSelected(List<int> state, int index) {
    switch (this) {
      case SelectMode.single || SelectMode.nullableSingle:
        return state.first == index;
      case SelectMode.multi || SelectMode.nullableMulti:
        return state.contains(index);
    }
  }
}

enum AddOnCheck { empty, leadingRadio, leadingCheckBox, trailingRadio, trailingCheckBox }

extension AddOnCheckExtension on AddOnCheck {
  Widget? getWidget(Widget layoutBuilder, bool isSelected, Function onTap) {
    Radio radio = Radio(
      value: isSelected,
      groupValue: true,
      activeColor: Colors.white,
      onChanged: (value) => onTap(),
    );
    Checkbox checkbox = Checkbox(
      value: isSelected,
      onChanged: (value) => onTap(),
    );
    switch (this) {
      case AddOnCheck.leadingCheckBox:
        return Row(
          children: [
            checkbox,
            const SizedBox(width: 10),
            layoutBuilder,
          ],
        );
      case AddOnCheck.leadingRadio:
        return Row(
          children: [
            radio,
            const SizedBox(width: 10),
            layoutBuilder,
          ],
        );
      case AddOnCheck.trailingCheckBox:
        return Row(
          children: [
            layoutBuilder,
            const Spacer(),
            checkbox,
          ],
        );
      case AddOnCheck.trailingRadio:
        return Row(
          children: [
            layoutBuilder,
            const Spacer(),
            radio,
          ],
        );
      default:
        return null;
    }
  }
}

class SelectListWidget extends StatelessWidget {
  const SelectListWidget({
    super.key,
    required this.layoutBuilder,
    required this.addOnCheck,
    required this.gridDelegate,
    required this.itemCount,
    required this.onSelect,
    this.itemInit,
    required this.selectMode,
    this.axis = Axis.vertical,
    this.selectDecoration,
    this.unSelectDecoration,
    this.margin,
    this.padding,
    this.fillColor,
    this.borderRadius,
    this.radius,
    this.shape,
    this.borderColor,
    this.borderWidth,
    this.height,
    this.width,
  });

  final Widget Function(BuildContext context, int index, bool isSelected) layoutBuilder;
  final Function(int selectValue, {List<int>? selectList}) onSelect;
  final SliverGridDelegate gridDelegate;
  final int itemCount;
  final List<int>? itemInit;
  final Axis axis;
  final BoxDecoration? selectDecoration;
  final BoxDecoration? unSelectDecoration;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? fillColor;
  final BorderRadiusGeometry? borderRadius;
  final double? radius;
  final BoxShape? shape;
  final Color? borderColor;
  final double? borderWidth;
  final double? height;
  final double? width;
  final AddOnCheck addOnCheck;
  final SelectMode selectMode;

  @override
  Widget build(BuildContext context) {
    final initialState = selectMode.getInitialState(itemInit);

    return BlocProvider(
      create: (context) => SelectCubit(selectMode, initialState),
      child: Builder(
        builder: (context) {
          final cubit = context.read<SelectCubit>();
          return SizedBox(
            height: height,
            width: width,
            child: GridView.builder(
              itemCount: itemCount,
              scrollDirection: axis,
              gridDelegate: gridDelegate,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _onItemTap(cubit, index),
                  behavior: HitTestBehavior.translucent,
                  child: BlocSelector<SelectCubit, dynamic, bool>(
                    selector: (state) => selectMode.isSelected(state, index),
                    builder: (context, isSelected) {
                      return _buildItem(context, index, isSelected, () => _onItemTap(cubit, index));
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _onItemTap(SelectCubit cubit, int index) {
    cubit.updateSelect(index);
    final selectState = cubit.state;
    onSelect(index, selectList: selectState);
  }

  Widget _buildItem(BuildContext context, int index, bool isSelected, Function onTap) {
    final decoration = isSelected
        ? selectDecoration ??
            BoxDecoration(
              color: fillColor ?? Colors.blue,
              shape: shape ?? BoxShape.rectangle,
              borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 0),
              border: Border.all(color: borderColor ?? Colors.blueAccent, width: borderWidth ?? 2),
              boxShadow: [
                BoxShadow(
                  color: (fillColor ?? Colors.blue).withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: const Offset(1, 1),
                ),
              ],
            )
        : unSelectDecoration ??
            BoxDecoration(
              color: Colors.grey[200],
              shape: shape ?? BoxShape.rectangle,
              borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 0),
              border: Border.all(color: Colors.grey, width: 1),
            );
    return Container(
      padding: padding,
      margin: margin,
      decoration: decoration,
      alignment: Alignment.center,
      child: _buildDefaultContent(context, index, isSelected, () => onTap()),
    );
  }

  Widget _buildDefaultContent(BuildContext context, int index, bool isSelected, Function onTap) {
    final content = layoutBuilder(context, index, isSelected);

    if (addOnCheck != AddOnCheck.empty) {
      return addOnCheck.getWidget(content, isSelected, () => onTap())!;
    }

    return content;
  }
}

class SelectCubit extends Cubit<List<int>> {
  final SelectMode selectMode;
  SelectCubit(this.selectMode, super.initialState);

  void updateSelect(int index) {
    final stateUpdate = _calculateNextState(index);
    if (!listEquals(stateUpdate, state)) {
      emit(stateUpdate);
    }
  }

  List<int> _calculateNextState(int index) {
    switch (selectMode) {
      case SelectMode.single:
        return [index];
      case SelectMode.nullableSingle:
        return state.first == index ? [-1] : [index];
      case SelectMode.multi || SelectMode.nullableMulti:
        if (state.contains(index)) {
          if (state.length != 1) {
            return state..remove(index);
          } else {
            return selectMode == SelectMode.multi ? state : [-1];
          }
        } else {
          return state..add(index);
        }
    }
  }
}
