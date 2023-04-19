import 'package:boxApp/model/ranklist_model.dart';
import 'package:boxApp/provider/ranklist_page_model.dart';
import 'package:boxApp/util/size_fit.dart';
import 'package:boxApp/widget/loading_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:boxApp/widget/provider_widget.dart';

const TAB_LABEL = ['刷题数量', '坚持天数', '准确率'];

class RanklistPage extends StatefulWidget {
  @override
  State createState() => _RanklistPageState();
}

class _RanklistPageState extends State<RanklistPage>
  with SingleTickerProviderStateMixin  {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: TAB_LABEL.length, vsync: this);
  }

    @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<RanklistPageModel>(
      model: RanklistPageModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomPadding: true,
          body: LoadingContainer(
            loading: model.loading,
            error: model.error,
            retry: model.retry,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 408,
                  child: Image.asset('assets/images/bg_ranklist_01.png', fit: BoxFit.cover),
                ),
                _buildMain(model),
                Positioned(
                  top: 0.0,
                  child: Container(
                    width: MSizeFit.screenWidth,
                    height: kToolbarHeight + MSizeFit.statusBarHeight,
                    child: AppBar(
                      brightness: Brightness.dark,
                      backgroundColor: Color(0x00000000),
                      elevation: 0,
                      // automaticallyImplyLeading: false,
                      // leading: IconButton(
                      //   icon: Icon(Icons.keyboard_backspace, color: Colors.white,),
                      //   onPressed: () {},
                      // ),
                      centerTitle: true,
                      title: Text('学霸排行', style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  )
                ), 
              ]
            )         
          )
        );
      }
    );
  }

  Widget _buildMain(RanklistPageModel model) {
    return Container(      
      child: Column(
        children: [
          _buildHeader(),
          _buildTop(),
          Expanded(
            child: _buildView(model),
          )
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: kToolbarHeight + MSizeFit.statusBarHeight + 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "思想政治理论",
            style: TextStyle(fontSize: 16, color: Colors.white)
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color(0x99126AFE),
            ),
            child: SizedBox(
              height: 26,
              child: TabBar(
                isScrollable: true,
                //是否可以滚动
                controller: _tabController,
                labelColor: Color(0xFF1F86FE),
                unselectedLabelColor: Color(0xaaffffff),
                labelPadding: EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 0),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 0,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                ),
                tabs: TAB_LABEL.map((String label) {
                  return Tab(text: "    $label    ");
                }).toList(),
                onTap: (index) {
                  print(index);
                },
              ),
            ),
          )
        ],
      ),
    );
  }


  Widget _buildTop() {
    return Container(
      padding: EdgeInsets.only(top: 30, bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(72),
                      border: Border.all(color: Color(0xff3280FE), width: 5)
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: "https://img.koudaikaoyan.com/510a7d357a7c4dd5ca2ba017f1efa757.jpg",
                        fit: BoxFit.cover,
                      ),
                    )
                  ),
                  Positioned(
                    top: 0.0,
                    right: 0,
                    child: Image.asset(
                      'assets/images/ic_ranklist_two.png', 
                      width: 22, 
                      height: 22,
                      fit: BoxFit.cover
                    ),
                  )
                ],
              ),
              SizedBox(height: 5),
              Text("6802", style: TextStyle(fontSize: 16, color: Color(0xFFD1E6FF))),
              Text("星星的爱", style: TextStyle(fontSize: 13, color: Color(0xFFFFFFFF))),
            ],
          ),
          SizedBox(width: 30),
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(72),
                      border: Border.all(color: Color(0xff3280FE), width: 5)
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: "https://img.koudaikaoyan.com/510a7d357a7c4dd5ca2ba017f1efa757.jpg",
                        fit: BoxFit.cover,
                      ),
                    )
                  ),
                  Positioned(
                    top: 0.0,
                    right: 0,
                    child: Image.asset(
                      'assets/images/ic_ranklist_one.png', 
                      width: 22, 
                      height: 22,
                      fit: BoxFit.cover
                    ),
                  )
                ],
              ),
              SizedBox(height: 5),
              Text("6802", style: TextStyle(fontSize: 18, color: Color(0xFFFEE11F))),
              Text("星星的爱", style: TextStyle(fontSize: 14, color: Color(0xFFFFFFFF))),
            ],
          ),
          SizedBox(width: 30),
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(72),
                      border: Border.all(color: Color(0xff3280FE), width: 5)
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: "https://img.koudaikaoyan.com/510a7d357a7c4dd5ca2ba017f1efa757.jpg",
                        fit: BoxFit.cover,
                      ),
                    )
                  ),
                  Positioned(
                    top: 0.0,
                    right: 0,
                    child: Image.asset(
                      'assets/images/ic_ranklist_three.png', 
                      width: 22, 
                      height: 22,
                      fit: BoxFit.cover
                    ),
                  )
                ],
              ),
              SizedBox(height: 5),
              Text("6802", style: TextStyle(fontSize: 16, color: Color(0xFFD1E6FF))),
              Text("星星的爱", style: TextStyle(fontSize: 13, color: Color(0xFFFFFFFF))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildView(RanklistPageModel model) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        color: Colors.white,
      ),
      child: ListView.separated(
        padding: EdgeInsets.only(top: 8.0, bottom: MSizeFit.bottomBarHeight + 20, left: 15.0, right: 15.0),
        itemBuilder: (context, index) {
          return _buildListItem(model.list[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 12);
        },
        itemCount: model.list.length
      )
    );
  }

  Widget _buildListItem(RanklistModel item) {    
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15.0, right: 15.0),
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
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFFD1E6FF),
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Text(
              "${item.sort}",
              style: TextStyle(
                color: Color(0xFF1F86FE),
                fontSize: 16.0,
                // fontWeight: FontWeight.bold
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 14, right: 14),
            width: 48,
            height: 48,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: item.avatar,
                fit: BoxFit.cover,
              ),
            )
          ),
          Expanded(
            child: Text(
              "${item.nickname}",
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 14.0,
                // fontWeight: FontWeight.bold
              ),
            ),
          ),
          Text(
            "${item.value}",
            style: TextStyle(
              color: Color(0xFF1F86FE),
              fontSize: 20.0,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }
}


