package data.controller;

import java.util.List;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import data.dto.BoardAnswerDto;
import data.mapper.MemberMapper;
import data.service.BoardAnswerService;

@RestController  //ajax로 할거라 다 restcontroller
public class BoardAnswerController {

	@Autowired
	BoardAnswerService service;
	
	@Autowired
	MemberMapper memMapper;  //댓글작성시 로그인한 아이디 알기 위해
	
	
	@PostMapping("/board/ainsert")
	public void ainsert(
			@ModelAttribute BoardAnswerDto dto,
			HttpSession session //로그인한 아이디 얻기 위해
			) {
		//세션에 로그인한 아이디 얻기..글쓴 사람이 아니라 로그인한 사람
		String myid=(String)session.getAttribute("myid");
		//아이디에 대한 작성자 얻기
		String name=memMapper.getName(myid);
		
		//dto에 넣기
		dto.setMyid(myid);
		dto.setName(name);
		
		//insert
		service.insertAnswer(dto);
	}
	
	
	@GetMapping("/board/alist")
	public List<BoardAnswerDto> alist(String num){
		return service.getAllAnswers(num);
	}
	
	
	@GetMapping("/board/adata")
	public BoardAnswerDto adata(String idx) {
		return service.getAnswer(idx);
	}
	
	
	@PostMapping("/board/aupdate")
	public void aupdate(
			@ModelAttribute BoardAnswerDto dto
			) {
		service.updateAnswer(dto);
	}
	
	
	@GetMapping("/board/adelete")
	public void adelete(String idx) {
		service.deleteAnswer(idx);
	}
}
