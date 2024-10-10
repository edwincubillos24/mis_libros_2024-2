class LocalBook{
  int _id;
  String _name;
  String _author;
  int _pages;
  double _rating;
  bool _isActionGenre;
  bool _isAdventureGenre;
  bool _isDramaGenre;
  bool _isFantasyGenre;
  bool _isFictionGenre;
  bool _isRomanceGenre;
  bool _isSuspenseGenre;
  bool _isTerrorGenre;
  String _urlPicture;

  Map<String, dynamic> toJson() => {
    'id' : _id,
    'name' : _name,
    'author': _author,
    'pages': _pages,
    'rating': _rating,
    'is_action_genre': _isActionGenre,
    'is_adventure_genre': _isAdventureGenre,
    'is_fiction_genre': _isFictionGenre,
    'is_drama_genre': _isDramaGenre,
    'is_fantasy_genre': _isFantasyGenre,
    'is_romance_genre': _isRomanceGenre,
    'is_suspense_genre': _isSuspenseGenre,
    'is_terror_genre': _isTerrorGenre,
    'url_picture': _urlPicture,
  };

  LocalBook.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _name = json['name'],
        _author = json['author'],
        _pages = json['pages'],
        _rating = json['rating'],
        _isActionGenre = json['is_action_genre'],
        _isAdventureGenre = json['is_adventure_genre'],
        _isFictionGenre = json['is_fiction_genre'],
        _isDramaGenre = json['is_drama_genre'],
        _isFantasyGenre = json['is_fantasy_genre'],
        _isRomanceGenre = json['is_romance_genre'],
        _isSuspenseGenre = json['is_suspense_genre'],
        _isTerrorGenre = json['is_terror_genre'],
        _urlPicture = json['url_picture'];

  get id => _id;

  set id(value) {
    _id = value;
  }

  LocalBook(
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