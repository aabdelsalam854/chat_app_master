import 'package:chat_master/features/chat/domain/entities/metadata_entity.dart';

class MetadataModel extends MetadataEntity {
  const MetadataModel(
      {required super.fileName,
      required super.details,
      required super.fileSize,
      required super.width,
      required super.fileType,
      required super.height});

  factory MetadataModel.fromJson(Map<String, dynamic> jsonData) {
    return MetadataModel(
      fileName: jsonData['fileName'],
      fileSize: jsonData['fileSize'],
      width: jsonData['width'],
      height: jsonData['height'],
      fileType: jsonData['fileType'],
      details: jsonData['details'],
    );
  }
  Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "fileSize": fileSize,
        "width": width,
        "height": height,
        "fileType": fileType,
        "details": details,
      };
}
