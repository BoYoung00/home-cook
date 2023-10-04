class UserDto extends DTO {
    private int userNumber;
    private String userID;
    private String userPasswerd;
    private String userName;
    private String userMail;


    public UserDto(int userNumber, String userID, String userPasswerd, String userName, String userMail) {
        this.userNumber = userNumber;
        this.userID = userID;
        this.userPasswerd = userPasswerd;
        this.userName = userName;
        this.userMail = userMail;
    }

    public UserDto(String userID, String userPasswerd, String userName, String userMail) {
        this.userID = userID;
        this.userPasswerd = userPasswerd;
        this.userName = userName;
        this.userMail = userMail;
    }

    public int getUserNumber() {
        return userNumber;
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
                "userNumber=" + userNumber +
                ", userID='" + userID + '\'' +
                ", userPasswerd='" + userPasswerd + '\'' +
                ", userName='" + userName + '\'' +
                ", userMail='" + userMail + '\'' +
                '}';
    }
}
