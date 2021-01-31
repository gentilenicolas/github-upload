
import 'dart:convert';

EntregoPagoModel entregoPagoModelFromJson(String str) =>
    EntregoPagoModel.fromJson(json.decode(str));

String entregoPagoModelToJson(EntregoPagoModel data) => json.encode(data.toJson());

class EntregoPagoModel {
  EntregoPagoModel({
    this.id,
    this.descripcion,
 
  });

  int id;
  String descripcion;


  factory EntregoPagoModel.fromJson(Map<String, dynamic> json) => EntregoPagoModel(
        id: json["Id"],
        descripcion: json["Descripcion"],
       
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Descripcion": descripcion,
        
      };
}
