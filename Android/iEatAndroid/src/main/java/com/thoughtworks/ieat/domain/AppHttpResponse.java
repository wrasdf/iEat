package com.thoughtworks.ieat.domain;

public class AppHttpResponse<T> {

    private boolean isSuccessful = false;
    private Throwable exception;
    private String errorMessage;
    private T data;

    public static AppHttpResponse errorResponse() {
        AppHttpResponse errorResponse = new AppHttpResponse();
        errorResponse.setErrorMessage("Unrecognized Error!");
        return errorResponse;
    }

    public boolean isSuccessful() {
        return isSuccessful;
    }

    public void setException(Throwable e) {
        exception = e;
        errorMessage = e.getMessage();
        isSuccessful = false;
    }

    public void setData(T data) {
        isSuccessful = true;
        this.data = data;
    }

    public T getData() {
        return data;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        isSuccessful = false;
        this.errorMessage = errorMessage;
    }
}
