import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/widgets/colors_list_view.dart';
import 'package:notes_app/widgets/custom_button.dart';
import 'package:notes_app/widgets/custom_text_field.dart';

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({super.key});

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final GlobalKey<FormState> formKey = GlobalKey();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String? title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          SizedBox(height: 32),
          CustomTextField(
            hintText: 'Title',
            onSaved: (value) {
              title = value;
            },
          ),
          SizedBox(height: 16),
          CustomTextField(
            hintText: 'Content',
            onSaved: (value) {
              subTitle = value;
            },
            maxLines: 5,
          ),
          SizedBox(height: 30),
          ColorsListView(),
          SizedBox(height: 30),
          BlocBuilder<AddNoteCubit, AddNoteState>(
            builder: (context, state) {
              return CutomButton(
                isLoading: state is AddNoteLoading ? true : false,
                onTap: handleAddNote,
              );
            },
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  void handleAddNote() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      saveNote();
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  void saveNote() {
    final currentDate = DateTime.now();
    final formattedcurrentDate = DateFormat('MMM dd, yyyy').format(currentDate);

    final note = NoteModel(
      title: title!,
      subTitle: subTitle!,
      date: formattedcurrentDate,
      color: BlocProvider.of<AddNoteCubit>(context).color.value,
    );

    BlocProvider.of<AddNoteCubit>(context).addNote(note);
  }
}
