import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:long_text_translator_gpt/repository/TranslationNoteRepository.dart';

import '../../bloc/main/main_cubit.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  Widget buildAddNewButton(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<MainCubit>().goToStartUp();
      },
      child: const SizedBox(
        height: 50,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Icon(Icons.add, size: 18),
              SizedBox(width: 6),
              Text(
                '새로 시작',
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNoteList(BuildContext context, TranslationNoteListItem item) {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: () {
        context.read<MainCubit>().selectNoteListItem(item.id);
      },
      child: Container(
        height: 35,
        width: double.infinity,
        child: Row(
          children: [
            const SizedBox(width: 4),
            const Icon(Icons.sticky_note_2_outlined, size: 12),
            const SizedBox(width: 7),
            Text(
              item.title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Notes",
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color(0xFF5D5D5D),
                    ),
                  ),
                  const SizedBox(height: 10),
                  BlocSelector<MainCubit, MainState,
                      List<TranslationNoteListItem>>(
                    selector: (state) => state.noteList,
                    builder: (context, noteList) {
                      return Column(
                        children: noteList
                            .map((item) => buildNoteList(context, item))
                            .toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: const Color(0xFFECECEC),
        ),
        buildAddNewButton(context),
      ],
    );
  }
}
