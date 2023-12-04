package Post;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CommentDao {
    Connection conn = null; // DB 연결용
    Statement stmt = null; // SQL 구문을 실행하는 역할
    ResultSet rs = null; // 값 넣는 곳
    PreparedStatement pstmt = null; // Statement 기능 향상 (? 쓸 수 있게 해줌)

    public CommentDao() throws ClassNotFoundException, SQLException { // 드라이버 로드
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/home_cook_db"
                + "?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false", "root", "rlaqhdud2@");
        stmt = conn.createStatement();
    }

    // 댓글 추가하기
    public int insertComment(int postId, String userId, String commentText) {
        String sql = "INSERT INTO comment (postId, userId, commentText) VALUES (?, ?, ?)";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, postId);
            pstmt.setString(2, userId);
            pstmt.setString(3, commentText);

            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    // 해당 게시글 댓글 목록 가져오기
    public List<CommentDto> selectCommentAll(int postId) {
        List<CommentDto> list = new ArrayList<>();

        String sql = "SELECT * FROM comment WHERE postId = ? ORDER BY commentId ASC";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, postId);

            rs = pstmt.executeQuery();
            while (rs.next()) {
                int commentId = rs.getInt(1);
                int CommentPostId = postId;
                String userId = rs.getString(3);
                String commentText = rs.getString(4);
                String createdAt = rs.getString(5);

                CommentDto commentDto = new CommentDto(commentId, CommentPostId, userId, commentText, createdAt);
                list.add(commentDto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 해당 댓글 정보 가져오기
    public CommentDto selectComment(int CommentId) {
        CommentDto commentDto = null;

        String sql = "SELECT commentId, postId, userId, commentText, createdAt FROM comment WHERE commentId = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, CommentId);

            rs = pstmt.executeQuery();
            while (rs.next()) {
                int commentId = CommentId;
                int CommentPostId = rs.getInt(2);
                String userId = rs.getString(3);
                String commentText = rs.getString(4);
                String createdAt = rs.getString(5);

                commentDto = new CommentDto(commentId, CommentPostId, userId, commentText, createdAt);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return commentDto;
    }

    // 해당 댓글 번호로 댓글 삭제
    public int deleteCommentId(int commentId) {
        String sql = "delete from comment where commentId=?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, commentId);

            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    // 해당 게시글 번호 댓글 모두 삭제
    public int commentDelete(int postId) {
        String sql = "delete from comment where postId=?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, postId);

            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
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
