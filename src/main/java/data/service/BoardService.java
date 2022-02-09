package data.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import data.dto.BoardDto;
import data.mapper.BoardMapper;

@Service
public class BoardService {

	@Autowired
	BoardMapper mapper;
	
	
	public int getTotalCount() {
		return mapper.getTotalCount();
	}
	
	public int getMaxNum() {
		return mapper.getMaxNum();
	}  
	
	public void insertBoard(BoardDto dto) {
		mapper.insertBoard(dto);
	}
	
	public void updateReadCount(String num) {
		mapper.updateReadCount(num);
	}
	
	public BoardDto getData(String num) {
		return mapper.getData(num);
	}
	
	public List<BoardDto> getList(int start,int perPage){
		HashMap<String, Integer> map=new HashMap<String, Integer>();
		map.put("start", start);
		map.put("perPage", perPage);
		return mapper.getList(map);
	}
	
	public void updateBoard(BoardDto dto) {
		mapper.updateBoard(dto);
	}
	
	public void deleteBoard(String num) {
		mapper.deleteBoard(num);
	}
}
