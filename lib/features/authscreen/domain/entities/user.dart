class User {
  final String token;
   String? tokenType;
   int? expiresIn;
   int ?status;
   int ?verified;
   String? type;

  User({
    required this.token,
     this.tokenType,
     this.expiresIn,
     this.status,
     this.verified,
    this.type,
  });
}
