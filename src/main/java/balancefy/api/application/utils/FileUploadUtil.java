package balancefy.api.application.utils;

import balancefy.api.resources.configs.AwsCredentials;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicSessionCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.ObjectMetadata;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.MultipartFile;


import java.io.IOException;

@Configuration
public class FileUploadUtil {

    @Autowired
    private AwsCredentials awsCredentials;
    public void saveFile(String fileName, MultipartFile multipartFile) throws IOException {

        BasicSessionCredentials awsCreds = new
                BasicSessionCredentials(
                awsCredentials.getAccesskey(),
                awsCredentials.getSecretkey(),
                awsCredentials.getToken()
        );

        AmazonS3 s3Client = AmazonS3ClientBuilder.
                standard()
                .withCredentials(new AWSStaticCredentialsProvider(awsCreds))
                .withRegion(Regions.US_EAST_1)
                .enablePathStyleAccess()
                .build();

        ObjectMetadata data = new ObjectMetadata();
        data.setContentType(multipartFile.getContentType());
        data.setContentLength(multipartFile.getSize());

        s3Client.putObject("balancefy-d", fileName, multipartFile.getInputStream(), data);

    }
}
