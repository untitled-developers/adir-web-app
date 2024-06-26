//Make sure that that the order, indices, and keys matter here.
//Some pages depend on other using the index of a question
//The first three questions should always be at the beginning of the map, in case you need to change that, please check the code

Map<String, dynamic> staticQuestions = {
  'carbrand': {
    'languages': {'EN': "Car Brand", 'FR': '', 'AR': ''},
    'value': [
      'Mercedes',
      'Honda',
      'Porsche',
      'Land Rover',
      'Other',
    ],
    'answer': ''
  },
  'carvalue': {
    'languages': {'EN': "Enter the car value in USD(\$)", 'FR': '', 'AR': ''},
    'value': 'double',
    'answer': ''
  },
  'yearofmake': {
    'languages': {'EN': "Year of Make", 'FR': '', 'AR': ''},
    'value': 'int',
    'answer': ''
  },
  'insurancetype': {
    'languages': {'EN': "Insurance Type", 'FR': '', 'AR': ''},
    'value': ['Motor All Risks', 'Motor All Risks Plus'],
    'answer': ''
  },
  'elzemeh': {
    'languages': {'EN': "Elzemeh", 'FR': '', 'AR': ''},
    'value': 'bool',
    'answer': '0'
  },
  'registrationnumber': {
    'languages': {'EN': "Registration Number", 'FR': '', 'AR': ''},
    'value': 'double',
    'answer': ''
  },
  'chassisnumber': {
    'languages': {'EN': "Chassis Number", 'FR': '', 'AR': ''},
    'value': 'double',
    'answer': ''
  },
  'paymentmethod': {
    'languages': {'EN': "How would you like to pay?", 'FR': '', 'AR': ''},
    'value': ['Fresh Card', 'Cash on Delivery'],
    'answer': ''
  },
  'email': {
    'languages': {'EN': "Email", 'FR': '', 'AR': ''},
    'value': 'string',
    'answer': ''
  },
};
