package com.jxy.api.clientsdk.model;

import com.fasterxml.jackson.annotation.JsonAnyGetter;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/**
 * 结果集封装
 */
public class ResultResponse implements Serializable {
    private static final long serialVersionUID = -6486005224268968744L;
    private Map<String, Object> data = new HashMap();

    @JsonAnyGetter
    public Map<String, Object> getData() {
        return this.data;
    }

    public void setData(Map<String, Object> data) {
        this.data = data;
    }

    public boolean equals(final Object o) {
        if (o == this) {
            return true;
        } else if (!(o instanceof ResultResponse)) {
            return false;
        } else {
            ResultResponse other = (ResultResponse)o;
            if (!other.canEqual(this)) {
                return false;
            } else {
                Object this$data = this.getData();
                Object other$data = other.getData();
                if (this$data == null) {
                    if (other$data != null) {
                        return false;
                    }
                } else if (!this$data.equals(other$data)) {
                    return false;
                }

                return true;
            }
        }
    }

    protected boolean canEqual(final Object other) {
        return other instanceof ResultResponse;
    }

    public int hashCode() {
        int result = 1;
        Object $data = this.getData();
        result = result * 59 + ($data == null ? 43 : $data.hashCode());
        return result;
    }

    public String toString() {
        return "ResultResponse(data=" + this.getData() + ")";
    }

    public ResultResponse() {
    }
}
