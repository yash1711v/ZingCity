import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../logic/cubit/support/support_cubit.dart';

class TicketModel extends Equatable {
  final int id;
  final int userId;
  final String subject;
  final String ticketId;
  final String priority;
  final String message;
  final String status;
  final String createdAt;
  final String updatedAt;
  final int unseenMessage;
  final int supportTicketId;
  final int adminId;
  final String seenByAdmin;
  final String seenByUser;
  final String messageFrom;
  final String token;
  final SupportState supState;
  bool isOpenSupport;

   TicketModel({
    required this.id,
    required this.userId,
    required this.subject,
    required this.ticketId,
    required this.priority,
    required this.message,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.unseenMessage,
    required this.supportTicketId,
    required this.adminId,
    required this.seenByAdmin,
    required this.seenByUser,
    required this.messageFrom,
    required this.token,
     this.isOpenSupport = false,
    this.supState = const SupportInitial(),
  });

  TicketModel copyWith({
    int? id,
    int? userId,
    String? subject,
    String? ticketId,
    String? priority,
    String? message,
    String? status,
    String? createdAt,
    String? updatedAt,
    int? unseenMessage,
    int? supportTicketId,
    int? adminId,
    String? seenByAdmin,
    String? seenByUser,
    String? messageFrom,
    String? token,
    bool? isOpenSupport,
    SupportState? supState,
  }) {
    return TicketModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      subject: subject ?? this.subject,
      ticketId: ticketId ?? this.ticketId,
      priority: priority ?? this.priority,
      message: message ?? this.message,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      unseenMessage: unseenMessage ?? this.unseenMessage,
      supportTicketId: supportTicketId ?? this.supportTicketId,
      adminId: adminId ?? this.adminId,
      seenByAdmin: seenByAdmin ?? this.seenByAdmin,
      seenByUser: seenByUser ?? this.seenByUser,
      messageFrom: messageFrom ?? this.messageFrom,
      token: token ?? this.token,
      isOpenSupport: isOpenSupport ?? this.isOpenSupport,
      supState: supState ?? this.supState,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subject': subject,
      'priority': priority,
      'message': message,
    };
  }

  factory TicketModel.fromMap(Map<String, dynamic> map) {
    return TicketModel(
      id: map['id'] ?? 0,
      userId: map['user_id'] != null ? int.parse(map['user_id'].toString()) : 0,
      subject: map['subject'] ?? '',
      ticketId: map['ticket_id'] ?? '',
      priority: map['priority'] ?? '',
      message: map['message'] ?? '',
      status: map['status'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      seenByAdmin: map['seen_by_admin'] ?? '',
      seenByUser: map['seen_by_user'] ?? '',
      messageFrom: map['message_from'] ?? '',
      token: map['token'] ?? '',
      supportTicketId: map['support_ticket_id'] != null
          ? int.parse(map['support_ticket_id'].toString())
          : 0,
      adminId:
          map['admin_id'] != null ? int.parse(map['admin_id'].toString()) : 0,
      unseenMessage: map['unseen_message'] != null
          ? int.parse(map['unseen_message'].toString())
          : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TicketModel.fromJson(String source) =>
      TicketModel.fromMap(json.decode(source) as Map<String, dynamic>);

  static TicketModel init() {
    return  TicketModel(
      id: 0,
      userId: 0,
      subject: '',
      ticketId: '',
      priority: '',
      message: '',
      status: '',
      createdAt: '',
      updatedAt: '',
      unseenMessage: 0,
      supportTicketId: 0,
      adminId: 0,
      seenByAdmin: '',
      seenByUser: '',
      messageFrom: '',
      token: '',
      isOpenSupport: false,
      supState: SupportInitial(),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      userId,
      subject,
      ticketId,
      priority,
      message,
      status,
      createdAt,
      updatedAt,
      unseenMessage,
      supportTicketId,
      adminId,
      seenByAdmin,
      seenByUser,
      messageFrom,
      token,
      isOpenSupport,
      supState,
    ];
  }
}
