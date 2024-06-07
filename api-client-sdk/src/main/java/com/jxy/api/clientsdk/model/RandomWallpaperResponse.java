package com.jxy.api.clientsdk.model;

public class RandomWallpaperResponse extends ResultResponse {
    private static final long serialVersionUID = -6467312483425078539L;
    private String imgurl;

    public RandomWallpaperResponse() {
    }

    public String getImgurl() {
        return this.imgurl;
    }

    public void setImgurl(final String imgurl) {
        this.imgurl = imgurl;
    }

    public String toString() {
        return "RandomWallpaperResponse(imgurl=" + this.getImgurl() + ")";
    }

    public boolean equals(final Object o) {
        if (o == this) {
            return true;
        } else if (!(o instanceof RandomWallpaperResponse)) {
            return false;
        } else {
            RandomWallpaperResponse other = (RandomWallpaperResponse)o;
            if (!other.canEqual(this)) {
                return false;
            } else if (!super.equals(o)) {
                return false;
            } else {
                Object this$imgurl = this.getImgurl();
                Object other$imgurl = other.getImgurl();
                if (this$imgurl == null) {
                    if (other$imgurl != null) {
                        return false;
                    }
                } else if (!this$imgurl.equals(other$imgurl)) {
                    return false;
                }

                return true;
            }
        }
    }

    protected boolean canEqual(final Object other) {
        return other instanceof RandomWallpaperResponse;
    }

    public int hashCode() {
        int result = super.hashCode();
        Object $imgurl = this.getImgurl();
        result = result * 59 + ($imgurl == null ? 43 : $imgurl.hashCode());
        return result;
    }
}
