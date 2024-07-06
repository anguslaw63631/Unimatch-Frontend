import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimatch/config.dart';
import 'package:unimatch/fn.dart';

import '../../components/tfOutlined.dart';
import '../../const.dart';
import '../../prefabs/abBasic.dart';

class SetupInterestPage extends StatefulWidget {
  const SetupInterestPage({Key? key}) : super(key: key);

  @override
  State<SetupInterestPage> createState() => _SetupInterestPageState();
}

class _SetupInterestPageState extends State<SetupInterestPage> {
  TextEditingController teSearch = TextEditingController();
  List<String> selectedInterests = [];
  void setMultipleSelected(List<String> value) {
    setState(() => selectedInterests = value);
  }
  @override
  Widget build(BuildContext context) {
    final selectedTextColor = Colors.indigo.shade600;
    const unselectedTextColor = Colors.indigoAccent;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppbarBasic(
          appBar: AppBar(),
          onTap: () {Navigator.pop(context);},
          enableActions: true,
          actions: [
            IconButton(onPressed: () async {
              if (selectedInterests.isNotEmpty) {
                try {
                  pendingInterest1 = selectedInterests[0];
                  pendingInterest2 = selectedInterests[1];
                  pendingInterest3 = selectedInterests[2];
                } catch (e) {}
                await updateSetup(context);
              } else {
                showMsg(context, "Please Select At least 1 interest", Colors.red);
              }
            }, icon: Icon(Icons.save, color: appBarTextColor)),
          ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Interests", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
                  Text("${selectedInterests.length} / 3", style: TextStyle(color: (selectedInterests.length > 3) ? Colors.red : Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text("Interests make it easier to find who shares your interests. Add 3 to your profile to make better connections.", style: TextStyle(color: Colors.grey.shade700)),
              const SizedBox(
                height: 10,
              ),
              TfOutlined(
                  controller: teSearch,
                  hint: "Search",
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade700,),
              ),
              const SizedBox(height: 10,),
              InlineChoice<String>(
                multiple: true,
                clearable: true,
                value: selectedInterests,
                onChanged: setMultipleSelected,
                itemCount: INTERESTS.length,
                itemBuilder: (selection, i) {
                  RxBool isSelected = false.obs;
                  selection.selected(INTERESTS[i]) ? isSelected.value = true : isSelected.value = false;
                  return Obx(() => ChoiceChip(
                    padding: EdgeInsets.zero,
                    showCheckmark: false,
                    selected: selection.selected(INTERESTS[i]),
                    onSelected: (value) {
                      if (selection.length < 3 || selection.value.contains(INTERESTS[i])) {
                        selection.select(INTERESTS[i]);
                        selectedInterests = selection.value;
                      } else {
                        showMsg(context, "Max Selection Reached", Colors.red);
                      }
                    },
                    label: Text(INTERESTS[i]),
                    backgroundColor: Colors.white,
                    selectedColor: Colors.white,
                    labelStyle: TextStyle(color: isSelected.value ? unselectedTextColor : selectedTextColor, fontSize: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: isSelected.value ? const BorderSide(color: unselectedTextColor) : BorderSide(color: selectedTextColor),
                    ),
                  ));
                },
                listBuilder: ChoiceList.createWrapped(
                  spacing: 8,
                  runSpacing: 0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
