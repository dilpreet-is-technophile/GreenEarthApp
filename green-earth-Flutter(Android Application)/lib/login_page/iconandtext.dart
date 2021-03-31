import 'package:flutter/material.dart';

class EmailWithIcon extends StatefulWidget {
  final IconData icon;
  final String hint;
  final TextInputType keyboard;
  final TextEditingController emailController;
  EmailWithIcon({this.icon, this.hint,this.keyboard,this.emailController});

  @override
  _EmailWithIconState createState() => _EmailWithIconState();
}

class _EmailWithIconState extends State<EmailWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: widget.emailController,
        // ignore: missing_return
        validator: (String value){
          if(!value.contains('@')){
            return 'Please enter a valid email!';
          }
        },
        keyboardType: widget.keyboard,
        style: TextStyle(
            color:  Color(0xFF29a329),
            fontSize: 15.0
        ),
        obscureText: false,
        cursorColor: Color(0xFF29a329),
        decoration: InputDecoration(
            filled: true,
            prefixIcon: Icon(widget.icon,
                color:  Color(0xFFbfbfbf)),
            labelText: widget.hint,
            enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Color(0xFF29a329))
            ),
            labelStyle: TextStyle(color:Color(0xffbfbfbf))
        ),
      ),
    );
  }
}

class UsernameWithIcon extends StatefulWidget {
  final IconData icon;
  final String hint;
  final TextEditingController nameOfUserController;
  UsernameWithIcon({this.icon, this.hint,this.nameOfUserController});
  @override
  _UsernameWithIconState createState() => _UsernameWithIconState();
}

class _UsernameWithIconState extends State<UsernameWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: widget.nameOfUserController,
        // ignore: missing_return
        validator: (String value){
          if(value.isEmpty){
            return 'Please enter a username';
          }
        },
        style: TextStyle(
            color:  Color(0xFF29a329),
            fontSize: 15.0
        ),
        obscureText: false,
        cursorColor: Color(0xFF29a329),
        decoration: InputDecoration(
            filled: true,
            prefixIcon: Icon(widget.icon,
                color:  Color(0xFFbfbfbf)),
            labelText: widget.hint,
            enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Color(0xFF29a329))
            ),
            labelStyle: TextStyle(color:Color(0xffbfbfbf))
        ),
      ),
    );
  }
}

class PasswordWithIcon extends StatefulWidget {
  final IconData icon;
  final String hint;
  final TextInputType keyboard;
  final TextEditingController passwordController;
  PasswordWithIcon({this.icon, this.hint,this.keyboard,this.passwordController});

  @override
  _PasswordWithIconState createState() => _PasswordWithIconState();
}

class _PasswordWithIconState extends State<PasswordWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: widget.passwordController,
        // ignore: missing_return
        validator: (String value){
          if(value.length < 4){
            return 'Please enter a password of atleast 4 characters';
          }
        },
        keyboardType: widget.keyboard,
        style: TextStyle(
            color:  Color(0xFF29a329),
            fontSize: 15.0
        ),
        obscureText: true,
        cursorColor: Color(0xFF29a329),
        decoration: InputDecoration(
            filled: true,
            prefixIcon: Icon(widget.icon,
                color:  Color(0xFFbfbfbf)),
            labelText: widget.hint,
            enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Color(0xFF29a329))
            ),
            labelStyle: TextStyle(color:Color(0xFFbfbfbf))
        ),
      ),
    );
  }
}

class PrimaryButton extends StatefulWidget {
  final String btnText;
  PrimaryButton({this.btnText});

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFF29a329),
          borderRadius: BorderRadius.circular(50)
      ),
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16
          ),
        ),
      ),
    );
  }
}

class OutlineBtn extends StatefulWidget {
  final String btnText;
  OutlineBtn({this.btnText});

  @override
  _OutlineBtnState createState() => _OutlineBtnState();
}

class _OutlineBtnState extends State<OutlineBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: Color(0xFF29a329),
              width: 2
          ),
          borderRadius: BorderRadius.circular(50)
      ),
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(
              color: Color(0xFFB40284A),
              fontSize: 16
          ),
        ),
      ),
    );
  }
}