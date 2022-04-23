import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:yuuna/media.dart';
import 'package:yuuna/utils.dart';
part 'creator_context.g.dart';

/// A bundle entity of items that can be used to start the card creator with
/// given parameters. This entity is serializable as these must be storable in
/// a peristent queue.
@JsonSerializable()
@Collection()
class CreatorContext {
  /// Initialise an immutable context context with the final parameters.
  CreatorContext({
    this.sentence,
    this.word,
    this.reading,
    this.meaning,
    this.extra,
    this.imageSeed,
    this.imageSearch,
    this.imageSuggestions,
    this.audioSeed,
    this.audioSearch,
    this.context,
    this.id,
  });

  /// Create an instance of this class from a serialized format.
  factory CreatorContext.fromJson(Map<String, dynamic> json) =>
      _$CreatorContextFromJson(json);

  /// Convert this into a serialized format.
  Map<String, dynamic> toJson() => _$CreatorContextToJson(this);

  /// Creates a deep copy of this context but with the given fields replaced
  /// with the new values.
  CreatorContext copyWith({
    String? sentence,
    String? word,
    String? reading,
    String? meaning,
    String? extra,
    MediaItem? imageSeed,
    String? imageSearch,
    List<MediaItem>? imageSuggestions,
    MediaItem? audioSeed,
    String? audioSearch,
    MediaItem? context,
  }) {
    return CreatorContext(
      sentence: sentence ?? this.sentence,
      word: word ?? this.word,
      reading: reading ?? this.reading,
      meaning: meaning ?? this.meaning,
      extra: extra ?? this.extra,
      imageSeed: imageSeed ?? this.imageSeed,
      imageSearch: imageSearch ?? this.imageSearch,
      imageSuggestions: imageSuggestions ?? this.imageSuggestions,
      audioSeed: audioSeed ?? this.audioSeed,
      audioSearch: audioSearch ?? this.audioSearch,
      context: context ?? this.context,
    );
  }

  /// The written context of the sourced word, i.e. an example sentence or
  /// scene dialogue.
  final String? sentence;

  /// The word pertaining to the reading and meaning, the word
  /// to be memorised from the card.
  final String? word;

  /// Pronunciation or reading. May be overriden with some characteristics such
  /// as pitch accent diagrams, by particular languages.
  final String? reading;

  /// Definition or meaning. May be overriden with some characteristics such
  /// as having meaning tags.
  final String? meaning;

  /// Extra parameters from which a custom user script can be written to parse
  /// from the Anki end. A JSON map serialised as a single String to be
  /// exported. Intended for future proofing and developer customisation.
  final String? extra;

  /// A media seed in terms of the creator context, is a media item which
  /// by way of a media type or an enhancement, can be used to generate an
  /// actual image or audio file that can be used in the card creator. The
  /// purpose of a media seed is to be able to confidently not only store
  /// card details, but also be able to re-generate the card's media from
  /// serialized data.

  /// A serialised [MediaItem] that can be used to generate an image file.
  @MediaItemConverter()
  final MediaItem? imageSeed;

  /// A list that may contain multiple serialised [MediaItem] that can be
  /// used to generate an image file. This can be used if there are multiple
  /// images in a context.
  @MediaItemConverter()
  final List<MediaItem>? imageSuggestions;

  /// A serialised [MediaItem] that can be used to generate an audio file.
  @MediaItemConverter()
  final MediaItem? audioSeed;

  /// The content of the image search controller for the Creator.
  final String? imageSearch;

  /// The content of the audio search controller for the Creator.
  final String? audioSearch;

  /// A serialised [MediaItem] to allow return to context.
  @MediaItemConverter()
  final MediaItem? context;

  /// A unique identifier for the purposes of database storage.
  @Id()
  int? id;
}
