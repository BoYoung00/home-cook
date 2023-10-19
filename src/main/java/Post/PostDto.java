package Post;

public class PostDto {
    private int postId;
    private int postUserNumber;
    private String title;
    private String content;
    private String createdAt;

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
}
