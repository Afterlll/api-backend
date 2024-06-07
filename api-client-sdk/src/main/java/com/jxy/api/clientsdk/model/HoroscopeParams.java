package com.jxy.api.clientsdk.model;

import java.io.Serializable;

public class HoroscopeParams implements Serializable {
    private static final long serialVersionUID = 3815188540434269370L;
    private String type;
    private String time;

    public HoroscopeParams() {
    }

    public String getType() {
        return this.type;
    }

    public String getTime() {
        return this.time;
    }

    public HoroscopeParams setType(final String type) {
        this.type = type;
        return this;
    }

    public HoroscopeParams setTime(final String time) {
        this.time = time;
        return this;
    }

    public boolean equals(final Object o) {
        if (o == this) {
            return true;
        } else if (!(o instanceof HoroscopeParams)) {
            return false;
        } else {
            HoroscopeParams other = (HoroscopeParams)o;
            if (!other.canEqual(this)) {
                return false;
            } else {
                Object this$type = this.getType();
                Object other$type = other.getType();
                if (this$type == null) {
                    if (other$type != null) {
                        return false;
                    }
                } else if (!this$type.equals(other$type)) {
                    return false;
                }

                Object this$time = this.getTime();
                Object other$time = other.getTime();
                if (this$time == null) {
                    if (other$time != null) {
                        return false;
                    }
                } else if (!this$time.equals(other$time)) {
                    return false;
                }

                return true;
            }
        }
    }

    protected boolean canEqual(final Object other) {
        return other instanceof HoroscopeParams;
    }

    public int hashCode() {
        int result = 1;
        Object $type = this.getType();
        result = result * 59 + ($type == null ? 43 : $type.hashCode());
        Object $time = this.getTime();
        result = result * 59 + ($time == null ? 43 : $time.hashCode());
        return result;
    }

    public String toString() {
        return "HoroscopeParams(type=" + this.getType() + ", time=" + this.getTime() + ")";
    }
}
