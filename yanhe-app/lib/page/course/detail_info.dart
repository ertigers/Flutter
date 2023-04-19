import 'package:boxApp/model/course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class CourseDetailInfo extends StatelessWidget {
  CourseModel courseModel;

  CourseDetailInfo({Key key, this.courseModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Html(
          shrinkWrap: true,
          data: courseModel.detail,
          style: {                           
            "body": Style(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.all(0)
            ),
            "p": Style(
              // display: Display.INLINE_BLOCK,
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.all(0)
            ),
            "img": Style(
              // display: Display.INLINE_BLOCK,
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.all(0)
            )
          },
        ),
      )
      // child: Html(
      //   data: """
      //     <div>
      //       <p>
      //       <img src="http://img.koudaitiku.com/2f1fd164278649dea3921fd27ed5ca23.png" title="截屏2020-12-08 上午10.04.28.png" alt="截屏2020-12-08 上午10.04.28.png">
      //       <img src="http://img.koudaitiku.com/533f97d29e1a440cb36da8fd13f26d47.jpg" title="01ab6650869b47e1bb80a9bf3477df8e.jpg" alt="01ab6650869b47e1bb80a9bf3477df8e.jpg">
      //       <img src="http://img.koudaitiku.com/076eef74c99c42e0aca9bd702de6b9b4.jpg" title="63bb1f23d7ee00355412fa47c1e5adf7.jpg" alt="63bb1f23d7ee00355412fa47c1e5adf7.jpg">
      //       <img src="http://img.koudaitiku.com/dbc0f45056b44a099af943d2a1eef804.jpg" title="80e9168c966318e526561b5480ed3b99.jpg" alt="80e9168c966318e526561b5480ed3b99.jpg">
      //       <img src="http://img.koudaitiku.com/e0648515f556483e8eca3779171ae486.jpg" title="69b1a4f0231e3a95ee1844ba8b9aa7c8.jpg" alt="69b1a4f0231e3a95ee1844ba8b9aa7c8.jpg">
      //       </p><p><br></p>
      //     </div>
      //   """,
      //   style: {                           
      //     "body": Style(
      //       padding: EdgeInsets.all(0),
      //       margin: EdgeInsets.all(0)
      //     ),
      //     "p": Style(
      //       // display: Display.INLINE_BLOCK,
      //       padding: EdgeInsets.all(0),
      //       margin: EdgeInsets.all(0)
      //     ),
      //     "img": Style(
      //       // display: Display.INLINE_BLOCK,
      //       padding: EdgeInsets.all(0),
      //       margin: EdgeInsets.all(0)
      //     )
      //   },
      // ),
    );
  }
}