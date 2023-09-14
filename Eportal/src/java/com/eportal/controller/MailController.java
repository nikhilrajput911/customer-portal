/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eportal.controller;

import JSON.JSONArray;
import JSON.JSONException;
import JSON.JSONObject;
import com.eportal.entities.CustomerMail;
import com.eportal.entities.CustomerSubUser;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URI;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

/**
 *
 * @author admin
 */
@Controller
public class MailController {

    @Value("${webservice.ip}")
    private String webservice_ip;

    @Autowired
    CustomerMail customerMail;

    @RequestMapping(value = "/mailCont", method = RequestMethod.POST)
    public void service(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        PrintWriter out = null;
        JSONArray jArra = new JSONArray();
        JSONObject jObj = new JSONObject();
        try {

            System.out.println("========Mail Controller==========");
            String reqFrom = request.getParameter("reqFrom");
            System.out.println("reqFrom: " + reqFrom);

            System.out.println("CustomerMail");

            Date today = new Date();
            out = response.getWriter();

            int userId = (int) session.getAttribute("userId");
            System.out.println("userId: " + userId);

            String MailTo = request.getParameter("MailTo");
            String MailCc = request.getParameter("MailCc");
            String MailSubject = request.getParameter("MailSubject");
            String MailBody = request.getParameter("MailBody");
            String DocIndexes = request.getParameter("DocIndexes");
            String DocName = request.getParameter("DocName");
            String CustomerName = request.getParameter("CustomerName");
            String ProjectName = request.getParameter("ProjectName");

            System.out.println("MailTo: " + MailTo);
            System.out.println("MailCc: " + MailCc);
            System.out.println("MailSubject: " + MailSubject);
            System.out.println("MailBody: " + MailBody);
            System.out.println("DocIndexes: " + DocIndexes);
            System.out.println("DocName: " + DocName);
            System.out.println("CustomerName: " + CustomerName);
            System.out.println("ProjectName: " + ProjectName);

            DocName = DocName.substring(0, DocName.length() - 1);
            DocIndexes = DocIndexes.replaceAll(",", ";");

            System.out.println("DocName Byte Length: " + DocName.getBytes().length);
            System.out.println("DocName Length: " + DocName.length());

            System.out.println("DocName: " + DocName);

            RestTemplate restTemplate = new RestTemplate();

            ResponseEntity<CustomerSubUser> restCustomerResponse = restTemplate.getForEntity(webservice_ip + "/EportalWebServices/customerbyid.do?userid=" + userId, CustomerSubUser.class);

            CustomerSubUser loggedInUser = restCustomerResponse.getBody();

            customerMail.setTOAddress(MailTo);
            customerMail.setCc(MailCc);
            customerMail.setSubject(MailSubject);
            customerMail.setMailBody(MailBody);
            customerMail.setDocumentIndex(DocIndexes + ";");
            customerMail.setDocumentName(DocName + ";");
            customerMail.setMailComposedOn(today);
            customerMail.setMailSentFlag("N");
            customerMail.setCustomerName(CustomerName);
            customerMail.setProjectName(ProjectName);
//                customerMail.setMailType("Manual");

            if (loggedInUser.getPersonalfirstname() == null && loggedInUser.getPersonallastname() == null) {
                customerMail.setMailSentBy("");
            } else if (loggedInUser.getPersonallastname() == null) {
                customerMail.setMailSentBy(loggedInUser.getPersonalfirstname());
            } else {
                customerMail.setMailSentBy(loggedInUser.getPersonalfirstname() + " " + loggedInUser.getPersonallastname());
            }

            String mailId = restTemplate.postForObject(URI.create(webservice_ip + "/EportalWebServices/savecustomermail.do"),
                    customerMail, String.class);
            System.out.println("mailId: " + mailId);
            jObj.put("MailId", mailId);
//
            out.println(jObj);

        } catch (IOException | RestClientException | JSONException ex) {
            Logger.getLogger(RfeController.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (out != null) {
                out.close();
            }
        }
    }

    @RequestMapping(value = "/logoutCustomer", method = RequestMethod.GET)
    public void logoutCustomer(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        PrintWriter out = null;
        JSONArray jArra = new JSONArray();
        JSONObject jObj = new JSONObject();
        try {

            System.out.println("========Mail Controller==========");
            System.out.println("========Logout Customer==========");

            String reqFrom = request.getParameter("reqFrom");
            System.out.println("reqFrom: " + reqFrom);

            System.out.println("CustomerMail");

            Date today = new Date();
            out = response.getWriter();

            int userId = (int) session.getAttribute("userId");
            System.out.println("before session clear userId: " + userId);

            session.removeAttribute("username");
            session.removeAttribute("userId");
            session.removeAttribute("userRole");
            session.removeAttribute("groupIds");
            session.removeAttribute("customerid");
            session.removeAttribute("ispassupdated");
            session.removeAttribute("fullname");
            session.removeAttribute("dmsip");
            session.removeAttribute("profilePic");
            session.removeAttribute("docindex");
            session.removeAttribute("passconfig");
            session.removeAttribute("NotificationList");
            session.removeAttribute("isPersonalInfoUpdated");
            session.removeAttribute("UserGroupSSO");

            System.out.println("after session clear userId: " + session.getAttribute("userId"));
            
            for (Cookie ck : request.getCookies()) {
                if (ck.getName().equalsIgnoreCase("username")) {
                    ck.setMaxAge(0);
                    response.addCookie(ck);
                }
                if (ck.getName().equalsIgnoreCase("password")) {
                    ck.setMaxAge(0);
                    response.addCookie(ck);
                }
            }

            jObj.put("Status", "Success");
            out.println(jObj);

        } catch (IOException | RestClientException | JSONException ex) {
            Logger.getLogger(RfeController.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (out != null) {
                out.close();
            }
        }
    }
}
