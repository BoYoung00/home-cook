package Post;

public class CommentDto {
    private int commentId;
    private int postId;
    private String userId;
    private String commentText;
    private String createdAt;

    public CommentDto(int commentId, int postId, String userId, String commentText, String createdAt) {
        this.commentId = commentId;
        this.postId = postId;
        this.userId = userId;
        this.commentText = commentText;
        this.createdAt = createdAt;
    }

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getCommentText() {
        return commentText;
    }

    public void setCommentText(String commentText) {
        this.commentText = commentText;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "CommentDto{" +
                "commentId=" + commentId +
                ", postId=" + postId +
                ", userId='" + userId + '\'' +
                ", commentText='" + commentText + '\'' +
                ", createdAt='" + createdAt + '\'' +
                '}';
    }
}
