package data.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.dto.BoardAnswerDto;

@Mapper
public interface BoardAnswerMapper {

	public void insertAnswer(BoardAnswerDto dto);
	
	public List<BoardAnswerDto> getAllAnswers(String num);
	
	public BoardAnswerDto getAnswer(String idx);
	
	public void updateAnswer(BoardAnswerDto dto);
	
	public void deleteAnswer(String idx);
}
