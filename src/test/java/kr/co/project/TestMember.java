package kr.co.project;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import config.MvcConfig;
import kr.co.project.member.MemberMapper;
import kr.co.project.member.MemberVO;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {MvcConfig.class})
@WebAppConfiguration
public class TestMember {
	@Autowired
	MemberMapper mapper;
	
	@Test
	public void regist() {
		MemberVO vo = new MemberVO();
		vo.setEmail("test@gmail.com");
		vo.setPwd("test1234");
		vo.setName("test");
		mapper.regist(vo);
	}
	
	@Test
	public void emailCheck() {
		int r = mapper.emailCheck("test@gmail.com");
		log.info(r+"");
	}
	
	@Test
	public void login() {
		MemberVO vo = new MemberVO();
		vo.setEmail("test@gmail.com");
		vo.setPwd("test1234");
		log.info(mapper.login(vo));
		
	}
	
	@Test
	public void testEaxm() {
	    System.out.println("1");
	    String name = "홍길동";
	    System.out.println("2");
	    assertEquals(name, "김길동");
	    System.out.println("3");
	    assertEquals(name, "홍길동");
	    System.out.println("4");
	}
}
