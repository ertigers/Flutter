import 'dart:ui';

class MSizeFit {
  // 1.基本信息
  static double physicalWidth;
  static double physicalHeight;
  static double screenWidth;
  static double screenHeight;
  static double dpr;
  static double statusBarHeight;
  static double bottomBarHeight;

  static double rpx;
  static double px;
// 这里设置standardSize 为可选属性，如果使用者愿意以非iPhone6为标准，那么你使用时候传入对应的标准即可。这里默认750
  static void initialize({double standardSize = 750}) {
    // 1.手机的物理分辨率
    physicalWidth = window.physicalSize.width;
    physicalHeight = window.physicalSize.height;
    // 2.获取dpr
    dpr = window.devicePixelRatio;

    // 3.宽度和高度
    screenWidth = physicalWidth / dpr;
    screenHeight = physicalHeight / dpr;

    // 4.状态栏高度
    statusBarHeight = window.padding.top / dpr;

    bottomBarHeight = window.padding.bottom / dpr;

    // 5.计算rpx px的大小, iPhone6下 1px = 2rpx
    rpx = screenWidth / standardSize;
    px = screenWidth / standardSize * 2;
  }

  static double setRpx(double size) {
    return rpx * size;
  }

  static double setPx(double size) {
    return px * size;
  }
}

extension IntFit on int {
  double get px {
    return MSizeFit.setPx(this.toDouble());
  }

  double get rpx {
    return MSizeFit.setRpx(this.toDouble());
  }
}
