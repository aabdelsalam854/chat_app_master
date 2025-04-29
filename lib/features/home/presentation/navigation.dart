class GroupChatExtras {
  final String photoUrl;
  final String groupId;
  final String groupName;
  final int groupMembersCount;

  const GroupChatExtras({
    required this.photoUrl,
    required this.groupId,
    required this.groupName,
    required this.groupMembersCount,
  });

  Map<String, dynamic> toMap() {
    return {
      "photoUrl": photoUrl,
      "groupId": groupId,
      "groupName": groupName,
      "groupMembersCount": groupMembersCount,
    };
  }

  factory GroupChatExtras.fromMap(Map<String, dynamic> map) {
    return GroupChatExtras(
      photoUrl: map["photoUrl"],
      groupId: map["groupId"],
      groupName: map["groupName"],
      groupMembersCount: map["groupMembersCount"],
    );
  }
}
