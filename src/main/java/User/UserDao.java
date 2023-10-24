//최초 작성자 : 김보영
//최초 작성일 : 2023.10.03.
//최초 변경일 : 2023.10.05.
//목적 : 사용자 정보 DAO
//개정 이력 : 김보영, 2023.10.05.(var. 01)
//저작권 : 없음

package User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDao {
    Connection conn = null; // DB 연결용
    Statement stmt = null; // SQL 구문을 실행하는 역할
    ResultSet rs = null; // 값 넣는 곳
    PreparedStatement pstmt = null; // Statement 기능 향상 (? 쓸 수 있게 해줌)

    public UserDao() throws ClassNotFoundException, SQLException { // 드라이버 로드
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/home_cook_db"
                + "?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false", "root", "rlaqhdud2@");
        stmt = conn.createStatement();
    }

    public int insert(UserDto userDto) {
        int count = 0;
        String sql = "INSERT INTO user (userId, userPassword, userName, userEmail) VALUES (?, ?, ?, ?)";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userDto.getUserID());
            pstmt.setString(2, userDto.getUserPasswerd());
            pstmt.setString(3, userDto.getUserName());
            pstmt.setString(4, userDto.getUserMail());

            count = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public int delete(int number) {
        String sql = "delete from user where userNumber=?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, number);

            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;
    }

    public List<UserDto> selete(String userId) {
        List<UserDto> list = new ArrayList<>();

        String sql = "select * from user where userId=?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                String id = rs.getString(1);
                String password = rs.getString(2);
                String name = rs.getString(3);
                String email = rs.getString(4);

                UserDto userDto = new UserDto(id, password, name, email);
                list.add(userDto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int login(String id, String pw) {
        String sql = "SELECT userPassword FROM user WHERE userId=?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);

            rs = pstmt.executeQuery();
            if (rs.next()) {
                if (rs.getString("userPassword").equals(pw))
                    return 1; // 로그인 성공
                else
                    return 0; // 비밀번호 불일치
            }
            return -1; // 아이디 없음
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2; // DB 오류
    }

    // 회원 번호 찾기
    public int selectUserNum(String id) {
        String sql = "SELECT userNumber FROM user WHERE userId=?";
        int userNumber;

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);

            rs = pstmt.executeQuery();
            if (rs.next()) {
                userNumber = rs.getInt("userNumber");
                return userNumber;
            }
            return -1; // 아이디 없음
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2; // DB 오류
    }

    // 회원 이름 찾기
    public String selectUserName(String id) {
        String sql = "SELECT userName FROM user WHERE userId=?";
        String userName;

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);

            rs = pstmt.executeQuery();
            if (rs.next()) {
                userName = rs.getString("userName");
                return userName;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
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

