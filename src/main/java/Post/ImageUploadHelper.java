package Post;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;

import java.io.File;
import java.util.*;

public class ImageUploadHelper {
    private HttpServletRequest request;

    // 생성자: HttpServletRequest 객체를 인수로 받음
    public ImageUploadHelper(HttpServletRequest request) {
        this.request = request;
    }

    // 이미지 업로드를 처리하는 메서드
    public List<String> uploadImages() {
        List<String> imagePaths = new ArrayList<>(); // 이미지 파일 경로를 저장할 리스트

        try {
            Collection<Part> parts = request.getParts(); // HTTP 요청으로부터 모든 "Part"를 가져옴

            // 모든 "Part"를 반복하여 이미지 파일만 처리
            for (Part part : parts) {
                if (part.getContentType() != null && part.getContentType().startsWith("image")) {
                    String fileName = getFileName(part); // 파일 이름 추출
                    String imagePath = request.getServletContext().getRealPath("/uploads") + File.separator + fileName; // 서버에 저장할 이미지 파일의 경로
                    part.write(imagePath); // 이미지 파일을 서버에 저장
                    imagePaths.add(imagePath); // 이미지 파일의 경로를 리스트에 추가
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return imagePaths; // 이미지 파일 경로의 리스트 반환
    }

    // "Part" 객체에서 파일 이름을 추출하는 메서드
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] tokens = contentDisposition.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 2, token.length() - 1);
            }
        }
        return "";
    }
}
