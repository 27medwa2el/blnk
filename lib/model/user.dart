class UserFields{
  static final String id= 'id';
  static final String firstName= 'fisrtName';
  static final String lastName= 'lastName';
  static final String email= 'email';
  static final String address= 'address';
  static final String town= 'town';
  static final String area= 'area';
  static final String mobileNumber= 'mobileNumber';
  static final String landlineNumber= 'landlineNumber';
  static final String nationalIdFrontImage='nationalIdFrontImage';
  static final String nationalIdBackImage='nationalIdBackImage';
  static final String nationalIdNumber='nationalIdNumber';

  static List<String> getFields() => [id, firstName,lastName,email,address, town, area, mobileNumber,landlineNumber,nationalIdFrontImage,nationalIdBackImage,nationalIdNumber];

}
class User{
  final int? id;
  final String firstName;
  final String lastName;
  final String email;
  final String address;
  final String town;
  final String area;
  final String mobileNumber;
  final String landlineNumber;
  final String nationalIdFrontImage;
  final String nationalIdBackImage;
  final String nationalIdNumber;
  const User(this.id, {
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.address,
      required this.town,
      required this.area,
      required this.mobileNumber,
      required this.landlineNumber,
      required this.nationalIdFrontImage,
      required this.nationalIdBackImage,
      required this.nationalIdNumber
     }
      );
  Map<String, dynamic>toJson()=>{
    UserFields.id : id,
    UserFields.firstName : firstName,
    UserFields.lastName : lastName,
    UserFields.email : email,
    UserFields.address : address,
    UserFields.town: town,
    UserFields.area: area,
    UserFields.mobileNumber: mobileNumber,
    UserFields.landlineNumber: landlineNumber,
    UserFields.nationalIdFrontImage: nationalIdFrontImage,
    UserFields.nationalIdBackImage: nationalIdBackImage,
    UserFields.nationalIdNumber: nationalIdNumber,

  };
}