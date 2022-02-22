// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
//
// import '../../core/values/colors.dart';
//
// class TextFieldPlus extends StatefulWidget {
//   const TextFieldPlus({
//     key,
//     required this.text,
//     required this.name,
//     this.helpText,
//     this.initialValue,
//     this.suffixIcon,
//     this.prefixIcon,
//     this.validator,
//     this.onTap,
//     this.onChanged,
//     this.onSaved,
//     this.onEditingComplete,
//     this.onSubmitted,
//     this.isPassword = false,
//     this.textInputAction,
//     this.onFocusChange,
//     this.formKey,
//     this.maxLines = 1,
//     this.controller,
//     this.keyboardType,
//     this.enabled = true,
//   }) : super(key: key);
//
//   final String name;
//   final String text;
//   final String? helpText;
//   final String? initialValue;
//   final Widget? suffixIcon;
//   final Widget? prefixIcon;
//   final String? Function(String?)? validator;
//   final Function? onTap;
//   final ValueChanged<String?>? onChanged;
//   final FormFieldSetter<String>? onSaved;
//   final Function? onEditingComplete;
//   final Function? onSubmitted;
//   final bool isPassword;
//   final TextInputAction? textInputAction;
//   final Function(bool)? onFocusChange;
//   final GlobalKey<FormBuilderState>? formKey;
//   final int maxLines;
//   final TextEditingController? controller;
//   final TextInputType? keyboardType;
//   final bool enabled;
//
//   @override
//   _TextFieldPlusState createState() => _TextFieldPlusState();
// }
//
// class _TextFieldPlusState extends State<TextFieldPlus> {
//   var focusColor = ColorsStyle.gray700;
//   var enabledColor = ColorsStyle.gray200;
//   var disabledColor = ColorsStyle.gray200;
//   var errorColor = ColorsStyle.warning400;
//
//   final FocusNode _focusNode = FocusNode();
//   bool hasError = false;
//   bool hasFocus = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _focusNode.addListener(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     InputDecorationTheme inputTheme = Theme.of(context).inputDecorationTheme;
//
//     bool enableSuggestions = true;
//     bool autocorrect = true;
//     bool obscureText = false;
//
//     if (widget.isPassword) {
//       enableSuggestions = false;
//       autocorrect = false;
//       obscureText = true;
//     }
//     return Focus(
//       child: FormBuilderTextField(
//         name: widget.name,
//         keyboardType: widget.keyboardType,
//         validator: (String? value) {
//           if (widget.validator != null) {
//             String? validation = widget.validator!(value);
//
//             setState(() => hasError = validation != null ? true : false);
//
//             return validation;
//           } else {
//             return null;
//           }
//         },
//         cursorColor: ColorsStyle.gray200,
//         initialValue: widget.initialValue,
//         decoration: InputDecoration(
//           labelStyle: hasError ? inputTheme.errorStyle : inputTheme.labelStyle,
//           helperText: widget.helpText,
//           prefixIcon: widget.prefixIcon,
//           suffixIcon: Padding(
//             padding: const EdgeInsetsDirectional.only(end: 8),
//             child: widget.suffixIcon,
//           ),
//           suffixIconConstraints:
//               BoxConstraints(maxHeight: 32, maxWidth: 32),
//           labelText: widget.text,
//         ),
//         enabled: widget.enabled,
//         onTap: widget.onTap as void Function()?,
//         onChanged: widget.onChanged,
//         onSaved: widget.onSaved,
//         onEditingComplete: widget.onEditingComplete as void Function()?,
//         onSubmitted: widget.onSubmitted as void Function(String?)?,
//         enableSuggestions: enableSuggestions,
//         autocorrect: autocorrect,
//         obscureText: obscureText,
//         textInputAction: widget.textInputAction,
//         controller: widget.controller,
//         maxLines: widget.maxLines,
//         obscuringCharacter: '•',
//       ),
//       onFocusChange: (_hasFocus) {
//         setState(() => hasFocus = _hasFocus);
//
//         if (widget.onFocusChange != null) {
//           widget.onFocusChange!(_hasFocus);
//         }
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     _focusNode.dispose();
//     super.dispose();
//   }
//
//   TextFieldStatus get status {
//     TextFieldStatus _status = TextFieldStatus.enabled;
//     bool enabled = widget.enabled;
//
//     if (enabled) {
//       if (hasError) {
//         _status = TextFieldStatus.error;
//       } else if (hasFocus) {
//         _status = TextFieldStatus.focus;
//       }
//     } else {
//       _status = TextFieldStatus.disabled;
//     }
//     return _status;
//   }
// }
//
// enum TextFieldStatus { enabled, disabled, focus, error }
