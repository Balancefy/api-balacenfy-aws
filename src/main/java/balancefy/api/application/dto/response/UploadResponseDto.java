package balancefy.api.application.dto.response;

import balancefy.api.resources.entities.Comentario;

import java.time.LocalDateTime;
import java.util.List;


public class UploadResponseDto {
    private String url;

    public UploadResponseDto(String url) {
        this.url = url;
    }

    public String getUrl() {
        return this.url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}