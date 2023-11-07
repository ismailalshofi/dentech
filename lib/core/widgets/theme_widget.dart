import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dentech/core/utils/extensions/widget_extensions.dart';
import 'package:dentech/core/widgets/list_item_widget.dart';
import '../configure_di.dart';
import '../app_store/app_store.dart';
import '../data/local_data/shared_pref.dart';
import '../logic/global_bloc.dart';
import '../utils/extensions/context_extensions.dart';
import '../values/constant.dart';

enum ThemeModes { SystemDefault, Light, Dark }

class ThemeWidget extends StatefulWidget {
  final ScrollPhysics? scrollPhysics;
  final void Function(int)? onThemeChanged;
  final String? subTitle;
  final Widget? trailing;
  final EdgeInsets? padding;

  ThemeWidget({
    this.scrollPhysics,
    this.onThemeChanged,
    this.subTitle,
    this.trailing,
    this.padding,
    Key? key,
  }) : super(key: key);

  @override
  _ThemeWidgetState createState() => _ThemeWidgetState();
}

class _ThemeWidgetState extends State<ThemeWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ThemeModes.values.length,
      physics: widget.scrollPhysics,
      padding: widget.padding ?? EdgeInsets.zero,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListItemWidget(
          title: _getName(ThemeModes.values[index]),
          subTitle: widget.subTitle,
          trailing: Container(
            child: widget.trailing ??
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: const Icon(Icons.check, size: 15, color: Colors.black),
                ),
          ).visible(getIntAsync(THEME_MODE_INDEX) == index),
          onTap: () async {
            await setValue(THEME_MODE_INDEX, index);
            setState(() {});
            getIt<AppStore>().setDarkMode(index);
            context.read<GlobalBloc>().add(ThemeChanged(getIt<AppStore>().isDarkMode));
            finish(context,true);
          },
        );
      },
    );
  }
}

/// returns theme name
String _getName(ThemeModes themeModes) {
  String name = '';
  switch (themeModes) {
    case ThemeModes.Light:
      name = 'Light';
      break;
    case ThemeModes.Dark:
      name = 'Dark';
      break;
    case ThemeModes.SystemDefault:
      name = 'System Default';
      break;
  }
  return name;
}

/// returns current app theme mode
String? get getSelectedThemeMode {
  String? data;

  ThemeModes.values.forEach((element) {
    if (ThemeModes.values.indexOf(element) == getIntAsync(THEME_MODE_INDEX)) {
      data = _getName(element);
    }
  });

  return data;
}
