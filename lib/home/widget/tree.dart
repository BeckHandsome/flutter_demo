
import 'package:flutter/material.dart';

class TreeItem {
  final String label;
  final bool expaned;
  final List<TreeItem> children;

  TreeItem({
    @required this.label,
    @required this.expaned,
    @required this.children,
  });

  factory TreeItem.fromMap(Map<String, dynamic> map) => TreeItem(
        label: map['label'],
        expaned: map['expaned'],
        children:
            (map['children'] as List).map((i) => TreeItem.fromMap(i)).toList(),
      );
}
class TreeNode extends StatefulWidget {
  final TreeItem item;
  final int level;

  final Widget leading;
  final double offsetLeft;
  final Widget expanedIcon;

  final Function labelOnTap;
  final Function leadingOnTap;

  const TreeNode({
    @required this.item,
    this.level = 0,
    this.leading = const IconButton(icon: Icon(Icons.list), onPressed: null),
    this.labelOnTap,
    this.leadingOnTap,
    this.offsetLeft = 24.0,
    this.expanedIcon = const Icon(Icons.expand_more),
  })  : assert(item != null),
        assert(leading != null && leadingOnTap == null);

  @override
  _TreeNodeState createState() => _TreeNodeState();
}

class _TreeNodeState extends State<TreeNode>
    with SingleTickerProviderStateMixin {
  bool _isExpaned = false;

  AnimationController _rotationController;
  final Tween<double> _turnsTween = Tween<double>(begin: 0.0, end: -0.5);

  initState() {
    _isExpaned = widget.item.expaned;
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TreeItem item = widget.item;
    final int level = widget.level;
    final Widget leading = widget.leading;
    final double offsetLeft = widget.offsetLeft;
    final List<TreeItem> children = item.children;
    final Widget expanedIcon = widget.expanedIcon;

    final Function labelOnTap = widget.labelOnTap;

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: labelOnTap,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    item.label,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: children.length > 0,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _isExpaned = !_isExpaned;
                    if (_isExpaned) {
                      _rotationController.forward();
                    } else {
                      _rotationController.reverse();
                    }
                  });
                },
                icon: RotationTransition(
                  child: expanedIcon,
                  turns: _turnsTween.animate(_rotationController),
                ),
              ),
            ),
          ],
        ),
        Visibility(
          visible: children.length > 0 && _isExpaned,
          child: Padding(
            padding: EdgeInsets.only(left: level + 1 * offsetLeft),
            child: Column(
              children: List.generate(children.length, (int index) {
                return TreeNode(
                  item: children[index],
                  leading: leading,
                  offsetLeft: offsetLeft,
                  expanedIcon: expanedIcon,
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
class TreeView extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  final String labelKey;
  final String expanedKey;
  final String childrenKey;

  final Widget leading;
  final double offsetLeft;
  final Widget expanedIcon;

  final Function labelOnTap;
  final Function leadingOnTap;

  const TreeView({
    @required this.data,
    this.leading = const IconButton(icon: Icon(Icons.list), onPressed: null),
    this.labelOnTap,
    this.leadingOnTap,
    this.labelKey = 'label',
    this.expanedKey = 'expaned',
    this.childrenKey = 'children',
    this.expanedIcon = const Icon(Icons.expand_more),
    this.offsetLeft = 24.0,
  })  : assert(data != null),
        assert(leading != null && leadingOnTap == null);

  TreeItem _itemFromMap(Map<String, dynamic> map) => TreeItem(
        label: map[labelKey],
        expaned: map[expanedKey],
        children:
            (map[childrenKey] as List).map((i) => _itemFromMap(i)).toList(),
      );

  @override
  Widget build(BuildContext context) {
    final List<TreeItem> items = data.map((d) => _itemFromMap(d)).toList();

    return ListView(
      children: List.generate(items.length, (int index) {
        return TreeNode(
          item: items[index],
          level: 0,
          leading: leading,
          labelOnTap: labelOnTap,
          leadingOnTap: leadingOnTap,
          offsetLeft: offsetLeft,
          expanedIcon: expanedIcon,
        );
      }),
    );
  }
}