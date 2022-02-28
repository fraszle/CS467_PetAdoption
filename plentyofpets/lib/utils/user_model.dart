class NewUser {
  final String firstName;
  final String lastName;
  final String city;
  final String state;
  final String zipCode;
  final String email;
  final String password;
  final bool organization;
  final String? organizationName;
  final String? organizationUrl;
  final List favs = [];

  NewUser(NewUserBuilder builder)
      : firstName = builder.firstName!,
        lastName = builder.lastName!,
        city = builder.city!,
        state = builder.state!,
        zipCode = builder.zipCode!,
        email = builder.email!,
        password = builder.password!,
        organization = builder.organization,
        organizationName = builder.organizationName,
        organizationUrl = builder.organizationUrl;

  /// Converts this User to a map to send to the Firebase API
  Map<String, dynamic> toMap() {
    // Add common fields
    Map<String, dynamic> userInfo = {};
    userInfo['firstName'] = firstName;
    userInfo['lastName'] = lastName;
    userInfo['email'] = email;
    userInfo['isAdmin'] = organization;
    userInfo['location'] = {'city': city, 'state': state, 'zip': zipCode};
    userInfo['favs'] = favs;

    // Add Admin specific fields
    if (organization) {
      userInfo['organization'] = organizationName;
      userInfo['url'] = organizationUrl;
    }

    return userInfo;
  }
}

class NewUserBuilder {
  String? firstName;
  String? lastName;
  String? city;
  String? state;
  String? zipCode;
  String? email;
  String? password;
  bool organization = false;
  String? organizationName;
  String? organizationUrl;

  NewUser build() {
    return NewUser(this);
  }
}
