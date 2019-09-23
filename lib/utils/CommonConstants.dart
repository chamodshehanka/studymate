import 'package:flutter/cupertino.dart';

class CommonConstants extends InheritedWidget {
  static CommonConstants of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(CommonConstants);

  // Collections Names
  static final String activityCollectionName = 'Activities';
  static final String activityProgressCollectionName = 'ActivityProgress';
  static final String studentsCollectionName = 'students';

  // Cloud Functions Names
  static final String activityProgressFunction = 'activityProgress';

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
