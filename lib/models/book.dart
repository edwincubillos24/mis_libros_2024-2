class Book{
  var _id;
  var _name;
  var _author;
  var _pages;
  var _rating;
  var _isActionGenre;
  var _isAdventureGenre;
  var _isDramaGenre;
  var _isFantasyGenre;
  var _isFictionGenre;
  var _isRomanceGenre;
  var _isSuspenseGenre;
  var _isTerrorGenre;
  var _urlPicture;

  Map<String, dynamic> toJson() => {
    'id' : _id,
    'name' : _name,
    'author': _author,
    'pages': _pages,
    'rating': _rating,
    'isActionGenre': _isActionGenre,
    'isAdventureGenre': _isAdventureGenre,
    'isFictionGenre': _isFictionGenre,
    'isDramaGenre': _isDramaGenre,
    'isFantasyGenre': _isFantasyGenre,
    'isRomanceGenre': _isRomanceGenre,
    'isSuspenseGenre': _isSuspenseGenre,
    'isTerrorGenre': _isTerrorGenre,
    'urlPicture': _urlPicture,
  };

  Book.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _name = json['name'],
        _author = json['author'],
        _pages = json['pages'],
        _rating = json['rating'],
        _isActionGenre = json['isActionGenre'],
        _isAdventureGenre = json['isAdventureGenre'],
        _isFictionGenre = json['isFictionGenre'],
        _isDramaGenre = json['isDramaGenre'],
        _isFantasyGenre = json['isFantasyGenre'],
        _isRomanceGenre = json['isRomanceGenre'],
        _isSuspenseGenre = json['isSuspenseGenre'],
        _isTerrorGenre = json['isTerrorGenre'],
        _urlPicture = json['urlPicture'];

  get id => _id;

  set id(value) {
    _id = value;
  }

  Book(
      this._id,
      this._name,
      this._author,
      this._pages,
      this._rating,
      this._isActionGenre,
      this._isAdventureGenre,
      this._isDramaGenre,
      this._isFantasyGenre,
      this._isFictionGenre,
      this._isRomanceGenre,
      this._isSuspenseGenre,
      this._isTerrorGenre,
      this._urlPicture);

  get name => _name;

  set name(value) {
    _name = value;
  }

  get author => _author;

  set author(value) {
    _author = value;
  }

  get pages => _pages;

  set pages(value) {
    _pages = value;
  }

  get rating => _rating;

  set rating(value) {
    _rating = value;
  }

  get isActionGenre => _isActionGenre;

  set isActionGenre(value) {
    _isActionGenre = value;
  }

  get isAdventureGenre => _isAdventureGenre;

  set isAdventureGenre(value) {
    _isAdventureGenre = value;
  }

  get isDramaGenre => _isDramaGenre;

  set isDramaGenre(value) {
    _isDramaGenre = value;
  }

  get isFantasyGenre => _isFantasyGenre;

  set isFantasyGenre(value) {
    _isFantasyGenre = value;
  }

  get isFictionGenre => _isFictionGenre;

  set isFictionGenre(value) {
    _isFictionGenre = value;
  }

  get isRomanceGenre => _isRomanceGenre;

  set isRomanceGenre(value) {
    _isRomanceGenre = value;
  }

  get isSuspenseGenre => _isSuspenseGenre;

  set isSuspenseGenre(value) {
    _isSuspenseGenre = value;
  }

  get isTerrorGenre => _isTerrorGenre;

  set isTerrorGenre(value) {
    _isTerrorGenre = value;
  }

  get urlPicture => _urlPicture;

  set urlPicture(value) {
    _urlPicture = value;
  }
}