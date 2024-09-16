class User {
  var _name;
  var _email;
  var _password;
  var _city;
  var _genre;
  var _isActionFavorite;
  var _isAdventureFavorite;
  var _isFictionFavorite;
  var _isSuspenseFavorite;
  var _bornDate;

  User.Empty();

  Map<String, dynamic> toJson() =>
      {
        'name': _name,
        'email': _email,
        'password': _password,
        'city': _city,
        'genre': _genre,
        'isActionFavorite': _isActionFavorite,
        'isAdventureFavorite': _isAdventureFavorite,
        'isFictionFavorite': _isFictionFavorite,
        'isSuspenseFavorite': _isSuspenseFavorite,
        'bornDate': _bornDate
      };

  User.fromJson(Map<String, dynamic> json)
      : _name = json['name'],
        _email = json['email'],
        _password = json['password'],
        _city = json['city'],
        _genre = json['genre'],
        _isActionFavorite = json['isActionFavorite'],
        _isAdventureFavorite = json['isAdventureFavorite'],
        _isFictionFavorite = json['isFictionFavorite'],
        _isSuspenseFavorite = json['isSuspenseFavorite'],
        _bornDate = json['bornDate'];


        get name => _name;

  set name(value) {
    _name = value;
  }

  get email => _email;

  get bornDate => _bornDate;

  set bornDate(value) {
    _bornDate = value;
  }

  get isSuspenseFavorite => _isSuspenseFavorite;

  set isSuspenseFavorite(value) {
    _isSuspenseFavorite = value;
  }

  get isFictionFavorite => _isFictionFavorite;

  set isFictionFavorite(value) {
    _isFictionFavorite = value;
  }

  get isAdventureFavorite => _isAdventureFavorite;

  set isAdventureFavorite(value) {
    _isAdventureFavorite = value;
  }

  get isActionFavorite => _isActionFavorite;

  set isActionFavorite(value) {
    _isActionFavorite = value;
  }

  get genre => _genre;

  set genre(value) {
    _genre = value;
  }

  get city => _city;

  set city(value) {
    _city = value;
  }

  get password => _password;

  set password(value) {
    _password = value;
  }

  set email(value) {
    _email = value;
  }

  User(this._name,
      this._email,
      this._password,
      this._city,
      this._genre,
      this._isActionFavorite,
      this._isAdventureFavorite,
      this._isFictionFavorite,
      this._isSuspenseFavorite,
      this._bornDate);
}

