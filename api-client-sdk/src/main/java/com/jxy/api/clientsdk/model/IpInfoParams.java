package com.jxy.api.clientsdk.model;

import java.io.Serializable;

/**
 * IP API 请求封装类
 */
public class IpInfoParams implements Serializable {
    private static final long serialVersionUID = 3815188540434269370L;
    private String ip;

    public IpInfoParams() {
    }

    public String getIp() {
        return this.ip;
    }

    public IpInfoParams setIp(final String ip) {
        this.ip = ip;
        return this;
    }

    public boolean equals(final Object o) {
        if (o == this) {
            return true;
        } else if (!(o instanceof IpInfoParams)) {
            return false;
        } else {
            IpInfoParams other = (IpInfoParams)o;
            if (!other.canEqual(this)) {
                return false;
            } else {
                Object this$ip = this.getIp();
                Object other$ip = other.getIp();
                if (this$ip == null) {
                    if (other$ip != null) {
                        return false;
                    }
                } else if (!this$ip.equals(other$ip)) {
                    return false;
                }

                return true;
            }
        }
    }

    protected boolean canEqual(final Object other) {
        return other instanceof IpInfoParams;
    }

    public int hashCode() {
        int result = 1;
        Object $ip = this.getIp();
        result = result * 59 + ($ip == null ? 43 : $ip.hashCode());
        return result;
    }

    public String toString() {
        return "IpInfoParams(ip=" + this.getIp() + ")";
    }
}
