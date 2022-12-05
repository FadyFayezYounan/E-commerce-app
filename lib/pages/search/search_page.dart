import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/common_widgets/app_app_bar.dart';
import 'package:shop_app/common_widgets/app_icon.dart';
import 'package:shop_app/common_widgets/app_icon_button.dart';
import 'package:shop_app/common_widgets/app_text_field.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/search-page';

  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Search', context: context),
      body: Column(
        children: [
          buildSearchWidget(context),
        ],
      ),
    );
  }

  TextFormField buildSearchWidget(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).accentColor,
            width: 0.1,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        hintText: 'Find something..',
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        prefixIcon: AppIconButton(
          iconName: IconName.search,
          onPressed: null,
        ),
        //SvgPicture.asset('assets/icons/Search2.svg',),
        suffixIcon: AppIconButton(
          iconName: IconName.filter,
          onPressed: () {},
        ),
        // prefixIconConstraints: BoxConstraints.tightFor(
        //   width: 24,height: 24,
        // ),
        // contentPadding: EdgeInsets.all(20),
      ),
      style: TextStyle(
        color: Theme.of(context).accentColor,
      ),
    );
  }
}
