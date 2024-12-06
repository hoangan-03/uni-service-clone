import 'package:flutter/widgets.dart';
import 'package:flutter_base_v2/base/data/app_error.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

typedef MyFormFieldState
    = FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>;

enum FormFieldType {
  email,
  password,
}

extension FormFieldTypeExtension on FormFieldType {
  String get labelText {
    switch (this) {
      case FormFieldType.email:
        return SS.login_info;
      case FormFieldType.password:
        return SS.password;
      default:
        return '';
    }
  }

  String get hintText {
    switch (this) {
      case FormFieldType.email:
        return SS.enter_email;
      case FormFieldType.password:
        return SS.enter_password;
      default:
        return '';
    }
  }

  TextInputType get keyboardType {
    switch (this) {
      case FormFieldType.email:
        return TextInputType.emailAddress;
      default:
        return TextInputType.text;
    }
  }

  MyFormFieldState field(FormBuilderState formBuilderState) {
    final field = formBuilderState.fields[name];
    if (field == null) {
      throw AppException.invalidInput('Cannot detect state of form key');
    }

    return field;
  }

  FormFieldValidator<String?>? validator() {
    List<FormFieldValidator<String?>> validators = [];
    switch (this) {
      case FormFieldType.email:
        validators = [
          FormBuilderValidators.required(
              errorText: SS.enter_email),
          FormBuilderValidators.email(
              errorText: SS.invalid_email),
          FormBuilderValidators.maxLength(128,
              errorText: SS.invalid_email),
        ];
        break;
      case FormFieldType.password:
        validators = [
          FormBuilderValidators.required(
              errorText: SS.enter_password),
          FormBuilderValidators.minLength(8,
              errorText: SS.included_uppercase_lowercase_number_special_character),
        ];
        break;
      default:
        return null;
    }

    return FormBuilderValidators.compose(validators);
  }
}

extension FormKeyExtension on GlobalKey<FormBuilderState> {
  FormBuilderState? get formBuilderState {
    return currentState;
  }
}

extension ListFormFieldState on List<MyFormFieldState> {
  void validateFormFields() {
    FocusManager.instance.primaryFocus?.unfocus();
    final isValid = map((e) => e.validate()).reduce((v, e) => v && e);
    if (!isValid) {
      final errorMessage = map(
        (e) => e.errorText == null ? null : '${e.errorText}',
      ).whereType<String>().toList().join('\n');
      throw AppException.invalidInput(errorMessage);
    }
  }
}
