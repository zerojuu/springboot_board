package data.mapper;

import java.util.HashMap;
import java.util.List;

import data.dto.BoardDto;

public interface BoardMapper {

	public int getTotalCount();
	public int getMaxNum();  //content 보기에 필요
	public void insertBoard(BoardDto dto);
	public void updateReadCount(String num);
	public BoardDto getData(String num);
	public List<BoardDto> getList(HashMap<String, Integer> map); //페이징처리
	public void updateBoard(BoardDto dto);
	public void deleteBoard(String num);
}
