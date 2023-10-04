import java.sql.*;
import java.util.ArrayList;
import java.util.List;

class UserDao extends DAO {

    public UserDao() throws ClassNotFoundException, SQLException {
        super();
    }

    @Override
    int insert(DTO dto) {
        if (dto instanceof UserDto) {
            String sql = "INSERT INTO user (userId, userPassword, userName, userEmail) VALUES (?, ?, ?, ?)";

            try {
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, ((UserDto) dto).getUserID());
                pstmt.setString(2, ((UserDto) dto).getUserPasswerd());
                pstmt.setString(3, ((UserDto) dto).getUserName());
                pstmt.setString(4, ((UserDto) dto).getUserMail());

                return pstmt.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return -1; // DB 오류
    }

    @Override
    int delete(int number) {
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

    @Override
    List<DTO> selete(String userId) {
        List<DTO> list = new ArrayList<>();

        String sql = "select * from user where userId=?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                int number = rs.getInt(1);
                String id = rs.getString(2);
                String password = rs.getString(3);
                String name = rs.getString(4);
                String email = rs.getString(5);

                UserDto userdto = new UserDto(number, id, password, name, email);
                list.add(userdto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

}

