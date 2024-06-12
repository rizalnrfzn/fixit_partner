// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatListModel _$ChatListModelFromJson(Map<String, dynamic> json) {
  return _ChatListModel.fromJson(json);
}

/// @nodoc
mixin _$ChatListModel {
  String? get id => throw _privateConstructorUsedError;
  String? get clientUid => throw _privateConstructorUsedError;
  int? get clientUnread => throw _privateConstructorUsedError;
  String? get technicianUid => throw _privateConstructorUsedError;
  int? get technicianUnread => throw _privateConstructorUsedError;
  String? get lastSender => throw _privateConstructorUsedError;
  String? get lastMessage => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get lastTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatListModelCopyWith<ChatListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatListModelCopyWith<$Res> {
  factory $ChatListModelCopyWith(
          ChatListModel value, $Res Function(ChatListModel) then) =
      _$ChatListModelCopyWithImpl<$Res, ChatListModel>;
  @useResult
  $Res call(
      {String? id,
      String? clientUid,
      int? clientUnread,
      String? technicianUid,
      int? technicianUnread,
      String? lastSender,
      String? lastMessage,
      @TimestampConverter() DateTime? lastTime});
}

/// @nodoc
class _$ChatListModelCopyWithImpl<$Res, $Val extends ChatListModel>
    implements $ChatListModelCopyWith<$Res> {
  _$ChatListModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? clientUid = freezed,
    Object? clientUnread = freezed,
    Object? technicianUid = freezed,
    Object? technicianUnread = freezed,
    Object? lastSender = freezed,
    Object? lastMessage = freezed,
    Object? lastTime = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      clientUid: freezed == clientUid
          ? _value.clientUid
          : clientUid // ignore: cast_nullable_to_non_nullable
              as String?,
      clientUnread: freezed == clientUnread
          ? _value.clientUnread
          : clientUnread // ignore: cast_nullable_to_non_nullable
              as int?,
      technicianUid: freezed == technicianUid
          ? _value.technicianUid
          : technicianUid // ignore: cast_nullable_to_non_nullable
              as String?,
      technicianUnread: freezed == technicianUnread
          ? _value.technicianUnread
          : technicianUnread // ignore: cast_nullable_to_non_nullable
              as int?,
      lastSender: freezed == lastSender
          ? _value.lastSender
          : lastSender // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastTime: freezed == lastTime
          ? _value.lastTime
          : lastTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatListModelImplCopyWith<$Res>
    implements $ChatListModelCopyWith<$Res> {
  factory _$$ChatListModelImplCopyWith(
          _$ChatListModelImpl value, $Res Function(_$ChatListModelImpl) then) =
      __$$ChatListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? clientUid,
      int? clientUnread,
      String? technicianUid,
      int? technicianUnread,
      String? lastSender,
      String? lastMessage,
      @TimestampConverter() DateTime? lastTime});
}

/// @nodoc
class __$$ChatListModelImplCopyWithImpl<$Res>
    extends _$ChatListModelCopyWithImpl<$Res, _$ChatListModelImpl>
    implements _$$ChatListModelImplCopyWith<$Res> {
  __$$ChatListModelImplCopyWithImpl(
      _$ChatListModelImpl _value, $Res Function(_$ChatListModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? clientUid = freezed,
    Object? clientUnread = freezed,
    Object? technicianUid = freezed,
    Object? technicianUnread = freezed,
    Object? lastSender = freezed,
    Object? lastMessage = freezed,
    Object? lastTime = freezed,
  }) {
    return _then(_$ChatListModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      clientUid: freezed == clientUid
          ? _value.clientUid
          : clientUid // ignore: cast_nullable_to_non_nullable
              as String?,
      clientUnread: freezed == clientUnread
          ? _value.clientUnread
          : clientUnread // ignore: cast_nullable_to_non_nullable
              as int?,
      technicianUid: freezed == technicianUid
          ? _value.technicianUid
          : technicianUid // ignore: cast_nullable_to_non_nullable
              as String?,
      technicianUnread: freezed == technicianUnread
          ? _value.technicianUnread
          : technicianUnread // ignore: cast_nullable_to_non_nullable
              as int?,
      lastSender: freezed == lastSender
          ? _value.lastSender
          : lastSender // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastTime: freezed == lastTime
          ? _value.lastTime
          : lastTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatListModelImpl extends _ChatListModel {
  _$ChatListModelImpl(
      {this.id,
      this.clientUid,
      this.clientUnread,
      this.technicianUid,
      this.technicianUnread,
      this.lastSender,
      this.lastMessage,
      @TimestampConverter() this.lastTime})
      : super._();

  factory _$ChatListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatListModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? clientUid;
  @override
  final int? clientUnread;
  @override
  final String? technicianUid;
  @override
  final int? technicianUnread;
  @override
  final String? lastSender;
  @override
  final String? lastMessage;
  @override
  @TimestampConverter()
  final DateTime? lastTime;

  @override
  String toString() {
    return 'ChatListModel(id: $id, clientUid: $clientUid, clientUnread: $clientUnread, technicianUid: $technicianUid, technicianUnread: $technicianUnread, lastSender: $lastSender, lastMessage: $lastMessage, lastTime: $lastTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatListModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clientUid, clientUid) ||
                other.clientUid == clientUid) &&
            (identical(other.clientUnread, clientUnread) ||
                other.clientUnread == clientUnread) &&
            (identical(other.technicianUid, technicianUid) ||
                other.technicianUid == technicianUid) &&
            (identical(other.technicianUnread, technicianUnread) ||
                other.technicianUnread == technicianUnread) &&
            (identical(other.lastSender, lastSender) ||
                other.lastSender == lastSender) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.lastTime, lastTime) ||
                other.lastTime == lastTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, clientUid, clientUnread,
      technicianUid, technicianUnread, lastSender, lastMessage, lastTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatListModelImplCopyWith<_$ChatListModelImpl> get copyWith =>
      __$$ChatListModelImplCopyWithImpl<_$ChatListModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatListModelImplToJson(
      this,
    );
  }
}

abstract class _ChatListModel extends ChatListModel {
  factory _ChatListModel(
      {final String? id,
      final String? clientUid,
      final int? clientUnread,
      final String? technicianUid,
      final int? technicianUnread,
      final String? lastSender,
      final String? lastMessage,
      @TimestampConverter() final DateTime? lastTime}) = _$ChatListModelImpl;
  _ChatListModel._() : super._();

  factory _ChatListModel.fromJson(Map<String, dynamic> json) =
      _$ChatListModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get clientUid;
  @override
  int? get clientUnread;
  @override
  String? get technicianUid;
  @override
  int? get technicianUnread;
  @override
  String? get lastSender;
  @override
  String? get lastMessage;
  @override
  @TimestampConverter()
  DateTime? get lastTime;
  @override
  @JsonKey(ignore: true)
  _$$ChatListModelImplCopyWith<_$ChatListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
