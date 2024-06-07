package com.jxy.api.clientsdk.model;

import java.io.Serializable;

/**
 * 壁纸请求参数封装类
 */
public class RandomWallpaperParams implements Serializable {
    private static final long serialVersionUID = 3815188540434269370L;
    private String lx;
    private String method;

    public RandomWallpaperParams() {
    }

    public String getLx() {
        return this.lx;
    }

    public String getMethod() {
        return this.method;
    }

    public RandomWallpaperParams setLx(final String lx) {
        this.lx = lx;
        return this;
    }

    public RandomWallpaperParams setMethod(final String method) {
        this.method = method;
        return this;
    }

    public boolean equals(final Object o) {
        if (o == this) {
            return true;
        } else if (!(o instanceof RandomWallpaperParams)) {
            return false;
        } else {
            RandomWallpaperParams other = (RandomWallpaperParams)o;
            if (!other.canEqual(this)) {
                return false;
            } else {
                Object this$lx = this.getLx();
                Object other$lx = other.getLx();
                if (this$lx == null) {
                    if (other$lx != null) {
                        return false;
                    }
                } else if (!this$lx.equals(other$lx)) {
                    return false;
                }

                Object this$method = this.getMethod();
                Object other$method = other.getMethod();
                if (this$method == null) {
                    if (other$method != null) {
                        return false;
                    }
                } else if (!this$method.equals(other$method)) {
                    return false;
                }

                return true;
            }
        }
    }

    protected boolean canEqual(final Object other) {
        return other instanceof RandomWallpaperParams;
    }

    public int hashCode() {
        int result = 1;
        Object $lx = this.getLx();
        result = result * 59 + ($lx == null ? 43 : $lx.hashCode());
        Object $method = this.getMethod();
        result = result * 59 + ($method == null ? 43 : $method.hashCode());
        return result;
    }

    public String toString() {
        return "RandomWallpaperParams(lx=" + this.getLx() + ", method=" + this.getMethod() + ")";
    }
}
