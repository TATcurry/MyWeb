package com.jxufe.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jxufe.entity.Music;
import com.jxufe.mapper.MusicMapper;
import com.jxufe.service.MusicService;



@Service
public class MusicServiceImpl implements MusicService{
	
	@Autowired
	private MusicMapper musicMapper;
	
	
	public List<Music> getAllMusic(){
		
		List<Music> selectByExample = musicMapper.selectByExample(null);
		
		return selectByExample;
		
	}


	public void addMusic(Music music) {
		// TODO Auto-generated method stub
		musicMapper.insertSelective(music);
	}


	public Music findmusic(Integer musicId) {
		// TODO Auto-generated method stub
		Music selectByExample = musicMapper.selectByPrimaryKey(musicId);
		return selectByExample;
	}
}
