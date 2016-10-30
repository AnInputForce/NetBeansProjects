package com.git.base.exceptions;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */

import java.io.PrintStream;
import java.io.PrintWriter;
public class AllAppException extends Exception {
//       /** A wrapped Throwable */
//       protected Throwable cause;
//       public AllAppException() {
//           super("Error occurred in application.");
//       }
//       public AllAppException(String message)  {
//           super(message);
//       }
//       public AllAppException(String message, Throwable cause)  {
//           super(message);
//           this.cause = cause;
//       }
//       // Created to match the JDK 1.4 Throwable method.
//       public Throwable initCause(Throwable cause)  {
//           this.cause = cause;
//           return cause;
//       }
//       public String getMessage() {
//           // Get this exception's message.
//           String msg = super.getMessage();
//           Throwable parent = this;
//           Throwable child;
//           // Look for nested exceptions.
//           while((child = getNestedException(parent)) != null) {
//               // Get the child's message.
//               String msg2 = child.getMessage();
//               // If we found a message for the child exception,
//               // we append it.
//               if (msg2 != null) {
//                   if (msg != null) {
//                       msg += ": " + msg2;
//                   } else {
//                       msg = msg2;
//                   }
//               }
//               // Any nested ApplicationException will append its own
//               // children, so we need to break out of here.
//               if (child instanceof ApplicationException) {
//                   break;
//               }
//               parent = child;
//           }
//           // Return the completed message.
//           return msg;
//       }
//       public void printStackTrace() {
//           // Print the stack trace for this exception.
//           super.printStackTrace();
//           Throwable parent = this;
//           Throwable child;
//           // Print the stack trace for each nested exception.
//           while((child = getNestedException(parent)) != null) {
//               if (child != null) {
//                   System.err.print("Caused by: ");
//                   child.printStackTrace();
//                   if (child instanceof ApplicationException) {
//                       break;
//                   }
//                   parent = child;
//               }
//           }
//       }
//       public void printStackTrace(PrintStream s) {
//           // Print the stack trace for this exception.
//           super.printStackTrace(s);
//           Throwable parent = this;
//           Throwable child;
//           // Print the stack trace for each nested exception.
//           while((child = getNestedException(parent)) != null) {
//               if (child != null) {
//                   s.print("Caused by: ");
//                   child.printStackTrace(s);
//                   if (child instanceof ApplicationException) {
//                       break;
//                   }
//                   parent = child;
//               }
//           }
//       }
//       public void printStackTrace(PrintWriter w) {
//           // Print the stack trace for this exception.
//           super.printStackTrace(w);
//           Throwable parent = this;
//           Throwable child;
//           // Print the stack trace for each nested exception.
//           while((child = getNestedException(parent)) != null) {
//               if (child != null) {
//                   w.print("Caused by: ");
//                   child.printStackTrace(w);
//                   if (child instanceof ApplicationException) {
//                       break;
//                   }
//                   parent = child;
//               }
//           }
//       }
//       public Throwable getCause()  {
//           return cause;
//       }
}
