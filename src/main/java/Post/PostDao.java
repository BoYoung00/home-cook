//최초 작성자 : 김보영
//최초 작성일 : 2023.10.18.
//최초 변경일 : 2023.10.18.
//목적 : 게시글 정보 DAO
//개정 이력 : 김보영, 2023.10.18.(var. 01)
//저작권 : 없음

package Post;

import User.UserDao;

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
    public int write(String userId, String title, String content) throws SQLException, ClassNotFoundException {
        int count = 0;
        String sql = "INSERT INTO post (postUserNumber, title, content) VALUES (?, ?, ?)";
        UserDao userDao = new UserDao();

        try {
            int userNumber = userDao.selectUserNum(userId);
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userNumber);
            pstmt.setString(2, title);
            pstmt.setString(3, content);

            count = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

}


