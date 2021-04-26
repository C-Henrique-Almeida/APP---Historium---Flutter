import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WattcopyScaffold extends StatelessWidget {
  final Widget body;
  final String caption;
  final bool backButton;

  WattcopyScaffold({this.body = const SizedBox(), this.caption = "", this.backButton = false}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
				automaticallyImplyLeading: false,
        leading: this.backButton ? BackButton() : null,
        actionsIconTheme: IconThemeData(
          size: 40,
        ),
        toolbarHeight: 160,
        title: Text("Wattcopy"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Container(
						margin: EdgeInsets.only(bottom: 12),
						child: Text(this.caption,
							style: GoogleFonts.revalia(
								fontSize: 36,
								fontWeight: FontWeight.w400,
								letterSpacing: 0.0,
								color: Colors.white
							)
						),
					),
        ),
      ),
      body: this.body,
    );
  }
}
