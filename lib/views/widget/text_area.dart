import 'package:flutter_provider_example/view_models/view_models.dart';

class TextArea extends StatefulWidget {

  final String labelText;
  final FormFieldSetter<String> onSaved;

  const TextArea({Key key, this.labelText, this.onSaved}) : super(key: key);

  @override
  _TextAreaState createState() => _TextAreaState();
}

class _TextAreaState extends State<TextArea> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: widget.labelText,
      ),
      onSaved: widget.onSaved,
    );
  }

}