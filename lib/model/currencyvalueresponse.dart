class CurrencyValueResponse {
  Rates rates;
  String base;
  String date;

  CurrencyValueResponse({this.rates, this.base, this.date});

  CurrencyValueResponse.fromJson(Map<String, dynamic> json) {
    rates = json['rates'] != null ? new Rates.fromJson(json['rates']) : null;
    base = json['base'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rates != null) {
      data['rates'] = this.rates.toJson();
    }
    data['base'] = this.base;
    data['date'] = this.date;
    return data;
  }
}

class Rates {
  num cAD;
  num hKD;
  num iSK;
  num pHP;
  num dKK;
  num hUF;
  num cZK;
  num gBP;
  num rON;
  num sEK;
  num iDR;
  num iNR;
  num bRL;
  num rUB;
  num hRK;
  num jPY;
  num tHB;
  num cHF;
  num eUR;
  num mYR;
  num bGN;
  num tRY;
  num cNY;
  num nOK;
  num nZD;
  num zAR;
  num uSD;
  num mXN;
  num sGD;
  num aUD;
  num iLS;
  num kRW;
  num pLN;

  var curencyMapping = new Map<String, num>();

  Rates(
      {this.cAD,
      this.hKD,
      this.iSK,
      this.pHP,
      this.dKK,
      this.hUF,
      this.cZK,
      this.gBP,
      this.rON,
      this.sEK,
      this.iDR,
      this.iNR,
      this.bRL,
      this.rUB,
      this.hRK,
      this.jPY,
      this.tHB,
      this.cHF,
      this.eUR,
      this.mYR,
      this.bGN,
      this.tRY,
      this.cNY,
      this.nOK,
      this.nZD,
      this.zAR,
      this.uSD,
      this.mXN,
      this.sGD,
      this.aUD,
      this.iLS,
      this.kRW,
      this.pLN});

  Rates.fromJson(Map<String, dynamic> json) {
    cAD = json['CAD'];
    hKD = json['HKD'];
    iSK = json['ISK'];
    pHP = json['PHP'];
    dKK = json['DKK'];
    hUF = json['HUF'];
    cZK = json['CZK'];
    gBP = json['GBP'];
    rON = json['RON'];
    sEK = json['SEK'];
    iDR = json['IDR'];
    iNR = json['INR'];
    bRL = json['BRL'];
    rUB = json['RUB'];
    hRK = json['HRK'];
    jPY = json['JPY'];
    tHB = json['THB'];
    cHF = json['CHF'];
    eUR = json['EUR'];
    mYR = json['MYR'];
    bGN = json['BGN'];
    tRY = json['TRY'];
    cNY = json['CNY'];
    nOK = json['NOK'];
    nZD = json['NZD'];
    zAR = json['ZAR'];
    uSD = json['USD'];
    mXN = json['MXN'];
    sGD = json['SGD'];
    aUD = json['AUD'];
    iLS = json['ILS'];
    kRW = json['KRW'];
    pLN = json['PLN'];

    curencyMapping['CAD'] = cAD;
    curencyMapping['HKD'] = hKD;
    curencyMapping['ISK'] = iSK;
    curencyMapping['PHP'] = pHP;
    curencyMapping['DKK'] = dKK;
    curencyMapping['HUF'] = hUF;
    curencyMapping['CZK'] = cZK;
    curencyMapping['GBP'] = gBP;
    curencyMapping['RON'] = rON;
    curencyMapping['SEK'] = sEK;
    curencyMapping['IDR'] = iDR;
    curencyMapping['INR'] = iNR;
    curencyMapping['BRL'] = bRL;
    curencyMapping['RUB'] = rUB;
    curencyMapping['HRK'] = hRK;
    curencyMapping['JPY'] = jPY;
    curencyMapping['THB'] = tHB;
    curencyMapping['CHF'] = cHF;
    curencyMapping['EUR'] = eUR;
    curencyMapping['MYR'] = mYR;
    curencyMapping['BGN'] = bGN;
    curencyMapping['TRY'] = tRY;
    curencyMapping['CNY'] = cNY;
    curencyMapping['NOK'] = nOK;
    curencyMapping['NZD'] = nZD;
    curencyMapping['ZAR'] = zAR;
    curencyMapping['USD'] = uSD;
    curencyMapping['MXN'] = mXN;
    curencyMapping['SGD'] = sGD;
    curencyMapping['AUD'] = aUD;
    curencyMapping['ILS'] = iLS;
    curencyMapping['KRW'] = kRW;
    curencyMapping['PLN'] = pLN;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CAD'] = this.cAD;
    data['HKD'] = this.hKD;
    data['ISK'] = this.iSK;
    data['PHP'] = this.pHP;
    data['DKK'] = this.dKK;
    data['HUF'] = this.hUF;
    data['CZK'] = this.cZK;
    data['GBP'] = this.gBP;
    data['RON'] = this.rON;
    data['SEK'] = this.sEK;
    data['IDR'] = this.iDR;
    data['INR'] = this.iNR;
    data['BRL'] = this.bRL;
    data['RUB'] = this.rUB;
    data['HRK'] = this.hRK;
    data['JPY'] = this.jPY;
    data['THB'] = this.tHB;
    data['CHF'] = this.cHF;
    data['EUR'] = this.eUR;
    data['MYR'] = this.mYR;
    data['BGN'] = this.bGN;
    data['TRY'] = this.tRY;
    data['CNY'] = this.cNY;
    data['NOK'] = this.nOK;
    data['NZD'] = this.nZD;
    data['ZAR'] = this.zAR;
    data['USD'] = this.uSD;
    data['MXN'] = this.mXN;
    data['SGD'] = this.sGD;
    data['AUD'] = this.aUD;
    data['ILS'] = this.iLS;
    data['KRW'] = this.kRW;
    data['PLN'] = this.pLN;
    return data;
  }
}
