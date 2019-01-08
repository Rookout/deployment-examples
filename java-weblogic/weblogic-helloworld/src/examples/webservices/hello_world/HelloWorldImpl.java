package example.webservices.hello_world;
// Import the @WebService annotation
import javax.jws.WebService;
@WebService(name="HelloWorldPortType", serviceName="HelloWorldService")
/**
 * This JWS file forms the basis of simple Java-class implemented WebLogic
 * Web Service with a single operation: sayHelloWorld
 */
public class HelloWorldImpl {
  // By default, all public methods are exposed as Web Services operation
  public String sayHelloWorld(String message) {
    try {
      System.out.println("sayHelloWorld:" + message);
    } catch (Exception ex) { ex.printStackTrace(); }

    return "Here is the message: '" + message + "'";
  }
}