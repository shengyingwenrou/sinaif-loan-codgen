<#include "/java_global_assign.include" />
package com.sinaif.king.finance.${classNameLower}.utils;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.LongSerializationPolicy;

<#include "/java_imports.include" />
public class GsonUtil {

    private GsonUtil() {}

    private static final Gson DEFAULT_GSON = new GsonBuilder()
            .setLongSerializationPolicy(LongSerializationPolicy.STRING)
            .create();

    public static Gson defaultGson() {
        return DEFAULT_GSON;
    }
}
