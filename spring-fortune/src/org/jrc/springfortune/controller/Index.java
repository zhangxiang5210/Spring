package org.jrc.springfortune.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Index extends BaseController
{
	@RequestMapping("welcome.htm")
	public String index()
	{
		return "welcome"
;	}
}
