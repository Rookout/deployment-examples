package org.example;

import com.amazonaws.xray.AWSXRay;
import com.amazonaws.xray.AWSXRayRecorderBuilder;
import com.amazonaws.xray.plugins.ElasticBeanstalkPlugin;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class AWSXRayServletContext implements ServletContextListener {

    public void contextInitialized(ServletContextEvent servletContextEvent) {
        // Initialize AWS XRay Recorder before any filters or servlets are created
        AWSXRayRecorderBuilder builder = AWSXRayRecorderBuilder.standard().withPlugin(new ElasticBeanstalkPlugin());
        AWSXRay.setGlobalRecorder(builder.build());
    }

    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }
}
