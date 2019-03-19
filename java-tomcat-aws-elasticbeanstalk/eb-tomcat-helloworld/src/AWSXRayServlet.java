package org.example;

import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.xray.AWSXRay;
import com.amazonaws.xray.entities.Subsegment;
import com.amazonaws.xray.handlers.TracingHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/trace")
public class AWSXRayServlet extends HttpServlet {

    private static final String BUCKET_NAME = String.format("elasticbeanstalk-samples-%s", Regions.getCurrentRegion().getName());
    private static final String OBJECT_KEY = "elasticbeanstalk-sampleapp-v2.war";

    // Create AWS clients instrumented with AWS XRay tracing handler

    private static final AmazonS3 s3Client = AmazonS3ClientBuilder.standard()
            .withRegion(Regions.getCurrentRegion().getName())
            .withRequestHandlers(new TracingHandler())
            .build();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        final boolean xrayEnabled = Boolean.valueOf(System.getProperty("XRAY_ENABLED"));

        if (xrayEnabled) {
            traceS3();
        }
    }

    private void traceS3() {
        // Add subsegment to current request to track call to S3
        Subsegment subsegment = AWSXRay.beginSubsegment("## Getting object metadata");
        try {
            // Gets metadata about this sample app object in S3
            s3Client.getObjectMetadata(BUCKET_NAME, OBJECT_KEY);
        } catch (Exception ex) {
            subsegment.addException(ex);
        } finally {
            AWSXRay.endSubsegment();
        }
    }
}