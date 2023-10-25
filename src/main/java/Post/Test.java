package Post;

import java.sql.SQLException;
import java.util.List;

public class Test {
    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        PostDao dao = new PostDao();
        List<PostDto> posts = dao.selectCategory("food");
        System.out.println(posts.get(0).getTitle());

        for(PostDto post : posts) {
            System.out.println(post.getTitle());
        }
    }
}
