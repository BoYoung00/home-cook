//최초 작성자 : 김보영
//최초 작성일 : 2023.10.03.
//최초 변경일 : 2023.10.05.
//목적 : 사용자 정보 DTO
//개정 이력 : 김보영, 2023.10.05.(var. 01)
//저작권 : 없음

package User;

public class UserDto {
    private String userID;
    private String userPasswerd;
    private String userName;
    private String userMail;

    public UserDto(String userID, String userPasswerd, String userName, String userMail) {
        this.userID = userID;
        this.userPasswerd = userPasswerd;
        this.userName = userName;
        this.userMail = userMail;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getUserPasswerd() {
        return userPasswerd;
    }

    public void setUserPasswerd(String userPasswerd) {
        this.userPasswerd = userPasswerd;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserMail() {
        return userMail;
    }

    public void setUserMail(String userMail) {
        this.userMail = userMail;
    }

    @Override
    public String toString() {
        return "UserDto{" +
                "userID='" + userID + '\'' +
                ", userPasswerd='" + userPasswerd + '\'' +
                ", userName='" + userName + '\'' +
                ", userMail='" + userMail + '\'' +
                '}';
    }
}
