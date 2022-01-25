import 'package:eclipse_task/cubit/post_comments_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewComment extends StatefulWidget {
  const NewComment({
    Key? key,
    required this.postId,
    // required this.addNewComment,
  }) : super(key: key);

  final int postId;
  // final Function addNewComment;

  @override
  State<NewComment> createState() => _NewCommentState();
}

class _NewCommentState extends State<NewComment> {
  final _form = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  final _bodyFocusNode = FocusNode();

  String? _emailString;
  String? _titleString;
  String? _bodyString;

  @override
  void dispose() {
    _titleFocusNode.dispose();
    _bodyFocusNode.dispose();
    super.dispose();
  }

  void _submitData() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    // widget.addNewComment(
    //   widget.postId,
    //   _emailString,
    //   _titleString,
    //   _bodyString,
    // );
    BlocProvider.of<PostCommentsCubit>(context).addNewComment(
      widget.postId,
      _emailString!,
      _titleString!,
      _bodyString!,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: Form(
          key: _form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Adding new comment...',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                initialValue: _emailString,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  label: Text(
                    'Enter email address',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_titleFocusNode),
                validator: (value) {
                  if (!value!.contains('@') || value.isEmpty) {
                    return 'Enter a valid email address!';
                  }
                  return null;
                },
                onSaved: (newValue) => _emailString = newValue,
              ),
              TextFormField(
                initialValue: _titleString,
                textCapitalization: TextCapitalization.sentences,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  label: Text(
                    'Enter title',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_bodyFocusNode),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Must not be empty!';
                  }
                  return null;
                },
                onSaved: (newValue) => _titleString = newValue,
              ),
              TextFormField(
                initialValue: _bodyString,
                textCapitalization: TextCapitalization.sentences,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  label: Text(
                    'Enter comment text',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Must not be empty!';
                  }
                  return null;
                },
                onSaved: (newValue) => _bodyString = newValue,
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                ),
                onPressed: () => _submitData(),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
