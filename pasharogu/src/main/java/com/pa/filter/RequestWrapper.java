package com.pa.filter;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletRequestWrapper;

public final class RequestWrapper extends HttpServletRequestWrapper {

    public RequestWrapper(HttpServletRequest servletRequest) {
        super(servletRequest);
    }

    public String[] getParameterValues(String parameter) {

        String[] values = super.getParameterValues(parameter);
        if (values == null) {
            return null;
        }
        int count = values.length;
        String[] encodedValues = new String[count];
        for (int i = 0; i < count; i++) {
            encodedValues[i] = cleanXSS(values[i]);
        }
        return encodedValues;
    }

    public String getParameter(String parameter) {
        String value = super.getParameter(parameter);
        if (value == null) {
            return null;
        }
        return cleanXSS(value);
    }

    public String getHeader(String name) {
        String value = super.getHeader(name);
        if (value == null)
            return null;
        return cleanXSS(value);

    }

    private String cleanXSS(String value) {
        if (value == null) return null;

        String returnVal = value;

        returnVal = returnVal.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
        returnVal = returnVal.replaceAll("\\(", "&#40;").replaceAll("\\)", "&#41;");
        returnVal = returnVal.replaceAll("'", "&#39;");
        returnVal = returnVal.replaceAll("\"", "&quot;");
        returnVal = returnVal.replaceAll("(?i)script", "");
        returnVal = returnVal.replaceAll("(?i)iframe", "");
        returnVal = returnVal.replaceAll("(?i)embed", "");
        returnVal = returnVal.replaceAll("(?i)frame", "");
        returnVal = returnVal.replaceAll("(?i)on\\w+\\s*=\\s*", "");
        returnVal = returnVal.replaceAll("(?i)javascript:", "");
        returnVal = returnVal.replaceAll("(?i)vbscript:", "");
        returnVal = returnVal.replaceAll("(?i)data:text/html", "");
        returnVal = returnVal.replaceAll("(?i)base64,", "");
        returnVal = returnVal.replaceAll("(?i)eval\\((.*?)\\)", "");
        returnVal = returnVal.replaceAll("(?i)expression\\((.*?)\\)", "");
        returnVal = returnVal.replaceAll("\0", "");
        returnVal = returnVal.replaceAll("(?i)&#x([0-9a-f]+);", "");
        returnVal = returnVal.replaceAll("(?i)&#([0-9]+);", "");

        return returnVal;
    }
}