<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.utils;

import okhttp3.*;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.TimeUnit;

<#include "/java_imports.include" />
public class OkHttpUtil {

    /**
     * 默认OkHttpClient的构造器
     */
    private static final OkHttpClient.Builder defaultBuilder = new OkHttpClient.Builder()
            .connectTimeout(60, TimeUnit.MINUTES)
            .readTimeout(60, TimeUnit.MINUTES)
            .writeTimeout(60, TimeUnit.MINUTES);

    /**
     * 默认的OkHttpClient
     */
    public static OkHttpClient defaultClient() {
        return defaultBuilder.build();
    }


    /**
     * 获取post请求的返回内容
     * 参数为form表单形式发送
     */
    public static String post(String url, Map<String, String> params) throws IOException {
        FormBody.Builder builder = new FormBody.Builder();
        for (Map.Entry<String, String> entry : params.entrySet()) {
            builder.add(entry.getKey(), entry.getValue());
        }
        RequestBody formBody = builder.build();

        Request request = new Request.Builder().url(url).post(formBody).build();
        return getStringByRequest(request);
    }

    /**
     * 获取post请求的返回内容
     * 参数为json形式发送
     */
    public static String postByJson(String url, Object params) throws IOException {
        MediaType mediaType = MediaType.parse("application/json; charset=utf-8");
        String json = GsonUtil.defaultGson().toJson(params);
        RequestBody body = RequestBody.create(mediaType, json);

        Request request = new Request.Builder().url(url).post(body).build();
        return getStringByRequest(request);
    }

    /**
     * 获取get请求的返回内容
     */
    public static String get(String url) throws IOException {
        Request request = new Request.Builder().url(url).get().build();
        return getStringByRequest(request);
    }

    /**
     * 发送请求，获取返回内容
     */
    public static String getStringByRequest(Request request) throws IOException {
        OkHttpClient client = defaultClient();
        Response response = null;
        try {
            response = client.newCall(request).execute();
            if (response.isSuccessful()) {
                return response.body().string();
            } else {
                throw new IOException("Unexpected response code: " + response);
            }
        } finally {
            if (response != null) {
                response.close();
            }
        }
    }

}
