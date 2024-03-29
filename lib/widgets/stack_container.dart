import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../providers/api_provider.dart';
import '../providers/team_provider.dart';

class StackContainer extends StatelessWidget {

  final int matchId;
  final int matchType;
  final Widget navScreen;
  final IconData icon;
  final Widget child;


  const StackContainer({
    Key? key,
    required this.matchId,
    required this.matchType,
    required this.navScreen,
    required this.icon,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final apiProvider = Provider.of<ApiProvider>(context);
    final teamProvider = Provider.of<TeamProvider>(context);

    return GestureDetector(
        onTap: () {
          switch(matchType){
            case 0: // last match
              teamProvider.idMatch = matchId;
              teamProvider.matchDate= apiProvider.lastMatchDay;
              teamProvider.idHomeMatch = apiProvider.lastTeamIdHome;
              teamProvider.idAwayMatch = apiProvider.lastTeamIdAway;
              teamProvider.nameHomeMatch = apiProvider.lastTeamNameHome;
              teamProvider.nameAwayMatch = apiProvider.lastTeamNameAway;
              teamProvider.homeScore = apiProvider.lastScoreHome;
              teamProvider.awayScore = apiProvider.lastScoreAway;
              break;

            case 1: // next match
              teamProvider.idMatch = matchId;
              teamProvider.matchDate= apiProvider.nextMatchDay;
              teamProvider.idHomeMatch = apiProvider.nextTeamIdHome;
              teamProvider.idAwayMatch = apiProvider.nextTeamIdAway;
              teamProvider.nameHomeMatch = apiProvider.nextTeamNameHome;
              teamProvider.nameAwayMatch = apiProvider.nextTeamNameAway;
              teamProvider.homeScore = 0;
              teamProvider.awayScore = 0;
              break;
          }

          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: navScreen,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          height: 150,
          width: double.infinity,
          decoration: buildBoxDecoration(),
          child: Stack(
              children:[
                Positioned(
                  right: -30,
                  bottom: -45,
                  child: FaIcon(icon, color: Colors.white.withOpacity(0.20), size: 190,), //FontAwesomeIcons.listOl
                ),

                child

              ]
          ),
        )
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(25)
    );
  }
}
