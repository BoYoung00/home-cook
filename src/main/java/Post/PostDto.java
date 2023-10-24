package Post;

public class PostDto {
    private int postId;
    private String postUserId;
    private String title;
    private String content;
    private String createdAt;
    private String fileName;
    private String category;

    public PostDto(int postId, String postUserId, String title, String content, String createdAt, String fileName, String category) {
        this.postId = postId;
        this.postUserId = postUserId;
        this.title = title;
        this.content = content;
        this.createdAt = createdAt;
        this.fileName = fileName;
        this.category = category;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getPostUserId() {
        return postUserId;
    }

    public void setPostUserId(String postUserId) {
        this.postUserId = postUserId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    @Override
    public String toString() {
        return "PostDto{" +
                "postId=" + postId +
                ", postUserId='" + postUserId + '\'' +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", createdAt='" + createdAt + '\'' +
                ", fileName='" + fileName + '\'' +
                ", category='" + category + '\'' +
                '}';
    }
}
