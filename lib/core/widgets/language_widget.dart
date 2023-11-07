import 'package:dentech/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dentech/core/utils/extensions/int_extensions.dart';
import 'package:dentech/core/utils/extensions/string_extensions.dart';
import 'package:dentech/core/utils/extensions/widget_extensions.dart';
import '../configure_di.dart';
import '../app_store/app_store.dart';
import '../data/local_data/shared_pref.dart';
import '../local/app_localization.dart';
import '../local/language_data_model.dart';
import '../logic/global_bloc.dart';
import '../utils/extensions/context_extensions.dart';
import '../values/constant.dart';
import 'list_item_widget.dart';

enum WidgetType { DROPDOWN, LIST }

class LanguageWidget extends StatefulWidget {
  final WidgetType widgetType;
  final Widget? trailing;
  final ScrollPhysics? scrollPhysics;

  const LanguageWidget({
    this.widgetType = WidgetType.LIST,
    this.scrollPhysics,
    this.trailing,
    Key? key,
  }) : super(key: key);

  @override
  LanguageWidgetState createState() => LanguageWidgetState();
}

class LanguageWidgetState extends State<LanguageWidget> {
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
    Widget buildImageWidget(String imagePath) {
      if (imagePath.startsWith('http')) {
        return Image.network(imagePath, width: 24);
      } else {
        return Image.asset(imagePath, width: 24);
      }
    }

    if (widget.widgetType == WidgetType.LIST) {
      return ListView.builder(
        itemBuilder: (_, index) {
          LanguageDataModel data = localeLanguageList[index];

          return ListItemWidget(
            title: data.name.validate(),
            subTitle: data.subTitle,
            leading: (data.flag != null) ? buildImageWidget(data.flag!) : null,
            trailing: Container(
              child: widget.trailing ??
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: const Icon(Icons.check, size: 15, color: Colors.black),
                  ),
            ).visible(getStringAsync(SELECTED_LANGUAGE_CODE) == data.languageCode.validate()),
            onTap: () async {
              await setValue(SELECTED_LANGUAGE_CODE, data.languageCode);
              selectedLanguageDataModel = data;
              language = await const AppLocalizations().load(Locale(data.languageCode!));
              setState(() {});
              getIt<AppStore>().setLanguage(data.languageCode!);
              context.read<GlobalBloc>().add(LanguageChanged(data.languageCode!));
              finish(context, true);
            },
          );
        },
        shrinkWrap: true,
        physics: widget.scrollPhysics,
        itemCount: localeLanguageList.length,
      );
    } else {
      return DropdownButton<LanguageDataModel>(
        value: selectedLanguageDataModel,
        dropdownColor: Colors.grey,
        elevation: 4,
        onChanged: (data) async {
          await setValue(SELECTED_LANGUAGE_CODE, data!.languageCode);
          selectedLanguageDataModel = data;
          language = await const AppLocalizations().load(Locale(data.languageCode!));
          setState(() {});
          getIt<AppStore>().setLanguage(data.languageCode!);
          context.read<GlobalBloc>().add(LanguageChanged(data.languageCode!));
          finish(context, true);
        },
        items: localeLanguageList.map((data) {
          return DropdownMenuItem<LanguageDataModel>(
            value: data,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (data.flag != null) buildImageWidget(data.flag!),
                4.width,
                Text(data.name.validate()),
              ],
            ),
          );
        }).toList(),
      );
    }
  }
}
