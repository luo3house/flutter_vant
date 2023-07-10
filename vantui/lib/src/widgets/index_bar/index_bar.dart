import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter_vantui/src/widgets/_util/with_delayed.dart';
import 'package:flutter_vantui/src/widgets/index_bar/anchor_state.dart';
import 'package:tailstyle/tailstyle.dart';

import '../_util/has_next_widget.dart';

// @DocsId("indexbar")

class IndexBar extends StatefulWidget {
  static const defaultCellExtent = 44.0;

  // @DocsProp("children", "List<IndexBarAnchor | Cell | Widget>", "子项或锚点")
  final List<Widget>? children;
  // @DocsProp("cellExtent", "double", "子项高度")
  final double? cellExtent;

  const IndexBar({
    this.children,
    this.cellExtent,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return IndexBarState();
  }
}

class IndexBarState extends State<IndexBar> {
  @override
  Widget build(BuildContext context) {
    final cellExtent = widget.cellExtent ?? IndexBar.defaultCellExtent;
    final children = widget.children ?? const [];

    // extents of anchors including children inside
    final extentsOfAnchor = <IndexBarAnchor, double>{};
    IndexBarAnchor? lastWalkIndex;
    for (var i = 0; i < children.length; i++) {
      final child = children[i];
      assert(i != 0 || child is IndexBarAnchor, "leading must be an anchor");

      if (child is IndexBarAnchor) {
        lastWalkIndex = child;
      } else if (lastWalkIndex != null) {
        final height = extentsOfAnchor[lastWalkIndex] ?? lastWalkIndex.height;
        extentsOfAnchor[lastWalkIndex] = height + cellExtent;
      }
    }

    final offsetsOfAnchor = ExtentListUtil.extents2offsets(extentsOfAnchor);

    final extentsSum =
        extentsOfAnchor.values.fold(0.0, (pre, cur) => pre + cur);

    final scroller = ScrollController();

    final slivers = <Widget>[];
    var sliverChunk = <Widget>[];
    flushSliverChunk() {
      final children = List.of(sliverChunk.map((child) {
        return HasNextWidget(
          hasNext: sliverChunk.indexOf(child) + 1 < sliverChunk.length,
          child: child,
        );
      }));
      slivers.add(
        SliverList(delegate: SliverChildListDelegate.fixed(children)),
      );
      sliverChunk = [];
    }

    for (var i = 0; i < children.length; i++) {
      final child = children[i];
      if (child is IndexBarAnchor) {
        if (sliverChunk.isNotEmpty) flushSliverChunk();

        slivers.add(SliverPersistentHeader(
          pinned: true,
          delegate: _SliverIndexBarAnchorHeaderDelegate(
            () =>
                offsetsOfAnchor[child]! +
                extentsOfAnchor[child]! -
                scroller.offset,
            child,
          ),
        ));
      } else {
        sliverChunk.add(WithDelayed(
          () => child,
          constraints: BoxConstraints.tightFor(height: cellExtent),
        ));
      }
    }
    if (sliverChunk.isNotEmpty) flushSliverChunk();

    return LayoutBuilder(builder: (_, con) {
      final viewport = con.maxHeight;

      clampOffset(double overflowableOffset) {
        return clampDouble(overflowableOffset, 0, extentsSum - viewport);
      }

      return Stack(alignment: Alignment.centerRight, children: [
        ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: CustomScrollView(
            controller: scroller,
            slivers: slivers,
          ),
        ),
        IndexBarAnchorList(
          indexes: List.of(extentsOfAnchor.keys.map((a) => a.index)),
          onMove: (index) => scroller.jumpTo(clampOffset(offsetsOfAnchor[
              extentsOfAnchor.keys.firstWhere((e) => e.index == index)]!)),
        ),
      ]);
    });
  }
}

class IndexBarAnchorList extends StatelessWidget {
  final List<String> indexes;
  final Function(String index) onMove;
  const IndexBarAnchorList({
    required this.indexes,
    required this.onMove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    final cellHeight = theme.lineHeightXs;
    final maxHeight = cellHeight * indexes.length;

    final typo = TailTypo().font_size(theme.fontSizeXs).font_bold();

    final pl = theme.paddingMd;
    final pr = theme.paddingXs;

    handleMove(Offset posOfBox) {
      final at = (posOfBox.dy / cellHeight).floor();
      onMove(indexes[at]);
    }

    return OverflowBox(
      alignment: Alignment.centerRight,
      maxHeight: maxHeight,
      child: Builder(builder: (context) {
        return Listener(
          onPointerDown: (e) {
            tryCatch(() {
              final box = context.findRenderObject() as RenderBox;
              handleMove(box.globalToLocal(e.position));
            });
          },
          onPointerMove: (e) {
            tryCatch(() {
              final box = context.findRenderObject() as RenderBox;
              handleMove(box.globalToLocal(e.position));
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: List.of(indexes.map((index) {
              return TailBox().pl(pl).pr(pr).as((s) {
                return s.Container(height: cellHeight, child: typo.Text(index));
              });
            })),
          ),
        );
      }),
    );
  }
}

class _SliverIndexBarAnchorHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  final Function() getDistanceBeforeOverflow;
  final IndexBarAnchor child;
  _SliverIndexBarAnchorHeaderDelegate(
      this.getDistanceBeforeOverflow, this.child);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final selected =
        shrinkOffset > 0 || getDistanceBeforeOverflow() < child.height * 2;
    return OverflowBox(
      maxHeight: child.height,
      alignment: Alignment.bottomCenter,
      child: AnchorState(selected: selected, child: child),
    );
  }

  @override
  double get maxExtent {
    return child.height;
  }

  @override
  double get minExtent {
    final distance = getDistanceBeforeOverflow();
    if (distance >= child.height) {
      return child.height;
    } else if (distance >= 0) {
      return distance;
    } else {
      return 0;
    }
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
