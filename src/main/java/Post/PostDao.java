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
    public int write(String userId, String title, String content, String fileName, String category) throws SQLException, ClassNotFoundException {
        int count = 0;
        String sql = "INSERT INTO post (postUserNumber, title, content, fileName, category) VALUES (?, ?, ?, ?, ?)";
        UserDao userDao = new UserDao();

        try {
            int userNumber = userDao.selectUserNum(userId);
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userNumber);
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
    public List<PostDto> seleteAll() {
        List<PostDto> list = new ArrayList<>();

        String sql = "select * from post order by postId desc";

        try {
            pstmt = conn.prepareStatement(sql);

            rs = pstmt.executeQuery(sql);

            while (rs.next()) {
                int postID = rs.getInt(1);
                int postUserNumber = rs.getInt(2);
                String title = rs.getString(3);
                String content = rs.getString(4);
                String createdAt = rs.getString(5);
                String fileName = rs.getString(6);
                String category = rs.getString(7);

                PostDto postDto = new PostDto(postID, postUserNumber, title, content, createdAt, fileName, category);
                list.add(postDto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}


