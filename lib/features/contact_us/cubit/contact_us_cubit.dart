import 'package:bloc/bloc.dart';
import 'package:khadamat/core/remote/service.dart';
import 'package:meta/meta.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit(this.api) : super(ContactUsInitial());
  final ServiceApi api ;
}
