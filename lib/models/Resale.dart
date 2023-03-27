// To parse this JSON data, do
//
//     final resale = resaleFromJson(jsonString);

import 'dart:convert';

Resale resaleFromJson(String str) => Resale.fromJson(json.decode(str));

String resaleToJson(Resale data) => json.encode(data.toJson());

class Resale {
  Resale({
    required this.help,
    required this.success,
    required this.result,
  });

  String help;
  bool success;
  Result result;

  factory Resale.fromJson(Map<String, dynamic> json) => Resale(
        help: json["help"],
        success: json["success"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "help": help,
        "success": success,
        "result": result.toJson(),
      };
}

class Result {
  Result({
    required this.resourceId,
    required this.fields,
    required this.q,
    required this.records,
    required this.links,
    required this.limit,
    required this.total,
  });

  String resourceId;
  List<Field> fields;
  String q;
  List<Record> records;
  Links links;
  int limit;
  int total;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        resourceId: json["resource_id"],
        fields: List<Field>.from(json["fields"].map((x) => Field.fromJson(x))),
        q: json["q"],
        records:
            List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
        links: Links.fromJson(json["_links"]),
        limit: json["limit"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "resource_id": resourceId,
        "fields": List<dynamic>.from(fields.map((x) => x.toJson())),
        "q": q,
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
        "_links": links.toJson(),
        "limit": limit,
        "total": total,
      };
}

class Field {
  Field({
    required this.type,
    required this.id,
  });

  String type;
  String id;

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        type: json["type"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
      };
}

class Links {
  Links({
    required this.start,
    required this.next,
  });

  String start;
  String next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        start: json["start"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "start": start,
        "next": next,
      };
}

class Record {
  Record({
    required this.town,
    required this.flatType,
    required this.fullCount,
    required this.flatModel,
    required this.floorAreaSqm,
    required this.streetName,
    required this.resalePrice,
    required this.rank,
    required this.month,
    required this.remainingLease,
    required this.leaseCommenceDate,
    required this.storeyRange,
    required this.id,
    required this.block,
  });

  Town town;
  FlatType flatType;
  String fullCount;
  FlatModel flatModel;
  String floorAreaSqm;
  StreetName streetName;
  String resalePrice;
  double rank;
  Month month;
  RemainingLease remainingLease;
  String leaseCommenceDate;
  StoreyRange storeyRange;
  int id;
  String block;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        town: townValues.map[json["town"]]!,
        flatType: flatTypeValues.map[json["flat_type"]]!,
        fullCount: json["_full_count"],
        flatModel: flatModelValues.map[json["flat_model"]]!,
        floorAreaSqm: json["floor_area_sqm"],
        streetName: streetNameValues.map[json["street_name"]]!,
        resalePrice: json["resale_price"],
        rank: json["rank"]?.toDouble(),
        month: monthValues.map[json["month"]]!,
        remainingLease: remainingLeaseValues.map[json["remaining_lease"]]!,
        leaseCommenceDate: json["lease_commence_date"],
        storeyRange: storeyRangeValues.map[json["storey_range"]]!,
        id: json["_id"],
        block: json["block"],
      );

  Map<String, dynamic> toJson() => {
        "town": townValues.reverse[town],
        "flat_type": flatTypeValues.reverse[flatType],
        "_full_count": fullCount,
        "flat_model": flatModelValues.reverse[flatModel],
        "floor_area_sqm": floorAreaSqm,
        "street_name": streetNameValues.reverse[streetName],
        "resale_price": resalePrice,
        "rank": rank,
        "month": monthValues.reverse[month],
        "remaining_lease": remainingLeaseValues.reverse[remainingLease],
        "lease_commence_date": leaseCommenceDate,
        "storey_range": storeyRangeValues.reverse[storeyRange],
        "_id": id,
        "block": block,
      };
}

enum FlatModel {
  IMPROVED,
  MODEL_A,
  PREMIUM_APARTMENT,
  PREMIUM_APARTMENT_LOFT,
  THE_2_ROOM
}

final flatModelValues = EnumValues({
  "Improved": FlatModel.IMPROVED,
  "Model A": FlatModel.MODEL_A,
  "Premium Apartment": FlatModel.PREMIUM_APARTMENT,
  "Premium Apartment Loft": FlatModel.PREMIUM_APARTMENT_LOFT,
  "2-room": FlatModel.THE_2_ROOM
});

enum FlatType { THE_5_ROOM, THE_4_ROOM, THE_3_ROOM, THE_2_ROOM }

final flatTypeValues = EnumValues({
  "2 ROOM": FlatType.THE_2_ROOM,
  "3 ROOM": FlatType.THE_3_ROOM,
  "4 ROOM": FlatType.THE_4_ROOM,
  "5 ROOM": FlatType.THE_5_ROOM
});

enum Month {
  THE_201807,
  THE_201808,
  THE_201809,
  THE_201811,
  THE_201812,
  THE_201901,
  THE_201904,
  THE_201906,
  THE_201908,
  THE_201909,
  THE_201910,
  THE_201911,
  THE_201912,
  THE_202001,
  THE_202002,
  THE_202003,
  THE_202004,
  THE_202005,
  THE_202006,
  THE_202007,
  THE_202008,
  THE_202009,
  THE_202010,
  THE_202011,
  THE_202012,
  THE_202101,
  THE_202102,
  THE_202103,
  THE_202104,
  THE_202105,
  THE_202106,
  THE_202107,
  THE_202108,
  THE_202109,
  THE_202110,
  THE_202111,
  THE_202112,
  THE_202201,
  THE_202202,
  THE_202203,
  THE_202204,
  THE_202205,
  THE_202206,
  THE_202207,
  THE_202208,
  THE_202209,
  THE_202210,
  THE_202211,
  THE_202212,
  THE_202301,
  THE_202302,
  THE_202303
}

final monthValues = EnumValues({
  "2018-07": Month.THE_201807,
  "2018-08": Month.THE_201808,
  "2018-09": Month.THE_201809,
  "2018-11": Month.THE_201811,
  "2018-12": Month.THE_201812,
  "2019-01": Month.THE_201901,
  "2019-04": Month.THE_201904,
  "2019-06": Month.THE_201906,
  "2019-08": Month.THE_201908,
  "2019-09": Month.THE_201909,
  "2019-10": Month.THE_201910,
  "2019-11": Month.THE_201911,
  "2019-12": Month.THE_201912,
  "2020-01": Month.THE_202001,
  "2020-02": Month.THE_202002,
  "2020-03": Month.THE_202003,
  "2020-04": Month.THE_202004,
  "2020-05": Month.THE_202005,
  "2020-06": Month.THE_202006,
  "2020-07": Month.THE_202007,
  "2020-08": Month.THE_202008,
  "2020-09": Month.THE_202009,
  "2020-10": Month.THE_202010,
  "2020-11": Month.THE_202011,
  "2020-12": Month.THE_202012,
  "2021-01": Month.THE_202101,
  "2021-02": Month.THE_202102,
  "2021-03": Month.THE_202103,
  "2021-04": Month.THE_202104,
  "2021-05": Month.THE_202105,
  "2021-06": Month.THE_202106,
  "2021-07": Month.THE_202107,
  "2021-08": Month.THE_202108,
  "2021-09": Month.THE_202109,
  "2021-10": Month.THE_202110,
  "2021-11": Month.THE_202111,
  "2021-12": Month.THE_202112,
  "2022-01": Month.THE_202201,
  "2022-02": Month.THE_202202,
  "2022-03": Month.THE_202203,
  "2022-04": Month.THE_202204,
  "2022-05": Month.THE_202205,
  "2022-06": Month.THE_202206,
  "2022-07": Month.THE_202207,
  "2022-08": Month.THE_202208,
  "2022-09": Month.THE_202209,
  "2022-10": Month.THE_202210,
  "2022-11": Month.THE_202211,
  "2022-12": Month.THE_202212,
  "2023-01": Month.THE_202301,
  "2023-02": Month.THE_202302,
  "2023-03": Month.THE_202303
});

enum RemainingLease {
  THE_96_YEARS_06_MONTHS,
  THE_96_YEARS_05_MONTHS,
  THE_96_YEARS_04_MONTHS,
  THE_96_YEARS_02_MONTHS,
  THE_96_YEARS_01_MONTH,
  THE_96_YEARS,
  THE_95_YEARS_10_MONTHS,
  THE_95_YEARS_07_MONTHS,
  THE_95_YEARS_05_MONTHS,
  THE_95_YEARS_06_MONTHS,
  THE_95_YEARS_04_MONTHS,
  THE_95_YEARS_03_MONTHS,
  THE_95_YEARS_09_MONTHS,
  THE_95_YEARS_08_MONTHS,
  THE_95_YEARS_02_MONTHS,
  THE_95_YEARS_01_MONTH,
  THE_95_YEARS,
  THE_94_YEARS_11_MONTHS,
  THE_94_YEARS_10_MONTHS,
  THE_94_YEARS_09_MONTHS,
  THE_94_YEARS_08_MONTHS,
  THE_94_YEARS_07_MONTHS,
  THE_94_YEARS_06_MONTHS,
  THE_94_YEARS_05_MONTHS,
  THE_94_YEARS_04_MONTHS,
  THE_94_YEARS_03_MONTHS,
  THE_94_YEARS_02_MONTHS,
  THE_94_YEARS_01_MONTH,
  THE_94_YEARS,
  THE_93_YEARS_11_MONTHS,
  THE_93_YEARS_10_MONTHS,
  THE_93_YEARS_09_MONTHS,
  THE_93_YEARS_08_MONTHS,
  THE_93_YEARS_06_MONTHS,
  THE_93_YEARS_07_MONTHS,
  THE_93_YEARS_05_MONTHS,
  THE_93_YEARS_04_MONTHS,
  THE_93_YEARS_03_MONTHS,
  THE_93_YEARS_02_MONTHS,
  THE_93_YEARS_01_MONTH,
  THE_93_YEARS,
  THE_92_YEARS_11_MONTHS,
  THE_92_YEARS_10_MONTHS,
  THE_92_YEARS_09_MONTHS,
  THE_92_YEARS_08_MONTHS,
  THE_92_YEARS_07_MONTHS,
  THE_92_YEARS_06_MONTHS,
  THE_92_YEARS_05_MONTHS,
  THE_92_YEARS_04_MONTHS,
  THE_92_YEARS_03_MONTHS,
  THE_92_YEARS_02_MONTHS,
  THE_92_YEARS_01_MONTH,
  THE_92_YEARS,
  THE_91_YEARS_11_MONTHS,
  THE_91_YEARS_10_MONTHS
}

final remainingLeaseValues = EnumValues({
  "91 years 10 months": RemainingLease.THE_91_YEARS_10_MONTHS,
  "91 years 11 months": RemainingLease.THE_91_YEARS_11_MONTHS,
  "92 years": RemainingLease.THE_92_YEARS,
  "92 years 01 month": RemainingLease.THE_92_YEARS_01_MONTH,
  "92 years 02 months": RemainingLease.THE_92_YEARS_02_MONTHS,
  "92 years 03 months": RemainingLease.THE_92_YEARS_03_MONTHS,
  "92 years 04 months": RemainingLease.THE_92_YEARS_04_MONTHS,
  "92 years 05 months": RemainingLease.THE_92_YEARS_05_MONTHS,
  "92 years 06 months": RemainingLease.THE_92_YEARS_06_MONTHS,
  "92 years 07 months": RemainingLease.THE_92_YEARS_07_MONTHS,
  "92 years 08 months": RemainingLease.THE_92_YEARS_08_MONTHS,
  "92 years 09 months": RemainingLease.THE_92_YEARS_09_MONTHS,
  "92 years 10 months": RemainingLease.THE_92_YEARS_10_MONTHS,
  "92 years 11 months": RemainingLease.THE_92_YEARS_11_MONTHS,
  "93 years": RemainingLease.THE_93_YEARS,
  "93 years 01 month": RemainingLease.THE_93_YEARS_01_MONTH,
  "93 years 02 months": RemainingLease.THE_93_YEARS_02_MONTHS,
  "93 years 03 months": RemainingLease.THE_93_YEARS_03_MONTHS,
  "93 years 04 months": RemainingLease.THE_93_YEARS_04_MONTHS,
  "93 years 05 months": RemainingLease.THE_93_YEARS_05_MONTHS,
  "93 years 06 months": RemainingLease.THE_93_YEARS_06_MONTHS,
  "93 years 07 months": RemainingLease.THE_93_YEARS_07_MONTHS,
  "93 years 08 months": RemainingLease.THE_93_YEARS_08_MONTHS,
  "93 years 09 months": RemainingLease.THE_93_YEARS_09_MONTHS,
  "93 years 10 months": RemainingLease.THE_93_YEARS_10_MONTHS,
  "93 years 11 months": RemainingLease.THE_93_YEARS_11_MONTHS,
  "94 years": RemainingLease.THE_94_YEARS,
  "94 years 01 month": RemainingLease.THE_94_YEARS_01_MONTH,
  "94 years 02 months": RemainingLease.THE_94_YEARS_02_MONTHS,
  "94 years 03 months": RemainingLease.THE_94_YEARS_03_MONTHS,
  "94 years 04 months": RemainingLease.THE_94_YEARS_04_MONTHS,
  "94 years 05 months": RemainingLease.THE_94_YEARS_05_MONTHS,
  "94 years 06 months": RemainingLease.THE_94_YEARS_06_MONTHS,
  "94 years 07 months": RemainingLease.THE_94_YEARS_07_MONTHS,
  "94 years 08 months": RemainingLease.THE_94_YEARS_08_MONTHS,
  "94 years 09 months": RemainingLease.THE_94_YEARS_09_MONTHS,
  "94 years 10 months": RemainingLease.THE_94_YEARS_10_MONTHS,
  "94 years 11 months": RemainingLease.THE_94_YEARS_11_MONTHS,
  "95 years": RemainingLease.THE_95_YEARS,
  "95 years 01 month": RemainingLease.THE_95_YEARS_01_MONTH,
  "95 years 02 months": RemainingLease.THE_95_YEARS_02_MONTHS,
  "95 years 03 months": RemainingLease.THE_95_YEARS_03_MONTHS,
  "95 years 04 months": RemainingLease.THE_95_YEARS_04_MONTHS,
  "95 years 05 months": RemainingLease.THE_95_YEARS_05_MONTHS,
  "95 years 06 months": RemainingLease.THE_95_YEARS_06_MONTHS,
  "95 years 07 months": RemainingLease.THE_95_YEARS_07_MONTHS,
  "95 years 08 months": RemainingLease.THE_95_YEARS_08_MONTHS,
  "95 years 09 months": RemainingLease.THE_95_YEARS_09_MONTHS,
  "95 years 10 months": RemainingLease.THE_95_YEARS_10_MONTHS,
  "96 years": RemainingLease.THE_96_YEARS,
  "96 years 01 month": RemainingLease.THE_96_YEARS_01_MONTH,
  "96 years 02 months": RemainingLease.THE_96_YEARS_02_MONTHS,
  "96 years 04 months": RemainingLease.THE_96_YEARS_04_MONTHS,
  "96 years 05 months": RemainingLease.THE_96_YEARS_05_MONTHS,
  "96 years 06 months": RemainingLease.THE_96_YEARS_06_MONTHS
});

enum StoreyRange {
  THE_25_TO_27,
  THE_16_TO_18,
  THE_31_TO_33,
  THE_34_TO_36,
  THE_22_TO_24,
  THE_37_TO_39,
  THE_28_TO_30,
  THE_13_TO_15,
  THE_04_TO_06,
  THE_40_TO_42,
  THE_10_TO_12,
  THE_01_TO_03,
  THE_07_TO_09,
  THE_19_TO_21,
  THE_46_TO_48,
  THE_43_TO_45
}

final storeyRangeValues = EnumValues({
  "01 TO 03": StoreyRange.THE_01_TO_03,
  "04 TO 06": StoreyRange.THE_04_TO_06,
  "07 TO 09": StoreyRange.THE_07_TO_09,
  "10 TO 12": StoreyRange.THE_10_TO_12,
  "13 TO 15": StoreyRange.THE_13_TO_15,
  "16 TO 18": StoreyRange.THE_16_TO_18,
  "19 TO 21": StoreyRange.THE_19_TO_21,
  "22 TO 24": StoreyRange.THE_22_TO_24,
  "25 TO 27": StoreyRange.THE_25_TO_27,
  "28 TO 30": StoreyRange.THE_28_TO_30,
  "31 TO 33": StoreyRange.THE_31_TO_33,
  "34 TO 36": StoreyRange.THE_34_TO_36,
  "37 TO 39": StoreyRange.THE_37_TO_39,
  "40 TO 42": StoreyRange.THE_40_TO_42,
  "43 TO 45": StoreyRange.THE_43_TO_45,
  "46 TO 48": StoreyRange.THE_46_TO_48
});

enum StreetName {
  BOON_TIONG_RD,
  YISHUN_RING_RD,
  PUNGGOL_WAY,
  YISHUN_ST_51,
  UPP_SERANGOON_VIEW,
  PUNGGOL_FIELD,
  PUNGGOL_DR,
  CHOA_CHU_KANG_AVE_5,
  FERNVALE_LINK,
  DAWSON_RD,
  FERNVALE_ST,
  SENGKANG_WEST_WAY,
  CHAI_CHEE_RD,
  PUNGGOL_WALK,
  FAJAR_RD,
  HOUGANG_ST_32,
  EDGEFIELD_PLAINS,
  CIRCUIT_RD,
  COMPASSVALE_CRES,
  TEBAN_GDNS_RD,
  SUMANG_WALK,
  WOODLANDS_ST_31,
  SIMS_PL
}

final streetNameValues = EnumValues({
  "BOON TIONG RD": StreetName.BOON_TIONG_RD,
  "CHAI CHEE RD": StreetName.CHAI_CHEE_RD,
  "CHOA CHU KANG AVE 5": StreetName.CHOA_CHU_KANG_AVE_5,
  "CIRCUIT RD": StreetName.CIRCUIT_RD,
  "COMPASSVALE CRES": StreetName.COMPASSVALE_CRES,
  "DAWSON RD": StreetName.DAWSON_RD,
  "EDGEFIELD PLAINS": StreetName.EDGEFIELD_PLAINS,
  "FAJAR RD": StreetName.FAJAR_RD,
  "FERNVALE LINK": StreetName.FERNVALE_LINK,
  "FERNVALE ST": StreetName.FERNVALE_ST,
  "HOUGANG ST 32": StreetName.HOUGANG_ST_32,
  "PUNGGOL DR": StreetName.PUNGGOL_DR,
  "PUNGGOL FIELD": StreetName.PUNGGOL_FIELD,
  "PUNGGOL WALK": StreetName.PUNGGOL_WALK,
  "PUNGGOL WAY": StreetName.PUNGGOL_WAY,
  "SENGKANG WEST WAY": StreetName.SENGKANG_WEST_WAY,
  "SIMS PL": StreetName.SIMS_PL,
  "SUMANG WALK": StreetName.SUMANG_WALK,
  "TEBAN GDNS RD": StreetName.TEBAN_GDNS_RD,
  "UPP SERANGOON VIEW": StreetName.UPP_SERANGOON_VIEW,
  "WOODLANDS ST 31": StreetName.WOODLANDS_ST_31,
  "YISHUN RING RD": StreetName.YISHUN_RING_RD,
  "YISHUN ST 51": StreetName.YISHUN_ST_51
});

enum Town {
  BUKIT_MERAH,
  YISHUN,
  PUNGGOL,
  HOUGANG,
  CHOA_CHU_KANG,
  SENGKANG,
  QUEENSTOWN,
  BEDOK,
  BUKIT_PANJANG,
  GEYLANG,
  JURONG_EAST,
  WOODLANDS
}

final townValues = EnumValues({
  "BEDOK": Town.BEDOK,
  "BUKIT MERAH": Town.BUKIT_MERAH,
  "BUKIT PANJANG": Town.BUKIT_PANJANG,
  "CHOA CHU KANG": Town.CHOA_CHU_KANG,
  "GEYLANG": Town.GEYLANG,
  "HOUGANG": Town.HOUGANG,
  "JURONG EAST": Town.JURONG_EAST,
  "PUNGGOL": Town.PUNGGOL,
  "QUEENSTOWN": Town.QUEENSTOWN,
  "SENGKANG": Town.SENGKANG,
  "WOODLANDS": Town.WOODLANDS,
  "YISHUN": Town.YISHUN
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
