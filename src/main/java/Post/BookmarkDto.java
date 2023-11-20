package Post;

public class BookmarkDto {
    private int bookmarkId;
    private int bookmarkPostId;
    private String bookmarkUserId;

    public BookmarkDto(int bookmarkId, int bookmarkPostId, String bookmarkUserId) {
        this.bookmarkId = bookmarkId;
        this.bookmarkPostId = bookmarkPostId;
        this.bookmarkUserId = bookmarkUserId;
    }

    public int getBookmarkId() {
        return bookmarkId;
    }

    public void setBookmarkId(int bookmarkId) {
        this.bookmarkId = bookmarkId;
    }

    public int getBookmarkPostId() {
        return bookmarkPostId;
    }

    public void setBookmarkPostId(int bookmarkPostId) {
        this.bookmarkPostId = bookmarkPostId;
    }

    public String getBookmarkUserId() {
        return bookmarkUserId;
    }

    public void setBookmarkUserId(String bookmarkUserId) {
        this.bookmarkUserId = bookmarkUserId;
    }

    @Override
    public String toString() {
        return "BookmarkDto{" +
                "bookmarkId=" + bookmarkId +
                ", bookmarkPostId=" + bookmarkPostId +
                ", bookmarkUserId='" + bookmarkUserId + '\'' +
                '}';
    }
}
