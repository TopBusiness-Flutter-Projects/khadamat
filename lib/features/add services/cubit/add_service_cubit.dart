import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_service_state.dart';

class AddServiceCubit extends Cubit<AddServiceState> {
  AddServiceCubit() : super(AddServiceInitial());
}
