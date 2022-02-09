package data.mapper;

import java.util.HashMap;
import java.util.List;

import data.dto.MemberDto;

public interface MemberMapper {

	public void insertMember(MemberDto dto);
	public List<MemberDto> getAllMembers();
	public int getIdCheck(String id);
	public int getCheckPass(HashMap<String, String> map);  //num,pass 넘겨야 하니 hashmap(..타입은 하나로 해야 함)
	public void updateMember(MemberDto dto);
	public MemberDto getMember(String num);
	public void deleteMember(String num);
	
	public String getName(String id);
	public int login(HashMap<String, String> map);
}
