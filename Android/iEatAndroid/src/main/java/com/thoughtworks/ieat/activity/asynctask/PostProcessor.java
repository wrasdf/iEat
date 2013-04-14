package com.thoughtworks.ieat.activity.asynctask;

import com.thoughtworks.ieat.domain.AppHttpResponse;

public interface PostProcessor<E> {

    public void process(AppHttpResponse<E> appHttpResponse);
}
