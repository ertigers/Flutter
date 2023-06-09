import 'package:flutter/material.dart';
import 'package:boxApp/config/color.dart';
import 'package:boxApp/config/string.dart';

//多状态视图封装
class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool loading;
  final bool error;
  final VoidCallback retry;

  const LoadingContainer(
      {Key key,
      @required this.loading,
      @required this.child,
      this.error = false,
      @required this.retry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !loading ? error ? _errorView : child : _loadView;
  }

  Widget get _errorView {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/ic_error.png',
            width: 100,
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              MString.net_error_tip,
              style: TextStyle(color: MColor.hitTextColor, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: OutlineButton(
              onPressed: () => retry.call(),
              child: Text(MString.reload_again),
              highlightColor: Colors.white,
              highlightedBorderColor: Colors.black12,
            ),
          )
        ],
      ),
    );
  }

  Widget get _loadView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
