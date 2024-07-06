import 'package:flutter/material.dart';
import 'package:unimatch/const.dart';
import 'package:unimatch/prefabs/abBasic.dart';
import '../../prefabs/pBasic.dart';

class DiscoverySettingPage extends StatefulWidget {
  const DiscoverySettingPage({Key? key}) : super(key: key);

  @override
  State<DiscoverySettingPage> createState() => _DiscoverySettingPageState();
}

class _DiscoverySettingPageState extends State<DiscoverySettingPage> {
  TextEditingController teLocation = TextEditingController();
  TextEditingController teCountry = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.indigo.shade800;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppbarBasic(
          appBar: AppBar(),
          title: "Discovery Settings",
          onTap: () {Navigator.pop(context);},
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                      child: Text("Location Search", style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w700),),
                    ),
                    PBasic(
                      title: "People Nearby",
                      status: "",
                      prefixIcon: Icons.near_me,
                      onTap: () {
                        Navigator.pushNamed(context, "/location");
                      },
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                    //   child: Text("Details", style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w700),),
                    // ),
                    // PBasic(
                    //   title: "Region",
                    //   prefixIcon: Icons.public,
                    //   onTap: () {
                    //     showDialog(
                    //       context: context,
                    //       builder: (BuildContext context) {
                    //         return SimpleDialog(
                    //           backgroundColor: Colors.white,
                    //           surfaceTintColor: Colors.transparent,
                    //           title: const Text("Select Country"),
                    //           children: [
                    //             SizedBox(
                    //               width: MediaQuery.of(context).size.width,
                    //               child: ListView.builder(
                    //                 physics:
                    //                 const NeverScrollableScrollPhysics(),
                    //                 shrinkWrap: true,
                    //                 itemBuilder: (ctx, index) {
                    //                   return SimpleDialogOption(
                    //                     onPressed: () {
                    //                       Navigator.pop(context);
                    //                       teCountry.text = REGIONS[index];
                    //                     },
                    //                     child: Center(
                    //                       child: Text(REGIONS[index]),
                    //                     ),
                    //                   );
                    //                 },
                    //                 itemCount: REGIONS.length,
                    //               ),
                    //             )
                    //           ],
                    //         );
                    //     });
                    //   }
                    // ),
                    // PBasic(
                    //   title: "Gender",
                    //   prefixIcon: Icons.wc,
                    //   onTap: () {
                    //
                    //   },
                    // ),
                    // PBasic(
                    //   title: "District",
                    //   prefixIcon: Icons.place,
                    //   onTap: () {
                    //     showDialog(
                    //         context: context,
                    //         builder: (BuildContext context) {
                    //       return SimpleDialog(
                    //         title: const Text("Select District"),
                    //         children: [
                    //           SizedBox(
                    //             width: MediaQuery.of(context).size.width,
                    //             child: ListView.builder(
                    //               shrinkWrap: true,
                    //               itemBuilder: (ctx, index) {
                    //                 return SimpleDialogOption(
                    //                   onPressed: () {
                    //                     Navigator.pop(context);
                    //                     teLocation.text = DISTRICTS[index];
                    //                   },
                    //                   child: Center(
                    //                     child: Text(DISTRICTS[index]),
                    //                   ),
                    //                 );
                    //               },
                    //               itemCount: DISTRICTS.length,
                    //             ),
                    //           )
                    //         ],
                    //       );
                    //     });
                    //   },
                    // ),
                  ]
                )
            )
        ),
      ),
    );
  }
}
