package data.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import data.dto.MemberDto;
import data.mapper.MemberMapper;

@Controller
public class MemberController {

	@Autowired
	MemberMapper mapper;
	
	
	@GetMapping("/member/form")  //menu에서 회원가입의 매핑주소
	public String memberform() {
		return "/member/memberform";  //tiles경로.. /*/*
	}
	
	@GetMapping("/member/list")
	public String list(
			Model model  //또는 string대신 modelandview로 해도 됨
			) {
		List<MemberDto> list=mapper.getAllMembers();
		model.addAttribute("list", list);
		
		//회원수도 넘기기
		model.addAttribute("count", list.size());
		
		return "/member/memberlist";
	}
	
	//id체크..json반환(ResponseBody)
	@GetMapping("/member/idcheck")
	public @ResponseBody Map<String, Integer> idCheckProc(
			@RequestParam String id
			){
		//결과값이 0,1이라 integer
		
		int check=mapper.getIdCheck(id);
		
		Map<String, Integer> map=new HashMap<String, Integer>();
		
		map.put("check", check);  //결과값이 0,1
		
		return map;
	}
	
	//insert
	@PostMapping("/member/insert")
	public String memberInsert(
			@ModelAttribute MemberDto dto
			) {
		//이메일 형식으로 넣어주기
		dto.setEmail(dto.getEmail1()+"@"+dto.getEmail2());
		
		//insert 호출
		mapper.insertMember(dto);
		
		return "redirect:list";
	}
	
	//updatepassform
	@GetMapping("/member/updatepassform")
	public String updatePassForm(
			@RequestParam String num,
			Model model  //num 받은 걸 저쪽에 다시 넘겨줘야 해서 필요
			) {
		model.addAttribute("num", num);
		
		return "/member/updatepassform";
	}
	
	//비밀번호 체크후 updatepass or passfail
	@PostMapping("/member/updatepass")
	public String updatepass(
			@RequestParam String num,
			@RequestParam String pass  //sql에서 보낸 num,pass 받기
			) {
		//db로부터 비번 맞는지 체크
		HashMap<String, String> map=new HashMap<String, String>();
		map.put("num", num);
		map.put("pass", pass);
		
		int check=mapper.getCheckPass(map);
		
		if (check==1) {
			//비번이 맞는 경우..num 넘기기(num에 해당하는 dto 가져오기 위해)
			return "redirect:updateform?num="+num;
		}else {
			//비번이 틀린 경우
			return "/member/passfail";
		}		
	}
	
	@GetMapping("/member/updateform")
	public ModelAndView updateform(
			@RequestParam String num  //updatepass에서 넘긴 num 받기
			) {
		ModelAndView mview=new ModelAndView();
		
		//db로부터 dto얻기
		MemberDto dto=mapper.getMember(num);
		
		//이메일 다시 분리해놓기..split
		String [] em=dto.getEmail().split("@");
		dto.setEmail1(em[0]);
		dto.setEmail2(em[1]);
		
		mview.addObject("dto", dto);
		
		mview.setViewName("/member/updateform");		
		return mview;
	}
	
	@PostMapping("/member/update")
	public String update(
			@ModelAttribute MemberDto dto
			) {
		//이메일1,2 합치기
		dto.setEmail(dto.getEmail1()+"@"+dto.getEmail2());
		
		mapper.updateMember(dto);
		
		return "redirect:list";
	}
	
	
	//json controller이기에 @ResponseBody 사용
	@GetMapping("/member/memberdelete")
	public @ResponseBody HashMap<String, Integer> delete(
			@RequestParam String num,
			@RequestParam String pass
			){
		//db로부터 비번맞는지 체크
		//string인 num,pass여서 hashmap이 string,string
		HashMap<String, String> map=new HashMap<String, String>();
		map.put("num", num);
		map.put("pass", pass);
		
		int check=mapper.getCheckPass(map);
		
		if(check==1) {
			mapper.deleteMember(num);
		}
		//비번이 맞으면1, 틀리면 0이기에 integer
		HashMap<String, Integer> rmap=new HashMap<String, Integer>();
		rmap.put("check", check);
		return rmap;
	}	
}
