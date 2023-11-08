package Post;

public class replyCommentDto {
    private int replyId;
    private int parentCommentId;
    private String userId;
    private String replyText;
    private String createdAt;

    public int getReplyId() {
        return replyId;
    }

    public void setReplyId(int replyId) {
        this.replyId = replyId;
    }

    public int getParentCommentId() {
        return parentCommentId;
    }

    public void setParentCommentId(int parentCommentId) {
        this.parentCommentId = parentCommentId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getReplyText() {
        return replyText;
    }

    public void setReplyText(String replyText) {
        this.replyText = replyText;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "replyCommentDto{" +
                "replyId=" + replyId +
                ", parentCommentId=" + parentCommentId +
                ", userId='" + userId + '\'' +
                ", replyText='" + replyText + '\'' +
                ", createdAt='" + createdAt + '\'' +
                '}';
    }
}
