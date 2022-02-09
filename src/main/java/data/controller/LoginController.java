package data.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import data.mapper.MemberMapper;

@Controller
public class LoginController {

	@Autowired
	MemberMapper mapper;
	
	
	@GetMapping("/login/main")
	public String loginform(
			HttpSession session,Model model
			) {
		//폼에서 아이디 얻기
		String myid=(String)session.getAttribute("myid");
		
		//로그인 상태인지 아닌지 
		String loginok=(String)session.getAttribute("loginok");
		
		if(loginok==null)
			return "/login/loginform";
		else {
			//로그인중일때는 로그인한 이름저장
			String name=mapper.getName(myid);
			
			model.addAttribute("name", name);
			
			return "/login/logoutform";
		}	
	}
	
	@PostMapping("/login/loginprocess")
	public String loginProcess(
			@RequestParam(required = false) String cbsave,  //체크안한거 대비해서(required = false)
			@RequestParam String id,
			@RequestParam String pass,
			HttpSession session
			)
	{
		HashMap<String, String> map=new HashMap<String, String>();
		map.put("id", id);
		map.put("pass", pass);
		
		int check=mapper.login(map);
		
		if(check==1) {
			session.setAttribute("myid", id);
			session.setAttribute("loginok", "yes");
			session.setAttribute("saveok", cbsave);
			
			//체크했을때 on,안하면 null
			return "redirect:main";
		}else {
		
		  return "/member/passfail";
		}
	}

	
	@GetMapping("/login/logoutprocess")
	public String logoutProcess(HttpSession session) {
		session.removeAttribute("loginok");
		return "redirect:main";
	}
}
