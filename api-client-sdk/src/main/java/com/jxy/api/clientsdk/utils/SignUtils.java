package com.jxy.api.clientsdk.utils;

import cn.hutool.crypto.digest.DigestAlgorithm;
import cn.hutool.crypto.digest.Digester;

/**
 * 签名生成工具类
 * @author wangkeyao
 */
public class SignUtils {
    /**
     * 用户参数 + 密钥 => 签名生成算法 => 不可解密的值
     * @param body 用户参数
     * @param secretKey 密钥
     * @return 不可解密的值
     */
    public static String genSign(String body, String secretKey) {
        Digester md5 = new Digester(DigestAlgorithm.SHA256);
        String content = body + "." + secretKey;
        return md5.digestHex(content);
    }
}
