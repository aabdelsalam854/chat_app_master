import 'package:flutter/material.dart';

// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class NormalCallPage extends StatelessWidget {
  const NormalCallPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: Center(
        child: Text('Normal Call Page'),
      ),
    );
    // return ZegoUIKitPrebuiltCall(
    //     appID: 1212639721, // your AppID,
    //     appSign:
    //         'ff3df6aee96f15a7c0d44a5d1a1b56c20c7f111bc84be1fbe7e5a75692f2efce',
    //     userID: 'local user id',
    //     userName: 'local user name',
    //     callID: 'call id',
    //     config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall());
  }
}
