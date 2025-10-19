part of 'read_note_cubit.dart';

@immutable
sealed class ReadNoteState {}

final class ReadNoteInitial extends ReadNoteState {}

final class ReadNoteLoading extends ReadNoteState {}

final class ReadNoteSuccess extends ReadNoteState {
  final List<NoteModel> notes;

  ReadNoteSuccess(this.notes);
}

final class ReadNoteFailure extends ReadNoteState {
  final String errMessage;

  ReadNoteFailure(this.errMessage);
}
