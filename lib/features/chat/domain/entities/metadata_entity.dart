import 'package:equatable/equatable.dart';

class MetadataEntity extends Equatable {
  final String? fileName;
  final String? details;
  final String? fileSize;
  final String fileType;
  final int? width;
  final int? height;

  const MetadataEntity(
      {required this.fileName,
      required this.details,
      required this.fileSize,
      required this.fileType,
      required this.width,
      required this.height});

  @override
  List<Object?> get props => [fileName, details, fileSize, width, height ,fileType];
}
