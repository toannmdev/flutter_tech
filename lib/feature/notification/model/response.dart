import 'dart:convert';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toannm_test/feature/const/app_colors.dart';

class NotificationResponse {
  NotificationResponse({
    this.data,
  });

  final List<Datum>? data;

  factory NotificationResponse.fromRawJson(String str) =>
      NotificationResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      NotificationResponse(
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data?.map((x) => x.toJson()) ?? []),
      };
}

class Datum {
  Datum({
    required this.id,
    this.type,
    required this.title,
    this.message,
    this.image,
    this.icon,
    this.status,
    this.subscription,
    this.readAt,
    this.createdAt,
    this.updatedAt,
    this.receivedAt,
    this.imageThumb,
    this.animation,
    this.tracking,
    this.subjectName,
    this.isSubscribed,
  });

  late String id;
  final String? type;
  late String title;
  final Message? message;
  final String? image;
  final String? icon;
  final Rx<Status>? status;
  final Subscription? subscription;
  final int? readAt;
  final int? createdAt;
  final int? updatedAt;
  final int? receivedAt;
  final String? imageThumb;
  final String? animation;
  final String? tracking;
  final String? subjectName;
  final bool? isSubscribed;

  // client
  late List<String> highlightChars;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) {
    Message? message =
        json["message"] == null ? null : Message.fromJson(json["message"]);
    Datum datum = Datum(
      id: json["id"] == null ? null : json["id"],
      type: json["type"] == null ? null : json["type"],
      title: json["title"],
      message:
          json["message"] == null ? null : Message.fromJson(json["message"]),
      image: json["image"] == null ? null : json["image"],
      icon: json["icon"] == null ? null : json["icon"],
      status:
          json["status"] == null ? null : statusValues.map[json["status"]]!.obs,
      subscription: json["subscription"] == null
          ? null
          : Subscription.fromJson(json["subscription"]),
      readAt: json["readAt"] == null ? null : json["readAt"],
      createdAt: json["createdAt"] == null ? null : json["createdAt"],
      updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
      receivedAt: json["receivedAt"] == null ? null : json["receivedAt"],
      imageThumb: json["imageThumb"] == null ? null : json["imageThumb"],
      animation: json["animation"] == null ? null : json["animation"],
      tracking: json["tracking"] == null ? null : json["tracking"],
      subjectName: json["subjectName"] == null ? null : json["subjectName"],
      isSubscribed: json["isSubscribed"] == null ? null : json["isSubscribed"],
    );
    /* 
      init highlight characters from message.highlight: avoid rendering items when listview be drawed
      offset from message.highlights has been sorted on Server
     */
    List<String> strNeedToHighLights = (message?.highlights ?? []).map((e) {
      int offset = (e.offset ?? 0);
      int maxOffset = offset + (e.length ?? 0);
      return (message?.text ?? "").substring(offset, maxOffset);
    }).toList();

    datum.highlightChars = [];
    strNeedToHighLights.forEach((element) {
      datum.highlightChars.addAll(element.split(" "));
    });
    return datum;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type == null ? null : type,
        "message": message == null ? null : message?.toJson(),
        "image": image == null ? null : image,
        "icon": icon == null ? null : icon,
        "status": status == null ? null : statusValues.reverse[status],
        "subscription": subscription == null ? null : subscription?.toJson(),
        "readAt": readAt == null ? null : readAt,
        "createdAt": createdAt == null ? null : createdAt,
        "updatedAt": updatedAt == null ? null : updatedAt,
        "receivedAt": receivedAt == null ? null : receivedAt,
        "imageThumb": imageThumb == null ? null : imageThumb,
        "animation": animation == null ? null : animation,
        "tracking": tracking == null ? null : tracking,
        "subjectName": subjectName == null ? null : subjectName,
        "isSubscribed": isSubscribed == null ? null : isSubscribed,
      };

  Color getBgColor() {
    return status?.value == Status.READ
        ? Colors.white
        : AppColors.bgNotiSelected;
  }

  void setIsRead() {
    status?.value = Status.READ;
  }
}

class Message {
  Message({
    this.text,
    this.highlights,
  });

  final String? text;
  final List<Highlight>? highlights;

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        text: json["text"] == null ? null : json["text"],
        highlights: json["highlights"] == null
            ? null
            : List<Highlight>.from(
                json["highlights"].map((x) => Highlight.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "text": text == null ? null : text,
        "highlights": highlights == null
            ? null
            : List<dynamic>.from(highlights?.map((x) => x.toJson()) ?? []),
      };
}

class Highlight {
  Highlight({
    this.offset,
    this.length,
  });

  final int? offset;
  final int? length;

  factory Highlight.fromRawJson(String str) =>
      Highlight.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Highlight.fromJson(Map<String, dynamic> json) => Highlight(
        offset: json["offset"] == null ? null : json["offset"],
        length: json["length"] == null ? null : json["length"],
      );

  Map<String, dynamic> toJson() => {
        "offset": offset == null ? null : offset,
        "length": length == null ? null : length,
      };
}

enum Status { UNREAD, READ }

final statusValues = EnumValues({"read": Status.READ, "unread": Status.UNREAD});

class Subscription {
  Subscription({
    this.targetId,
    this.targetType,
    this.targetName,
    this.level,
  });

  final String? targetId;
  final TargetType? targetType;
  final String? targetName;
  final int? level;

  factory Subscription.fromRawJson(String str) =>
      Subscription.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        targetId: json["targetId"] == null ? null : json["targetId"],
        targetType: json["targetType"] == null
            ? null
            : targetTypeValues.map[json["targetType"]],
        targetName: json["targetName"] == null ? null : json["targetName"],
        level: json["level"] == null ? null : json["level"],
      );

  Map<String, dynamic> toJson() => {
        "targetId": targetId == null ? null : targetId,
        "targetType":
            targetType == null ? null : targetTypeValues.reverse[targetType],
        "targetName": targetName == null ? null : targetName,
        "level": level == null ? null : level,
      };
}

enum TargetType { GROUP, USER, POST }

final targetTypeValues = EnumValues({
  "group": TargetType.GROUP,
  "post": TargetType.POST,
  "user": TargetType.USER
});

class EnumValues<T> {
  final Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    return map.map((k, v) => new MapEntry(v, k));
  }
}
