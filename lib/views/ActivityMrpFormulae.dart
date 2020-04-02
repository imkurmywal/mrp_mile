import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mrpmile/utils/Utils.dart';
import 'package:mrpmile/views/ActivityCalculator.dart';
import 'package:mrpmile/views/ActivityHome.dart';
import 'package:pinch_zoom_image/pinch_zoom_image.dart';

class ActivityMrpFormulae extends StatefulWidget {
  @override
  _ActivityMrpFormulaeState createState() => _ActivityMrpFormulaeState();
}

class _ActivityMrpFormulaeState extends State<ActivityMrpFormulae> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('MRPmile cost per mile'),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Utils.changeScreen(context, ActivityHome());
            },
          ),
        ),
        body: _getBody(),
      ),
      onWillPop: () {
        Utils.changeScreen(context, ActivityHome());
      },
    );
  }

  _getBody() {
    return Container(
      padding: EdgeInsets.all(32.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image(
              image: AssetImage('images/logo.png'),
              height: 80.0,
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              'WEEKLY COST PER MILE\nCALCULATOR',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 21.0,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              'COST OF OPERATION',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 21.0,
                color: Colors.black87,
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              'The cost per mile calculation plays an important role in the success of your trucking operation because it will tell you the operating expenses of your truck per mile driven. \n\nYou can use this simple form to calculate your cost per mile.\n\nYou need to know two factors:\n1- Your operating expenses for a specific time period (a week, a month, a calendar quarter or a year)\n2- Miles driven in the corresponding time.\n\nFor example if your weekly operating expanses amount to \$2,305 and you have driven 2,194 miles in that quarter, your cost per mile is \$1.05.\n\nWhy is it important to know your cost per mile factors? Because it allows you to quickly determine the profitability of the load.\n\nFor example your broker offers you a load that pays \$1,000 for 850 miles, but you have to deadhead (empty drive) 150 miles to get to the loading  location. Let us assume your cost per mile factor is 95 cents, it will cost you \$142.50 out of your own pocket just to drive your truck to pickup location, and it will cost you another \$850.70 (850 miles times 95 cents) to deliver the load, should you decide to do so. This leaves you with \$50 profit for driving 1000 miles.\n\nThis example clearly shows the importance of your cost per mile calculation for the success of your trucking operation.\n\nAs a general rule, never allow your deadhead cost to exceed 10 percent of the freight rate offered, unless you receive compensation for the deadheading.\n\nNow that you have identified the operation cost, you start to think about the Minimal Rate Per Mile that you should accept from brokers.\n\nKeep in mind that even if your truck is paid in full, sooner or later you will have to buy another. So the cost per mile should always have the truck payment.\n\nHowever as a responsible business manager, you should compare your cost per mile factor from month to month to determine your how your business progresses.\n\n',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ActivityCalculator();
                }));
              },
              child: Container(
                margin: EdgeInsets.all(8.0),
                height: 50.0,
                alignment: Alignment.center,
                color: Theme.of(context).accentColor,
                child: Text(
                  'Calculate Now',
                  style: TextStyle(
                    fontSize: 21.0,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
