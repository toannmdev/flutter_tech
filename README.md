Implement Notification List screen

## Design

https://www.figma.com/file/i4cmuJhojWnVpoF9uqY8Gi/Untitled?node-id=0%3A1

## Main features:

- Display all notifications got from API (mock from json file)
- Unread notification has different background color
- Tap a notification to turn it from `unread` to `read`
- User display name is bold, define by `notificaion.message.highlights` field
- Height of each cell row is dynamic, base on the text length

For search feature (Optional extra)

- Tap search icon to display search bar
- Search notifications by filter `notification.messsage.text` (search in local results that got from API get list notification): Provide accent remover: For example: when search for `Hôm nay`, results can be `hom nay` or `hôm nay`
- Tap `X` icon to return to list notification screen, hide search bar & search result
- About unit test, I skip this.

## Install
> flutter run

The flutter run command both builds and installs the Flutter app to your device or emulator.

## Design Pattern:
1. GetX design Pattern for easy coding.

## App screenshots:

### Open App and load data success

![Open App and load data success](https://github.com/toannmdev/flutter_tech/blob/demo/notification_page/upload/Full_Data.png)

### Search and has result

![Search and has result](https://github.com/toannmdev/flutter_tech/blob/demo/notification_page/upload/Search_Has_Result.png)

### Search and has no result

![Search and has no result](https://github.com/toannmdev/flutter_tech/blob/demo/notification_page/upload/Search_No_Result.png)

