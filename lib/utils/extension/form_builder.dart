import 'package:flutter/widgets.dart';
import 'package:flutter_base_v2/base/data/app_error.dart';
import 'package:flutter_base_v2/generated/l10n.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

typedef MyFormFieldState = FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>;

enum FormFieldType {
  email,
  password,
}

extension FormFieldTypeExtension on FormFieldType {
  String labelText(BuildContext context) {
    switch (this) {
      case FormFieldType.email:
        return S.of(context).login_info;
      case FormFieldType.password:
        return S.of(context).password;
      default:
        return '';
    }
  }

  String hintText(BuildContext context) {
    switch (this) {
      case FormFieldType.email:
        return S.of(context).enter_email;
      case FormFieldType.password:
        return S.of(context).enter_password;
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

  FormFieldValidator<String?>? validator(BuildContext context) {
    List<FormFieldValidator<String?>> validators = [];
    switch (this) {
      case FormFieldType.email:
        validators = [
          FormBuilderValidators.required(errorText: S.of(context).enter_email),
          FormBuilderValidators.email(errorText: S.of(context).invalid_email),
          FormBuilderValidators.maxLength(128, errorText: S.of(context).invalid_email),
        ];
        break;
      case FormFieldType.password:
        validators = [
          FormBuilderValidators.required(errorText: S.of(context).enter_password),
          FormBuilderValidators.minLength(8, errorText: S.of(context).included_uppercase_lowercase_number_special_character),
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