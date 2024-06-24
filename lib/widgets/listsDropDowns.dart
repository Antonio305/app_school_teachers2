import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services/group_services.dart';
import '../Services/subject_services.dart';
import '../models/group.dart';
import '../models/subjects.dart';
import '../providers/menu_option_provider.dart';

class DropDownGroups extends StatefulWidget {
  final Function onTap;

  const DropDownGroups({super.key, required this.onTap});

  @override
  // ignore: library_private_types_in_public_api
  _DropDownGroupsState createState() => _DropDownGroupsState();
}

class _DropDownGroupsState extends State<DropDownGroups> {
  List<GroupElement> groups = [];
  String initialValue = '';

  @override
  Widget build(BuildContext context) {
    final groupServices = Provider.of<GroupServices>(context);
    groups = groupServices.group.groups;
    final dropMemu = Provider.of<MenuOptionProvider>(context);

    return DropdownButton<String>(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        // hint: const Text('dsff'),
        borderRadius: BorderRadius.circular(10),
        // icon: const Icon(Icons.vaccines),
        value: dropMemu.dropdownMenuItemGroup,
        items: List.generate(groups.length, (index) {
          return DropdownMenuItem<String>(
              onTap: () {
                // teacherS.selectedTeacher = teachers[index];
                groupServices.selectedGroup = groups[index];
                dropMemu.dropdownMenuItemGroup = groups[index].name;
                widget.onTap();
              },
              value: groups[index].name,
              child: Text(
                groups[index].name,
                style: const TextStyle(fontSize: 14),
              ));
        }),
        onChanged: (String? value) {
          dropMemu.dropdownMenuItemGroup = value!;
        });
  }
}

class DropDownSubjects extends StatefulWidget {
  final Function onTap;

  const DropDownSubjects({super.key, required this.onTap});

  @override
  State<DropDownSubjects> createState() => _DropDownSubjectsState();
}

class _DropDownSubjectsState extends State<DropDownSubjects> {
  List<Subjects> subjects = [];
  String initialValue = '';

  @override
  Widget build(BuildContext context) {
    final subjectsServices = Provider.of<SubjectServices>(context);
    subjects = subjectsServices.subjects;
    final dropMemu = Provider.of<MenuOptionProvider>(context);

    return DropdownButton(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        borderRadius: BorderRadius.circular(10),
        value: dropMemu.dropDownMenuItemSubject,
        items: List.generate(subjects.length, (index) {
          return DropdownMenuItem<String>(
              onTap: () {
                subjectsServices.selectedSubject = subjects[index];
                widget.onTap();
              },
              value: subjects[index].name,
              child: Text(subjects[index].name));
        }),
        onChanged: (String? value) {
          dropMemu.dropDownMenuItemSubject = value!;
        });
  }
}
