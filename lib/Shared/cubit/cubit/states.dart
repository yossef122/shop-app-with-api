abstract class appstates {}

class initialState extends appstates{}

class appnavbarstate extends appstates{}

class Bottomnavbarchangestate extends appstates{}

class Newgetbussinessloadingstate extends appstates{}

class Newgetbussinessuccessedstate extends appstates{}

class Newgetbussineerrorstate extends appstates{
  final String error;

  Newgetbussineerrorstate(this.error);

}

class Newgetsportsloadingstate extends appstates{}

class Newthememodegstate extends appstates{}

class Newgetsportssuccessedstate extends appstates{}

class Newgetsportserrorstate extends appstates{
  final String error;

  Newgetsportserrorstate(this.error);

}

class Newgetscienceloadingstate extends appstates{}

class Newgetsciencesuccessedstate extends appstates{}

class Newgetscienceerrorstate extends appstates{
  final String error;
  Newgetscienceerrorstate(this.error);
}


class Newgetsearchloadingstate extends appstates{}

class Newgetsearchsuccessedstate extends appstates{}

class Newgetsearcherrorstate extends appstates{
  final String error;
  Newgetsearcherrorstate(this.error);
}