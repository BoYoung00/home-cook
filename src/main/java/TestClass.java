import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TestClass {
    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        DTO dto = new UserDto("user7", "pw123", "kim", "qqq@asd");
        DAO dao = new UserDao();

//        dao.insert(dto);
//        dao.delete(2);
        List<DTO> list =  dao.selete("user7");
        if (list.isEmpty())
            System.out.println("없음");
        else {
            UserDto user = (UserDto) list.get(0);

            //System.out.println(user.getUserNumber());

            dao.delete(user.getUserNumber());

            for (DTO item : list) {
                //System.out.println(item.toString()); // 있으면 출력
            }
        } // else
    } // main
} // class
