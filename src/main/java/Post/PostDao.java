//최초 작성자 : 김보영
//최초 작성일 : 2023.10.18.
//최초 변경일 : 2023.10.18.
//목적 : 게시글 정보 DAO
//개정 이력 : 김보영, 2023.10.18.(var. 01)
//저작권 : 없음

package Post;

import User.UserDao;
import User.UserDto;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDao {
    Connection conn = null; // DB 연결용
    Statement stmt = null; // SQL 구문을 실행하는 역할
    ResultSet rs = null; // 값 넣는 곳
    PreparedStatement pstmt = null; // Statement 기능 향상 (? 쓸 수 있게 해줌)

    public PostDao() throws ClassNotFoundException, SQLException { // 드라이버 로드
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/home_cook_db"
                + "?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false", "root", "rlaqhdud2@");
        stmt = conn.createStatement();
    }

    // 글쓰기
    public int write(String userId, String title, String content, String fileName, String category) {
        int count = 0;
        String sql = "INSERT INTO post (postUserId, title, content, fileName, category) VALUES (?, ?, ?, ?, ?)";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            pstmt.setString(2, title);
            pstmt.setString(3, content);
            pstmt.setString(4, fileName);
            pstmt.setString(5, category);

            count = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    // 모든 글 목록 가져오기
    public List<PostDto> selectAll() {
        List<PostDto> list = new ArrayList<>();

        String sql = "select * from post order by postId desc";

        try {
            pstmt = conn.prepareStatement(sql);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                int postId = rs.getInt(1);
                String postUserId = rs.getString(2);
                String title = rs.getString(3);
                String content = rs.getString(4);
                String createdAt = rs.getString(5);
                String fileName = rs.getString(6);
                String category = rs.getString(7);

                PostDto postDto = new PostDto(postId, postUserId, title, content, createdAt, fileName, category);
                list.add(postDto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 해당 카테고리 게시글 가져오기
    public List<PostDto> selectCategory(String inputCategory) {
        List<PostDto> list = new ArrayList<>();

        String sql = "select * from post where category=? order by postId desc";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, inputCategory);

            rs = pstmt.executeQuery();
            while (rs.next()) {
                int postId = rs.getInt(1);
                String postUserId = rs.getString(2);
                String title = rs.getString(3);
                String content = rs.getString(4);
                String createdAt = rs.getString(5);
                String fileName = rs.getString(6);
                String category = rs.getString(7);

                PostDto postDto = new PostDto(postId, postUserId, title, content, createdAt, fileName, category);
                list.add(postDto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 해당 게시글 조회
    public PostDto selectView(int postId) throws SQLException, ClassNotFoundException {
        String sql = "SELECT p.postID, p.postUserId, p.title, p.content, p.createdAt, p.fileName, p.category"
                    + " FROM post p, user u WHERE (postId=?) and (p.postUserId = u.userId)";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, postId);

            rs = pstmt.executeQuery();
            if (rs.next()) {
                int postID = rs.getInt(1);
                String postUserId = rs.getString(2);
                String title = rs.getString(3);
                String content = rs.getString(4);
                String createdAt = rs.getString(5);
                String fileName = rs.getString(6);
                String category = rs.getString(7);

                PostDto postDto = new PostDto(postID, postUserId, title, content, createdAt, fileName, category);

                return postDto;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 게시글 삭제
    public int postDelete(int postId) {
        String sql = "delete from post where postId=?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, postId);

            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;
    }

    // 게시글 수정
    public int postUpdate(int postId, String title, String content, String fileName, String category) {
        int count = 0;
        String sql = "UPDATE post SET title=?, content=?, fileName=?, category=? WHERE postId=?;";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, title);
            pstmt.setString(2, content);
            pstmt.setString(3, fileName);
            pstmt.setString(4, category);
            pstmt.setInt(5, postId);

            count = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
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


