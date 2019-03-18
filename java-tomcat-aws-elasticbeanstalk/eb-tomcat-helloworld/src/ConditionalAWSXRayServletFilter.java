package org.example;

import com.amazonaws.xray.javax.servlet.AWSXRayServletFilter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import java.io.IOException;

public class ConditionalAWSXRayServletFilter implements Filter{

    private AWSXRayServletFilter xrayFilter;

    public ConditionalAWSXRayServletFilter() {
        xrayFilter = new AWSXRayServletFilter();
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        xrayFilter.init(filterConfig);
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        final boolean xrayEnabled = Boolean.valueOf(System.getProperty("XRAY_ENABLED"));

        if (xrayEnabled) {
            xrayFilter.doFilter(servletRequest, servletResponse, filterChain);
        } else {
            filterChain.doFilter(servletRequest, servletResponse);
        }
    }

    @Override
    public void destroy() {
        xrayFilter.destroy();
    }
}
