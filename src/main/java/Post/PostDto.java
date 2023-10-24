package Post;

public class PostDto {
    private int postId;
    private int postUserNumber;
    private String title;
    private String content;
    private String createdAt;
    private String fileName;
    private String category;

    public PostDto(int postId, int postUserNumber, String title, String content, String createdAt, String fileName, String category) {
        this.postId = postId;
        this.postUserNumber = postUserNumber;
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

    public int getPostUserNumber() {
        return postUserNumber;
    }

    public void setPostUserNumber(int postUserNumber) {
        this.postUserNumber = postUserNumber;
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
                ", postUserNumber=" + postUserNumber +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", createdAt='" + createdAt + '\'' +
                ", fileName='" + fileName + '\'' +
                ", category='" + category + '\'' +
                '}';
    }
}
