package Post;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookmarkDao {
    Connection conn = null; // DB 연결용
    Statement stmt = null; // SQL 구문을 실행하는 역할
    ResultSet rs = null; // 값 넣는 곳
    PreparedStatement pstmt = null; // Statement 기능 향상 (? 쓸 수 있게 해줌)

    public BookmarkDao() throws ClassNotFoundException, SQLException { // 드라이버 로드
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/home_cook_db"
                + "?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false", "root", "rlaqhdud2@");
        stmt = conn.createStatement();
    }

    // 북마크 추가하기
    public int addBookmark(int postId, String userId) {
        String sql = "INSERT INTO bookmark (bookmark_post_id, bookmark_user_id) VALUES (?, ?)";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, postId);
            pstmt.setString(2, userId);

            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;
    }

    // 북마크 삭제하기
    public int removeBookmark(int postId, String userId) {
        String sql = "DELETE FROM bookmark WHERE bookmark_post_id = ? AND bookmark_user_id = ?";

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, postId);
            pstmt.setString(2, userId);

            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return -1;
    }


    // 로그인 되어있는 유저 북마크 가져오기
    public List<BookmarkDto> selectBookmarkAll(String userId) {
        List<BookmarkDto> list = new ArrayList<>();

        String sql = "SELECT * FROM bookmark WHERE bookmark_user_id = ? ORDER BY bookmark_id ASC";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);

            rs = pstmt.executeQuery();
            while (rs.next()) {
                int bookmarkId = rs.getInt(1);
                int bookmarkPostId = rs.getInt(2);
                String bookmarkUserId = rs.getString(3);

                BookmarkDto bookmarkDto = new BookmarkDto(bookmarkId, bookmarkPostId, bookmarkUserId);
                list.add(bookmarkDto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 이미 북마크가 되어 있는지 유무
    public boolean isPostBookmarked(int postId, String userId) {
        String sql = "SELECT COUNT(*) AS count FROM bookmark WHERE bookmark_post_id = ? AND bookmark_user_id = ?";

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, postId);
            pstmt.setString(2, userId);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt("count");
                return count > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return false;
    }

    public void dbClose() throws SQLException {
        if (conn != null)
            conn.close();

        if (stmt != null)
            stmt.close();

        if (rs != null)
            rs.close();
    }
}
