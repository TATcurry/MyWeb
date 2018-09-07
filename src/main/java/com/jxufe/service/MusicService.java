package com.jxufe.service;

import java.util.List;

import com.jxufe.entity.Music;



public interface MusicService {
	
	public List<Music> getAllMusic();

	public void addMusic(Music music);
		

	public Music findmusic(Integer musicId);
		
}
