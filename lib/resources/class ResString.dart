class ResString {
  var data ={

    'done': 'Done',
    'company_name':'LOGIC BOLTS',
    'app_name':'CURRENCY CONVERTER',
    'currency_code':'Currency code (INR, USD, EUR, ...)',
    'select_base_currency':'Select your base',
    'currency_to_compare':'Currencies to compare',
    'add_more_currency':'+ Add more currency',
    'today_value':'Today\'s Value',
    'edit_base_currency':'Edit Base currency',
    'button_next':'NEXT',
    'logout':'LOGOUT'

  };
  String get(String key){
    return data[key];
  }
}

