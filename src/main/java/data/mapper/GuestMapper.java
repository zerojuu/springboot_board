package data.mapper;

import java.util.HashMap;
import java.util.List;

import data.dto.GuestDto;

public interface GuestMapper {

	public int getTotalCount();
	
	public void insertGuest(GuestDto dto);
	
	public void updateGuest(GuestDto dto);
	
	public void deleteGuest(String num);
	
	public void updateLikes(String num);  //좋아요 수 증가
	
	public List<GuestDto> getList(HashMap<String, Integer> map);  //페이징처리에 필요
	
	public GuestDto getData(String num);

}
