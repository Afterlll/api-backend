package com.jxy.api.clientsdk.model;

import java.io.Serializable;

/**
 * 天气API请求参数
 */
public class WeatherParams implements Serializable {
    private static final long serialVersionUID = 3815188540434269370L;
    private String ip;
    private String city;
    private String type;

    public WeatherParams() {
    }

    public String getIp() {
        return this.ip;
    }

    public String getCity() {
        return this.city;
    }

    public String getType() {
        return this.type;
    }

    public WeatherParams setIp(final String ip) {
        this.ip = ip;
        return this;
    }

    public WeatherParams setCity(final String city) {
        this.city = city;
        return this;
    }

    public WeatherParams setType(final String type) {
        this.type = type;
        return this;
    }

    public boolean equals(final Object o) {
        if (o == this) {
            return true;
        } else if (!(o instanceof WeatherParams)) {
            return false;
        } else {
            WeatherParams other = (WeatherParams)o;
            if (!other.canEqual(this)) {
                return false;
            } else {
                label47: {
                    Object this$ip = this.getIp();
                    Object other$ip = other.getIp();
                    if (this$ip == null) {
                        if (other$ip == null) {
                            break label47;
                        }
                    } else if (this$ip.equals(other$ip)) {
                        break label47;
                    }

                    return false;
                }

                Object this$city = this.getCity();
                Object other$city = other.getCity();
                if (this$city == null) {
                    if (other$city != null) {
                        return false;
                    }
                } else if (!this$city.equals(other$city)) {
                    return false;
                }

                Object this$type = this.getType();
                Object other$type = other.getType();
                if (this$type == null) {
                    if (other$type != null) {
                        return false;
                    }
                } else if (!this$type.equals(other$type)) {
                    return false;
                }

                return true;
            }
        }
    }

    protected boolean canEqual(final Object other) {
        return other instanceof WeatherParams;
    }

    public int hashCode() {
        int result = 1;
        Object $ip = this.getIp();
        result = result * 59 + ($ip == null ? 43 : $ip.hashCode());
        Object $city = this.getCity();
        result = result * 59 + ($city == null ? 43 : $city.hashCode());
        Object $type = this.getType();
        result = result * 59 + ($type == null ? 43 : $type.hashCode());
        return result;
    }

    public String toString() {
        return "WeatherParams(ip=" + this.getIp() + ", city=" + this.getCity() + ", type=" + this.getType() + ")";
    }
}
