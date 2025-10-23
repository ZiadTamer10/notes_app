import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubits/notes_cubit/notes_cubit.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/widgets/custom_app_bar.dart';
import 'package:notes_app/widgets/custom_text_field.dart';

class EditNoteViewBody extends StatefulWidget {
  const EditNoteViewBody({super.key, required this.note});

  final NoteModel note;

  @override
  State<EditNoteViewBody> createState() => _EditNoteViewBodyState();
}

class _EditNoteViewBodyState extends State<EditNoteViewBody> {
  String? title, subTitile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          SizedBox(height: 10),
          CustomAppBar(
            onPressed: () {
              widget.note.title = title ?? widget.note.title;
              widget.note.subTitle = subTitile ?? widget.note.subTitle;
              widget.note.save();
              BlocProvider.of<NotesCubit>(context).fetchAllNotes();
              Navigator.pop(context);
            },
            title: 'Edit Note',
            icon: Icons.check,
          ),
          SizedBox(height: 10),
          CustomTextField(
            hintText: widget.note.title,
            onChanged: (value) {
              title = value;
            },
          ),
          SizedBox(height: 16),
          CustomTextField(
            hintText: widget.note.subTitle,
            onChanged: (value) {
              subTitile = value;
            },
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}

//? if i want to edit the content istelf in the note :
//? first : we must use TextEditingController
//? go to CustomTextField and create variable => Controller
//? second : in EditNoteViewBody
//? create variable => TextEditingController titleController && TextEditingController subTitleController;
//? third : in initState هنعرف المتغيرات اللي عملناها و هيكون باعتينله القيم القديمه
//? fourth : path the controller to CustomTextField
