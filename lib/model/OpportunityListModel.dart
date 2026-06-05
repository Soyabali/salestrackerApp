class OpportunityListModel {
  String? result;
  String? msg;
  List<OpportunityData>? data;

  OpportunityListModel({
    this.result,
    this.msg,
    this.data,
  });

  OpportunityListModel.fromJson(Map<String, dynamic> json) {
    result = json['Result'];
    msg = json['Msg'];

    if (json['Data'] != null) {
      data = <OpportunityData>[];
      json['Data'].forEach((v) {
        data!.add(OpportunityData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};

    dataMap['Result'] = result;
    dataMap['Msg'] = msg;

    if (data != null) {
      dataMap['Data'] = data!.map((v) => v.toJson()).toList();
    }

    return dataMap;
  }
}

class OpportunityData {
  int? iTranId;
  String? sOpportunityRevId;
  String? sRemarks;
  String? sOpportunityRevName;

  String? sUploadDoc1;
  String? sUploadDoc2;
  String? sUploadDoc3;
  String? sUploadDoc4;
  String? sUploadDoc5;
  String? sUploadDoc6;
  String? sUploadDoc7;

  String? sUserName;

  String? sUploadDoc1IconType;
  String? sUploadDoc2IconType;
  String? sUploadDoc3IconType;
  String? sUploadDoc4IconType;
  String? sUploadDoc5IconType;
  String? sUploadDoc6IconType;
  String? sUploadDoc7IconType;

  String? sCreatedAt;
  String? sAction;
  String? sActionRemarks;

  OpportunityData({
    this.iTranId,
    this.sOpportunityRevId,
    this.sRemarks,
    this.sOpportunityRevName,
    this.sUploadDoc1,
    this.sUploadDoc2,
    this.sUploadDoc3,
    this.sUploadDoc4,
    this.sUploadDoc5,
    this.sUploadDoc6,
    this.sUploadDoc7,
    this.sUserName,
    this.sUploadDoc1IconType,
    this.sUploadDoc2IconType,
    this.sUploadDoc3IconType,
    this.sUploadDoc4IconType,
    this.sUploadDoc5IconType,
    this.sUploadDoc6IconType,
    this.sUploadDoc7IconType,
    this.sCreatedAt,
    this.sAction,
    this.sActionRemarks,
  });

  OpportunityData.fromJson(Map<String, dynamic> json) {
    iTranId = json['iTranId'];
    sOpportunityRevId = json['sOpportunityRevId'];
    sRemarks = json['sRemarks'];
    sOpportunityRevName = json['sOpportunityRevName'];

    sUploadDoc1 = json['sUploadDoc1'];
    sUploadDoc2 = json['sUploadDoc2'];
    sUploadDoc3 = json['sUploadDoc3'];
    sUploadDoc4 = json['sUploadDoc4'];
    sUploadDoc5 = json['sUploadDoc5'];
    sUploadDoc6 = json['sUploadDoc6'];
    sUploadDoc7 = json['sUploadDoc7'];

    sUserName = json['sUserName'];

    sUploadDoc1IconType = json['sUploadDoc1IconType'];
    sUploadDoc2IconType = json['sUploadDoc2IconType'];
    sUploadDoc3IconType = json['sUploadDoc3IconType'];
    sUploadDoc4IconType = json['sUploadDoc4IconType'];
    sUploadDoc5IconType = json['sUploadDoc5IconType'];
    sUploadDoc6IconType = json['sUploadDoc6IconType'];
    sUploadDoc7IconType = json['sUploadDoc7IconType'];

    sCreatedAt = json['sCreatedAt'];
    sAction = json['sAction'];
    sActionRemarks = json['sActionRemarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['iTranId'] = iTranId;
    data['sOpportunityRevId'] = sOpportunityRevId;
    data['sRemarks'] = sRemarks;
    data['sOpportunityRevName'] = sOpportunityRevName;

    data['sUploadDoc1'] = sUploadDoc1;
    data['sUploadDoc2'] = sUploadDoc2;
    data['sUploadDoc3'] = sUploadDoc3;
    data['sUploadDoc4'] = sUploadDoc4;
    data['sUploadDoc5'] = sUploadDoc5;
    data['sUploadDoc6'] = sUploadDoc6;
    data['sUploadDoc7'] = sUploadDoc7;

    data['sUserName'] = sUserName;

    data['sUploadDoc1IconType'] = sUploadDoc1IconType;
    data['sUploadDoc2IconType'] = sUploadDoc2IconType;
    data['sUploadDoc3IconType'] = sUploadDoc3IconType;
    data['sUploadDoc4IconType'] = sUploadDoc4IconType;
    data['sUploadDoc5IconType'] = sUploadDoc5IconType;
    data['sUploadDoc6IconType'] = sUploadDoc6IconType;
    data['sUploadDoc7IconType'] = sUploadDoc7IconType;

    data['sCreatedAt'] = sCreatedAt;
    data['sAction'] = sAction;
    data['sActionRemarks'] = sActionRemarks;

    return data;
  }
}