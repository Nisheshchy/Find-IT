/**
 * PasswordUtil.java
 * Purpose: Utility class for SHA-256 password hashing and verification.
 * Author: Find It Team
 * Module: CS5054NT Advanced Programming
 */
package com.findit.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordUtil {

    /** Encrypt a plaintext password using SHA-256 and return hex string */
    public static String encryptSHA256(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = digest.digest(password.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            for (byte b : hashBytes) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 algorithm not available.", e);
        }
    }

    /** Verify a raw password against a stored SHA-256 hash */
    public static boolean verifyPassword(String raw, String hash) {
        if (raw == null || hash == null) return false;
        return encryptSHA256(raw).equals(hash);
    }
}
