package com.thoughtworks.ieat.domain;

public class AppHttpResponse<T> {

    private boolean isSuccessful = false;
    private Throwable exception;
    private String errorMessage;
    private T data;

    public boolean isSuccessful() {
        return isSuccessful;
    }

    public void setException(Throwable e) {
        exception = e;
        isSuccessful = false;
    }

    public void setData(T data) {
        this.data = data;
    }

    public T getData() {
        return data;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }
}
