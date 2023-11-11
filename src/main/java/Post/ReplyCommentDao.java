package Post;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReplyCommentDao {
    Connection conn = null; // DB 연결용
    Statement stmt = null; // SQL 구문을 실행하는 역할
    ResultSet rs = null; // 값 넣는 곳
    PreparedStatement pstmt = null; // Statement 기능 향상 (? 쓸 수 있게 해줌)

    public ReplyCommentDao() throws ClassNotFoundException, SQLException { // 드라이버 로드
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/home_cook_db"
                + "?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false", "root", "rlaqhdud2@");
        stmt = conn.createStatement();
    }

    // 대댓글 추가하기
    public int insertReply(int commentId, String userId, String commentText) {
        String sql = "INSERT INTO replyComment (postId, userId, replyText) VALUES (?, ?, ?)";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, commentId);
            pstmt.setString(2, userId);
            pstmt.setString(3, commentText);

            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;
    }

    // 해당 댓글의 대댓글 목록 가져오기
    public List<ReplyCommentDto> selectReplyAll(int commentId) {
        List<ReplyCommentDto> list = new ArrayList<>();

        String sql = "SELECT * FROM replyComment WHERE parentCommentId = ? ORDER BY replyId ASC";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, commentId);

            rs = pstmt.executeQuery();
            while (rs.next()) {
                int replyId = rs.getInt(1);
                int parentCommentId = commentId;
                String userId = rs.getString(3);
                String replyText = rs.getString(4);
                String createdAt = rs.getString(5);

                ReplyCommentDto reply = new ReplyCommentDto(replyId, parentCommentId, userId, replyText, createdAt);
                list.add(reply);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
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
