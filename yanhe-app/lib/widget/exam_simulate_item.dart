import 'package:boxApp/model/exam_simulate_model.dart';
import 'package:flutter/material.dart';

class ExamSimulateItem extends StatelessWidget {
  final ExamSimulateModel simulate;
  final bool last;

  ExamSimulateItem({Key key, this.simulate, this.last}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(top: 12.0),
        padding: EdgeInsets.only(top: 12.0, bottom: 12.0, left: 12.0, right: 12.0),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Color(0x1A1F86FE),
              offset: Offset(0.0, 5.0), //阴影xy轴偏移量
              blurRadius: 15.0, //阴影模糊程度
              spreadRadius: 1.0 //阴影扩散程度
            )
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Image.asset(
                        'assets/images/ic_time.png',
                        width: 13.0,
                        height: 13.0,
                      ),
                    ),
                    TextSpan(
                      text: ' 进行中',
                      style: TextStyle(fontSize: 11, color: Color(0xFF1F86FE)),
                    ),   
                  ]
                )
              )
            ),
            Container(
              margin: EdgeInsets.only(top: 18.0),
              child: Text(
                "21英语-12月模拟一卷",
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 6.0),
              child: Text(
                "参考有效时间：2020-12-01-2020-12-15",
                style: TextStyle(
                  color: Color(0xFF666666),
                  fontSize: 11.0,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 6.0),
              child: Text(
                "考试总分：110  考试时长：3小时0分",
                style: TextStyle(
                  color: Color(0xFF666666),
                  fontSize: 11.0,
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween, //子组件在主轴的排列方式为两端对齐
                crossAxisAlignment: CrossAxisAlignment.end, //子组件的在交叉轴的对齐方式为起点
                children: [
                  Container(
                    child: Text(
                      "已有5人参加",
                      style: TextStyle(
                        color: Color(0xFF999999),
                        fontSize: 11.0,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      height: 20,
                      width: 60,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/bg_btn_01.png"),
                          fit: BoxFit.cover
                        )
                      ),
                      child: Text(
                        "立即报名",
                        style: TextStyle(
                          color: Color(0xFFffffff),
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  )
                ],
              )
            ),
          ],
        ),
      )
    );
  }
}