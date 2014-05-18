#function loadptypebattlefunctions

	--정해진 크기의 블럭을 출력한다. 출력할 블럭은 argument에 행 단위로 집어넣는다. next는 "right"나 "down", "enter"를 받아서 width 내지 height에 입력한 만큼 커서 위치를 바꾼다.
	function printblock(width, height, next, ...)
		for i = 1, arg.n do
			draw (arg[i], getct() - 1 + i)
		end
		if next == "right" then
			mover(width)
		elseif next == "down" then
			moved(height)
		elseif next == "enter" then
			moved(height)
			moveh(0)
		end
	end

	--전투용 체력 바를 만든다.
	function makebar(width, current, maximum, info, char)
		local curlen = string.len(tostring(current))
		local maxlen = string.len(tostring(maximum))
		if (not info) or (2*curlen >= width) then
			local star = math.ceil(width*current/maximum)
			return string.rep(char, star) .. string.rep(" ", width - star)
		else
			if (2*maxlen < width) then
				return string.rep(" ", math.floor(width/2 - curlen)) .. current .. "/" .. string.rep(" ", math.floor(width/2 - maxlen)) .. maximum
			else
				return string.rep(" ", math.floor(width/2 - curlen)) .. current .. "/" .. string.rep(char, math.floor(width/2))
			end
		end
	end

	function stringorder(order)
	  if (order == 0) then
	    return "<NOW>"
	  else
	    if (order == 1) then
		  return "<NEXT>"
		end
	  end
	  return "NEXT " .. order
	end

	--매번 화면을 그리는 함수. argument로 전투 메세지를 전달해야 한다.
	function draweachtime(...)
		local t, l = getc()
		if (t >= bufferheight - windowheight - 1) then
		  t = bufferheight - windowheight - 1
		end
		moveto(t, l)
		for i=1, windowheight do
		  printdelimiter(" ")
		end
		moveto(t, l)
		printdelimiter("=")
		printmid("ENEMY")
		local nameline, hpilne, mpline, statusline
		for i=1, 5 do
			if enemyparty[i] then
				nameline = "[" .. tostring(enemyparty[i].targetnumber) .. "]" .. enemyparty[i].name
				hpline = "     " .. "HP [" .. makebar(EBARWIDTH, enemyparty[i].currHP, enemyparty[i].maxHP, enemyparty[i].info, '*') .. "]"
				if enemyparty[i].ResourceType == "Mana" then
				  mpline = "     " .. "魔 [" .. makebar(EBARWIDTH, enemyparty[i].currResource, enemyparty[i].maxResource, enemyparty[i].info, '*') .. "]"
				elseif enemyparty[i].ResourceType == "Ki" then
				  mpline = "     " .. "氣 [" .. makebar(EBARWIDTH, enemyparty[i].currResource, enemyparty[i].maxResource, enemyparty[i].info, '*') .. "]"
				elseif enemyparty[i].ResourceType == "Rage" then
				  mpline = "     " .. "怒 [" .. makebar(EBARWIDTH, enemyparty[i].currResource, enemyparty[i].maxResource, enemyparty[i].info, '*') .. "]"
				else  
				  mpline = ""
				end
				order = stringorder(enemyparty[i].turnorder)
				blanklen = EWIDTH - string.len(enemyparty[i].status or "정상") - string.len(order) - 2
				statusline = enemyparty[i].status or "정상" .. string.rep(" ",blanklen) .. order
			else
				nameline = ""
				hpline = ""
				mpline = ""
				statusline = ""
			end
			printblock(EWIDTH, 4, (i < 5) and "right" or "enter", nameline, hpline, mpline, statusline)
		end
		printdelimiter("-")
		for i = 1, arg.n do
		printl (arg[i])
		end
		printdelimiter("-")
		for i=1, 4 do
			if party[i] then
				nameline = "[" .. tostring(party[i].targetnumber)  .. "]" .. party[i].name
				hpline = "     " .. "HP [" .. makebar(PBARWIDTH, party[i].currHP, party[i].maxHP, true, '*') .. "]"
				if party[i].ResourceType == "Mana" then
				  mpline = "     " .. "魔 [" .. makebar(PBARWIDTH, party[i].currResource, party[i].maxResource, true, '*') .. "]"
				elseif party[i].ResourceType == "Ki" then
				  mpline = "     " .. "氣 [" .. makebar(PBARWIDTH, party[i].currResource, party[i].maxResource, true, '*') .. "]"
				elseif party[i].ResourceType == "Rage" then
				  mpline = "     " .. "怒 [" .. makebar(PBARWIDTH, party[i].currResource, party[i].maxResource, true, '*') .. "]"
	      else
	        mpline = ""
	      end
				order = stringorder(party[i].turnorder)
				blanklen = PWIDTH - string.len(party[i].status or "정상") - string.len(order) - 2
				statusline = party[i].status or "정상" .. string.rep(" ",blanklen) .. order
			 else
				nameline = ""
				hpline = ""
				mpline = ""
				statusline = ""
			end
			printblock(PWIDTH, 4, (i < 4) and "right" or "enter", nameline, hpline, mpline, statusline)
		end
		printmid("PARTY")
		printdelimiter("=")
		_setwindowposition(t, 0)
	end
#end