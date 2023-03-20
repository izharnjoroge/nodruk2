class WalletModel {
  dynamic totaldeposits;
  dynamic totalusages;
  dynamic balance;
  List<Usages> usages;
  List<Deposits> deposits;

  WalletModel({totaldeposits, totalusages, balance, usages, deposits});

  WalletModel.fromJson(Map<String, dynamic> json) {
    totaldeposits = json['totaldeposits'];
    totalusages = json['totalusages'];
    balance = json['balance'];
    if (json['usages'] != null) {
      usages = <Usages>[];
      json['usages'].forEach((v) {
        usages.add(Usages.fromJson(v));
      });
    }
    if (json['deposits'] != null) {
      deposits = <Deposits>[];
      json['deposits'].forEach((v) {
        deposits.add(Deposits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totaldeposits'] = totaldeposits;
    data['totalusages'] = totalusages;
    data['balance'] = balance;
    if (usages != null) {
      data['usages'] = usages.map((v) => v.toJson()).toList();
    }
    if (deposits != null) {
      data['deposits'] = deposits.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Usages {
  dynamic amount;
  dynamic date;
  dynamic verified;
  dynamic account;
  dynamic cargoid;
  dynamic phoneNumber;
  dynamic name;
  dynamic method;
  dynamic agentNumber;
  dynamic transactioncode;

  Usages(
      {amount,
      date,
      verified,
      account,
      cargoid,
      phoneNumber,
      name,
      method,
      agentNumber,
      transactioncode});

  Usages.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    date = json['date'] != null ? Date.fromJson(json['date']) : null;
    verified = json['verified'];
    account = json['account'];
    cargoid = json['cargoid'];
    phoneNumber = json['phoneNumber'];
    name = json['name'];
    method = json['method'];
    agentNumber = json['agentNumber'];
    transactioncode = json['transactioncode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    if (date != null) {
      data['date'] = date.toJson();
    }
    data['verified'] = verified;
    data['account'] = account;
    data['cargoid'] = cargoid;
    data['phoneNumber'] = phoneNumber;
    data['name'] = name;
    data['method'] = method;
    data['agentNumber'] = agentNumber;
    data['transactioncode'] = transactioncode;
    return data;
  }
}

class Date {
  dynamic iSeconds;
  dynamic iNanoseconds;

  Date({iSeconds, iNanoseconds});

  Date.fromJson(Map<String, dynamic> json) {
    iSeconds = json['_seconds'];
    iNanoseconds = json['_nanoseconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_seconds'] = iSeconds;
    data['_nanoseconds'] = iNanoseconds;
    return data;
  }
}

class Deposits {
  dynamic coorgin;
  dynamic currency;
  dynamic orderId;
  dynamic receipt;
  dynamic cargoid;
  dynamic checksum;
  dynamic account;
  dynamic status;
  dynamic timestamp;
  dynamic amount;
  dynamic checkSum;

  Deposits(
      {coorgin,
      currency,
      orderId,
      receipt,
      cargoid,
      checksum,
      account,
      status,
      timestamp,
      amount,
      checkSum});

  Deposits.fromJson(Map<String, dynamic> json) {
    coorgin = json['coorgin'];
    currency = json['Currency'];
    orderId = json['Order_Id'];
    receipt = json['Receipt'];
    cargoid = json['cargoid'];
    checksum = json['Checksum'];
    account = json['account'];
    status = json['Status'];
    timestamp = json['Timestamp'];
    amount = json['Amount'];
    checkSum = json['CheckSum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['coorgin'] = coorgin;
    data['Currency'] = currency;
    data['Order_Id'] = orderId;
    data['Receipt'] = receipt;
    data['cargoid'] = cargoid;
    data['Checksum'] = checksum;
    data['account'] = account;
    data['Status'] = status;
    data['Timestamp'] = timestamp;
    data['Amount'] = amount;
    data['CheckSum'] = checkSum;
    return data;
  }
}
