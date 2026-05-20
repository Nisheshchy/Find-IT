/**
 * ValidationUtil.java
 * Purpose: Reusable server-side validation methods for form data.
 * Author: Find It Team
 * Module: CS5054NT Advanced Programming
 */
package com.findit.util;

import java.sql.Date;
import java.time.LocalDate;
import java.util.regex.Pattern;

public class ValidationUtil {

    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");

    private static final Pattern PHONE_PATTERN =
            Pattern.compile("^\\d{10}$");

    private static final Pattern LETTERS_ONLY_PATTERN =
            Pattern.compile("^[A-Za-z\\s]+$");

    /** Check if a string is not null and not empty after trimming */
    public static boolean isNotEmpty(String value) {
        return value != null && !value.trim().isEmpty();
    }

    /** Validate email format using regex */
    public static boolean isValidEmail(String email) {
        return email != null && EMAIL_PATTERN.matcher(email.trim()).matches();
    }

    /** Validate phone number: exactly 10 digits */
    public static boolean isValidPhone(String phone) {
        return phone != null && PHONE_PATTERN.matcher(phone.trim()).matches();
    }

    /** Check if string contains only letters and spaces */
    public static boolean isLettersOnly(String value) {
        return value != null && LETTERS_ONLY_PATTERN.matcher(value.trim()).matches();
    }

    /** Validate a date string and ensure it is not in the future */
    public static boolean isValidDate(String dateStr) {
        if (dateStr == null || dateStr.trim().isEmpty()) return false;
        try {
            LocalDate date = LocalDate.parse(dateStr.trim());
            return !date.isAfter(LocalDate.now());
        } catch (Exception e) {
            return false;
        }
    }

    /** Check if string length is within a maximum limit */
    public static boolean isWithinLength(String value, int maxLength) {
        return value != null && value.trim().length() <= maxLength;
    }

    /** Validate password: minimum 8 chars, at least 1 letter and 1 number */
    public static boolean isValidPassword(String password) {
        if (password == null || password.length() < 8) return false;
        boolean hasLetter = false;
        boolean hasDigit = false;
        for (char c : password.toCharArray()) {
            if (Character.isLetter(c)) hasLetter = true;
            if (Character.isDigit(c)) hasDigit = true;
            if (hasLetter && hasDigit) return true;
        }
        return false;
    }
}
