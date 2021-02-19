package com.token;


import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.digest.HmacUtils;


public class GenerateToken {

    public static final String PROVISION_TOKEN = "provision";
    private static final long EPOCH_SECONDS = 62167219200l;
    private static final String DELIM = "\0";


    public static String generateProvisionToken(String key, String jid, String expires, String vcard) throws NumberFormatException {
        String payload = String.join(DELIM, PROVISION_TOKEN, jid, calculateExpiry(expires), vcard);
        return new String(Base64.encodeBase64(
                (String.join(DELIM, payload, HmacUtils.hmacSha384Hex(key, payload))).getBytes()
        ));
    }

    public static String calculateExpiry(String expires) throws NumberFormatException {
        long expiresLong = 0l;
        long currentUnixTimestamp = System.currentTimeMillis() / 1000;
        expiresLong = Long.parseLong(expires);
        return ""+(EPOCH_SECONDS + currentUnixTimestamp + expiresLong);
    }

 

    public static String getToken(String key,String appID,String userName,String vCardFilePath,String expiresInSeconds) {
      
        
        String vCard = "";
        if (vCardFilePath != null) {
            File vCardFile = new File(vCardFilePath);
            if (!vCardFile.exists()) {
                System.out.println("File not found: " + vCardFilePath);
                return "";
            }
            try {
                vCard = new String(Files.readAllBytes(vCardFile.toPath()));
            } catch (IOException ioe) {
                System.out.println("Failed to read file: " + vCardFilePath);
                return "";
            }
        }

        try {
            
            System.out.println("Generating Token...");
            return generateProvisionToken(key, userName + "@" + appID, expiresInSeconds, vCard);
        } catch (NumberFormatException nfe) {
            System.out.println("Failed to parse expiresInSeconds: " + expiresInSeconds);
            return "";
        }
        

    }
}
