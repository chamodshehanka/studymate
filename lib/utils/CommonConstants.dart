import 'package:flutter/cupertino.dart';

class CommonConstants extends InheritedWidget {
  static CommonConstants of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(CommonConstants);

  static final String activityCollectionName = 'Activities';
  static final String activityProgressCollectionName = 'ActivityProgress';
  static final String studentsCollectionName = 'students';

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
