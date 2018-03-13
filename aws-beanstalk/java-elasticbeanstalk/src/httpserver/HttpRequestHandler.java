package com.rookout.httpserver;

import java.io.IOException;
import java.io.OutputStream;
import java.net.URI;

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;

@SuppressWarnings("restriction")
public class HttpRequestHandler implements HttpHandler {

    private static final String F_NAME = "fname";
    private static final String L_NAME = "lname";

    private static final int PARAM_NAME_IDX = 0;
    private static final int PARAM_VALUE_IDX = 1;

    private static final int HTTP_OK_STATUS = 200;

    private static final String AND_DELIMITER = "&";
    private static final String EQUAL_DELIMITER = "=";

    public void handle(HttpExchange t) throws IOException {

        //Create a response form the request query parameters
        URI uri = t.getRequestURI();
        String response = createResponseFromQueryParams(uri);
        System.out.println("Response: " + response);
        //Set the response header status and length
        t.sendResponseHeaders(HTTP_OK_STATUS, response.getBytes().length);
        //Write the response string
        OutputStream os = t.getResponseBody();
        os.write(response.getBytes());
        os.close();
    }

    /**
     * Creates the response from query params.
     *
     * @param uri the uri
     * @return the string
     */
    private String createResponseFromQueryParams(URI uri) {

        String fName = "world";
        String lName = "!";
        //Get the request query
        String query = uri.getQuery();
        if (query != null) {
            System.out.println("Query: " + query);
            String[] queryParams = query.split(AND_DELIMITER);
            if (queryParams.length > 0) {
                for (String qParam : queryParams) {
                    String[] param = qParam.split(EQUAL_DELIMITER);
                    if (param.length > 0) {
                        for (int i = 0; i < param.length; i++) {
                            if (F_NAME.equalsIgnoreCase(param[PARAM_NAME_IDX])) {
                                fName = param[PARAM_VALUE_IDX];
                            }
                            if (L_NAME.equalsIgnoreCase(param[PARAM_NAME_IDX])) {
                                lName = param[PARAM_VALUE_IDX];
                            }
                        }
                    }
                }
            }
        }

        return "Hello, " + fName + " " + lName;
    }
}