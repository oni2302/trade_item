import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

const double defaultPadding = 16.0;
const double defaultBorderRadious = 12.0;
const Duration defaultDuration = Duration(milliseconds: 300);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Vui lòng nhập mật khẩu.'),
  MinLengthValidator(8, errorText: 'Mật khẩu phải có ít nhất 8 kí tự.'),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])',
      errorText: 'Mật khẩu phải có ít nhât 1 kí tự đặc biệt.')
]);

final emailValidator = MultiValidator([
  RequiredValidator(errorText: 'Vui lòng nhập email.'),
  EmailValidator(errorText: "Vui lòng nhập đúng định dạng email."),
]);

final noValidate = true;