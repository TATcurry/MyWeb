package com.jxufe.entity;

import java.util.Date;

public class Music {
    private Integer musicId;

    private String musicName;

    private String singer;

    private String location;

    private Float size;

    private String whoUpload;

    private Date time;

    public Integer getMusicId() {
        return musicId;
    }

    public void setMusicId(Integer musicId) {
        this.musicId = musicId;
    }

    public String getMusicName() {
        return musicName;
    }

    public void setMusicName(String musicName) {
        this.musicName = musicName == null ? null : musicName.trim();
    }

    public String getSinger() {
        return singer;
    }

    public void setSinger(String singer) {
        this.singer = singer == null ? null : singer.trim();
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location == null ? null : location.trim();
    }

    public Float getSize() {
        return size;
    }

    public void setSize(Float size) {
        this.size = size;
    }

    public String getWhoUpload() {
        return whoUpload;
    }

    public void setWhoUpload(String whoUpload) {
        this.whoUpload = whoUpload == null ? null : whoUpload.trim();
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }
}