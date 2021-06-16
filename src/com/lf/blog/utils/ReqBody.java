package com.lf.blog.utils;

import com.alibaba.fastjson.JSON;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class ReqBody {

    public String getBody(HttpServletRequest request) throws ServletException, IOException{
        request.setCharacterEncoding("UTF-8");
        Map<String,Object> params = new HashMap<String, Object>();
        BufferedReader br;
        try {
            br = request.getReader();
            String str, wholeStr = "";
            while((str = br.readLine()) != null){
                wholeStr += str;
            }
            if(wholeStr!=null){
                params = JSON.parseObject(wholeStr,Map.class);
            }
        } catch (IOException e1) {

        }
        return JSON.toJSONString(params);
    }
}
