class FeedbackBody {
  int? aiChatbotId;
  String? type;

  FeedbackBody({this.aiChatbotId, this.type});

  FeedbackBody.fromJson(Map<String, dynamic> json) {
    aiChatbotId = json['ai_chatbot_id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ai_chatbot_id'] = this.aiChatbotId;
    data['type'] = this.type;
    return data;
  }
}
