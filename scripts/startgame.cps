#function startgame
  math.randomseed(os.time())
  setwindowname (gamename)
  tosave = {}
  toreset = {}
  execute ("loadgeneralfunctions")
  execute ("loadptypebattlefunctions")
  execute ("configurebasicparameters")
  execute ("loadbattledata")
  execute ("itemheader")
  execute ("dungeonsearchfunctions")
  execute ("playmenu")
  activatesubmenu(1,2,3,4,5,6,7,8,9)
  inventory = {}
  inventory[101] = 1
  inventory[102] = 5
  inventory[103] = 5
  inventory[104] = 5
  table.sort(inventory)
  local playerchoice
  while(playerchoice ~= "-1") do
    printl ("[1] 전투 [2] 저장 [3] 탐험 [4] 로드 [5] 메뉴 [-1] 종료")
    playerchoice = ask("무엇을 합니까?", "1", "2", "3", "4", "5", "-1")
    if playerchoice == "1" then
      enemyparty = initializeenemyparty(EnemyPartyTempletes["thugs1"])
      battlehandler(currentpartymembers, enemyparty)
    elseif playerchoice == "2" then
      save("savetemp.txt")
    elseif playerchoice == "3" then
      execute ("firstdungeon")
    elseif playerchoice == "4" then
      load("savetemp.txt")
    elseif playerchoice == "5" then
      campmenu()
    end
  end

#end

#function loadgeneralfunctions

  --플레이어의 입력을 받는 함수. (입력을 받을 변수) = ask("출력할 문장") 형식으로 쓴다. argument를 넣으면, argument들 이외의 입력을 무시한다.
  function ask(question, ...)
  local acceptable = false
  local askt, askl = getc()

  while(not acceptable) do
    moveto(askt, askl)
    if arg.n > 0 then
      local string = question .. " (" .. arg[1]
  	for i=2,arg.n do
  	  string = string .. "/" .. arg[i]
      end
  	string = string .. ")"
  	inputq(string, "ans")
      for i=1,arg.n do
        if arg[i] == ans then
  	    acceptable = true
  	  end
      end
  	if (not acceptable) then
  	  local endt, endl = getc()
  	  erase(askt, endt)
  	end
    else
      inputq(question, "ans")
      acceptable = true
    end
  end
  return ans
  end

  --특정한 장소에 들어갔을 때 표시되는 장소 표시용 함수. argument를 넣으면, 장소를 묘사하는 텍스트가 추가적으로 붙는다.
  function printplace(placename, ...)
  	printl ("")
  	_print ("~=~+~=~ ")
  	_print (placename)
  	printl (" ~=~+~=~")
  	printlw ("")
  	for i=1, arg.n do
  		printlw (arg[i])
  	end
  end

  function printcurrentdate(newline)
  	if newline then
  		printl ("")
  	end
  	local y, m, d = getdate(date)
  	_print ("▦ " .. y .. "년 " .. m .. "월 " .. d .. "일 ")
  	if newline then
  		printl ("")
  	end
  end

  function printcurrenttime(addhour, addmin, newline)
  	if newline then
  		printl ("")
  	end
  	addhour = addhour or 0
  	addmin = addmin or 0
  	local h = 4 * phase + addhour
  	local ap = ""
  	local min = ""
  	if (h <= 12) then
  		ap = "㏂ "
  	else
  		ap = "㏘ "
  		h = h - 12
  	end
  	if (addmin == 0) then
  		min = "정각"
  	else
  		min = tostring(addmin) .. "분"
  	end
  	_print (ap .. h .. "시 " .. min )
  	if newline then
  		printl ("")
  	end
  end

  function printcurrentphase(newline)
  	if newline then
  		printl ("")
  	end
  	if phase == 0 then
  		_print ("♡ 심야")
  	elseif phase == 1 then
  		_print ("☆ 새벽")
  	elseif phase == 2 then
  		_print ("♬ 아침")
  	elseif phase == 3 then
  		_print ("⊙ 낮")
  	elseif phase == 4 then
  		_print ("♨ 저녁")
  	elseif phase == 5 then
  		_print ("◐ 밤")
  	else
  	end
  	if newline then
  		printl ("")
  	end
  end

  --캐릭터의 대사를 띄워준다. argument에 말하게 될 대사를 넣을 수 있다. 플레이어의 입력을 기다리지 않는다.
  function say(actor, ...)
  printl ("<" .. actor .. ">")
  for i=1, arg.n do
    printl ("|" .. arg[i])
  end
  printl ("--------")
  end

  --캐릭터의 대사를 띄워준다. argument에 말하게 될 대사를 넣을 수 있다. 플레이어의 입력을 기다린다.
  function sayw(actor, ...)
  printl ("<" .. actor .. ">")
  for i=1, arg.n-1 do
    printlw ("|" .. arg[i])
  end
  if arg.n > 0 then
    printl ("|" .. arg[arg.n])
  end
  printlw ("--------")
  end

  --여러 줄을 표시하되, 매번 기다린다.
  function printpara(...)
  for i=1, arg.n do
    printlw (arg[i])
  end
  end

  --커서의 현재 위치를 받는다. 위에서의 위치(top 내지 row), 왼쪽에서의 위치(left내지 column)를 각각 반환.
  function getc(...)
  return getct(), getcl()
  end

  --지정한 위치에 string을 표시하고, 커서를 원래 위치로 돌린다. 위치를 입력하지 않으면 자기 자리에 출력하고 커서를 원래 자리로 돌려놓는다. 개행 지원 안함.
  function draw(string, row, column)
  	if not row then
  	  row = getct()
  	end
  	if not column then
  	  column = getcl()
  	end
  	_draw(string, row, column)
  end

  //현재 커서 위치로부터 일정 거리만큼 떨어진 위치에 string을 표시하고, 커서를 원래 위치로 돌린다.
  function drawrelatively(string, down, right)
  	local row = getct()
  	local column = getcl()
  	local i = 0
  	for line in string:gmatch("[^\r\n]+") do
  		draw(line, row+down+i, column+right)
  		i = i + 1
  	end
  end

  --지정한 행에 string을 표시하고, 커서를 원래 위치로 돌린다. 행을 지정하지 않으면 자기 자리에 출력하고 커서를 원래 자리로 돌려놓는다.
  function drawl(string, row)
  if not row then
    row = getct()
  end
  _drawLine(string, row)
  end

  --깔끔하게 글을 쓸 수 있도록 지정한 영역을 지운다. startl과 endl을 지정하지 않으면 줄 전체를 지운다.
  function erase(startt, endt, startl, endl)
    if not startl then startl = 0 end
    if not endl then endl = windowwidth end
    local blankstring = string.rep(" ", windowwidth - 1 - startl)
    moveto(startt, startl) 
    printl (blankstring)
    blankstring = string.rep(" ", windowwidth - 1)
    for i = startt, endt do
      printl (blankstring)
    end
    blankstring = string.rep(" ", endl - 1)
    printl (blankstring)
  end


  //한 줄을 가득 지정한 문자열로 채운다.
  function printdelimiter(char)
  printl ( string.rep(char, (windowwidth - 1)/string.len(char)))
  end

  //지정한 문자열을 가운데 정렬로 표시한다.
  function printmid(line)
  	moveh(0)
  	local length = string.len(line)
  	if length >= windowwidth - 1 then
  		printl (line)
  	else
  		printl ( string.rep(' ', (windowwidth - length)/2) .. line )
  	end
  end

  function getdate(date)
  	return _getYear(date), _getMonth(date), _getDay(date)
  end

  --table.val_to_str, key_to_str, tostring 코드 출처: http://lua-users.org/wiki/TableUtils (누가 썼는지 정말 성은이 망극)

  function table.val_to_str ( v )
    if "string" == type( v ) then
      v = string.gsub( v, "\n", "\\n" )
      if string.match( string.gsub(v,"[^'\"]",""), '^"+$' ) then
        return "'" .. v .. "'"
      end
      return '"' .. string.gsub(v,'"', '\\"' ) .. '"'
    else
      return "table" == type( v ) and table.tostring( v ) or
        tostring( v )
    end
  end

  function table.key_to_str ( k )
    if "string" == type( k ) and string.match( k, "^[_%a][_%a%d]*$" ) then
      return k
    else
      return "[" .. table.val_to_str( k ) .. "]"
    end
  end

  function table.tostring( tbl )
    local result, done = {}, {}
    if "string" == type ( tbl ) or "number" == type ( tbl ) then return tbl end
    for k, v in ipairs( tbl ) do
      table.insert( result, table.val_to_str( v ) )
      done[ k ] = true
    end
    for k, v in pairs( tbl ) do
      if not done[ k ] then
        table.insert( result,
          table.key_to_str( k ) .. "=" .. table.val_to_str( v ) )
      end
    end
    return "{" .. table.concat( result, "," ) .. "}"
  end


  function addplace(code, name)
  	places[code] = name
  end

  function enableplace(code)
  	placeflag[code] = true
  end

  function disableplace(code)
  	placeflag[code] = false
  end


  --[[
  Ordered table iterator, allow to iterate on the natural order of the keys of a
  table.

  Example: 

  Source = http://lua-users.org/wiki/SortedIteration
  ]]

  function __genOrderedIndex( t )
      local orderedIndex = {}
      for key in pairs(t) do
          table.insert( orderedIndex, key )
      end
      table.sort( orderedIndex )
      return orderedIndex
  end

  function orderedNext(t, state)
      -- Equivalent of the next function, but returns the keys in the alphabetic
      -- order. We use a temporary ordered key table that is stored in the
      -- table being iterated.

      --_print("orderedNext: state = "..tostring(state) )
      if state == nil then
          -- the first time, generate the index
          t.__orderedIndex = __genOrderedIndex( t )
          key = t.__orderedIndex[1]
          return key, t[key]
      end
      -- fetch the next value
      key = nil
      for i = 1,table.getn(t.__orderedIndex) do
          if t.__orderedIndex[i] == state then
              key = t.__orderedIndex[i+1]
          end
      end

      if key then
          return key, t[key]
      end

      -- no more value to return, cleanup
      t.__orderedIndex = nil
      return
  end

  function orderedPairs(t)
      -- Equivalent of the pairs() function on tables. Allows to iterate
      -- in order
      return orderedNext, t, nil
  end

  function combo(lst, n)
    local a, number, select, newlist
    newlist = {}
    number = #lst
    select = n
    a = {}
    for i=1,select do
      a[#a+1] = i
    end
    newthing = {}
    while(1) do
      local newrow = {}
      for i = 1,select do
        newrow[#newrow + 1] = lst[a[i]]
      end
      newlist[#newlist + 1] = newrow
      i=select
      while(a[i] == (number - select + i)) do
        i = i - 1
      end
      if(i < 1) then break end
      a[i] = a[i] + 1
      for j=i, select do
        a[j] = a[i] + j - i
      end
    end
    return newlist
  end

  function gotoplace(event, newplaces)
  	printl (">> 어디로 갈까?")
  	newplaces = newplaces or places
  	local placelist = {}
  	local newlineindicator = {1, 10, 100, 200, 300, 400, 500}
  	local oldi = nil
  	local delimiter = ""
  	for i, v in orderedPairs( newplaces ) do
  		if oldi then
  			for j, w in pairs( newlineindicator ) do
  				if (oldi < w ) and (i >= w) then
  					delimiter = "\n"
  				end
  			end
  		end
  		_print (delimiter)
  		_print ("[" .. tostring(i) .. "] " .. newplaces[i])
  		table.insert(placelist, tostring(i))
  		delimiter =  "\t"
  		oldi = i
  	end
  	printl ("")
  	if not event then
  		printl ("[999] 이동 취소")
  		table.insert(placelist, 999)
  	end
  	local goto = ask("번호를 입력해 주십시오.", unpack(placelist))			
  	return goto
  end

  // 세이브 파일에 입력할 변수들을 추가한다.
  function addsave(...)
  	for i = 1, arg.n do
  		tosave[arg[i]] = _G[arg[i]]
  	end
  end

  function addreset(...)
    for i = 1, arg.n do
      toreset[arg[i]] = true
    end
  end

  function save(filename)
  	local file = io.open(filename, "w")
  	--세이브할 변수들의 이름을 아래에 넣는다.
  	--[[for k, v in pairs(tosave) do
  		if k then
  			file:write(k .. "  = " .. table.val_to_str( _G[k] ).. "\n")
  		end
  	end]]
  	file:write(DataDumper(tosave))
    file:close()    
  end

  function load(filename)
    local file = io.open(filename, "rb")
  	if file then
      for k, v in pairs(toreset) do
    		_G[k] = nil
    	end
      local loadedstring = file:read("*all")
      local loadedtables = loadstring(loadedstring)()
      for k, v in pairs(loadedtables) do
        _G[k] = v
      end
      file:close()
    else
      printl ("로드할 파일이 없습니다.")
    end
  end

  function savemenu(...)

  end

  function loadmenu(...)

  end

  --[[ DataDumper.lua
  Copyright (c) 2007 Olivetti-Engineering SA

  Permission is hereby granted, free of charge, to any person
  obtaining a copy of this software and associated documentation
  files (the "Software"), to deal in the Software without
  restriction, including without limitation the rights to use,
  copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the
  Software is furnished to do so, subject to the following
  conditions:

  The above copyright notice and this permission notice shall be
  included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  OTHER DEALINGS IN THE SOFTWARE.
  ]]

  local dumplua_closure = [[
  local closures = {}
  local function closure(t) 
    closures[#closures+1] = t
    t[1] = assert(loadstring(t[1]))
    return t[1]
  end

  for _,t in pairs(closures) do
    for i = 2,#t do 
      debug.setupvalue(t[1], i-1, t[i]) 
    end 
  end
  ]]

  local lua_reserved_keywords = {
    'and', 'break', 'do', 'else', 'elseif', 'end', 'false', 'for', 
    'function', 'if', 'in', 'local', 'nil', 'not', 'or', 'repeat', 
    'return', 'then', 'true', 'until', 'while' }

  local function keys(t)
    local res = {}
    local oktypes = { stringstring = true, numbernumber = true }
    local function cmpfct(a,b)
      if oktypes[type(a)..type(b)] then
        return a < b
      else
        return type(a) < type(b)
      end
    end
    for k in pairs(t) do
      res[#res+1] = k
    end
    table.sort(res, cmpfct)
    return res
  end

  local c_functions = {}
  for _,lib in pairs{'_G', 'string', 'table', 'math', 
      'io', 'os', 'coroutine', 'package', 'debug'} do
    local t = _G[lib] or {}
    lib = lib .. "."
    if lib == "_G." then lib = "" end
    for k,v in pairs(t) do
      if type(v) == 'function' and not pcall(string.dump, v) then
        c_functions[v] = lib..k
      end
    end
  end

  function DataDumper(value, varname, fastmode, ident)
    local defined, dumplua = {}
    -- Local variables for speed optimization
    local string_format, type, string_dump, string_rep = 
          string.format, type, string.dump, string.rep
    local tostring, pairs, table_concat = 
          tostring, pairs, table.concat
    local keycache, strvalcache, out, closure_cnt = {}, {}, {}, 0
    setmetatable(strvalcache, {__index = function(t,value)
      local res = string_format('%q', value)
      t[value] = res
      return res
    end})
    local fcts = {
      string = function(value) return strvalcache[value] end,
      number = function(value) return value end,
      boolean = function(value) return tostring(value) end,
      ['nil'] = function(value) return 'nil' end,
      ['function'] = function(value) 
        return string_format("loadstring(%q)", string_dump(value)) 
      end,
      userdata = function() error("Cannot dump userdata") end,
      thread = function() error("Cannot dump threads") end,
    }
    local function test_defined(value, path)
      if defined[value] then
        if path:match("^getmetatable.*%)$") then
          out[#out+1] = string_format("s%s, %s)\n", path:sub(2,-2), defined[value])
        else
          out[#out+1] = path .. " = " .. defined[value] .. "\n"
        end
        return true
      end
      defined[value] = path
    end
    local function make_key(t, key)
      local s
      if type(key) == 'string' and key:match('^[_%a][_%w]*$') then
        s = key .. "="
      else
        s = "[" .. dumplua(key, 0) .. "]="
      end
      t[key] = s
      return s
    end
    for _,k in ipairs(lua_reserved_keywords) do
      keycache[k] = '["'..k..'"] = '
    end
    if fastmode then 
      fcts.table = function (value)
        -- Table value
        local numidx = 1
        out[#out+1] = "{"
        for key,val in pairs(value) do
          if key == numidx then
            numidx = numidx + 1
          else
            out[#out+1] = keycache[key]
          end
          local str = dumplua(val)
          out[#out+1] = str..","
        end
        if string.sub(out[#out], -1) == "," then
          out[#out] = string.sub(out[#out], 1, -2);
        end
        out[#out+1] = "}"
        return "" 
      end
    else 
      fcts.table = function (value, ident, path)
        if test_defined(value, path) then return "nil" end
        -- Table value
        local sep, str, numidx, totallen = " ", {}, 1, 0
        local meta, metastr = (debug or getfenv()).getmetatable(value)
        if meta then
          ident = ident + 1
          metastr = dumplua(meta, ident, "getmetatable("..path..")")
          totallen = totallen + #metastr + 16
        end
        for _,key in pairs(keys(value)) do
          local val = value[key]
          local s = ""
          local subpath = path
          if key == numidx then
            subpath = subpath .. "[" .. numidx .. "]"
            numidx = numidx + 1
          else
            s = keycache[key]
            if not s:match "^%[" then subpath = subpath .. "." end
            subpath = subpath .. s:gsub("%s*=%s*$","")
          end
          s = s .. dumplua(val, ident+1, subpath)
          str[#str+1] = s
          totallen = totallen + #s + 2
        end
        if totallen > 80 then
          sep = "\n" .. string_rep("  ", ident+1)
        end
        str = "{"..sep..table_concat(str, ","..sep).." "..sep:sub(1,-3).."}" 
        if meta then
          sep = sep:sub(1,-3)
          return "setmetatable("..sep..str..","..sep..metastr..sep:sub(1,-3)..")"
        end
        return str
      end
      fcts['function'] = function (value, ident, path)
        if test_defined(value, path) then return "nil" end
        if c_functions[value] then
          return c_functions[value]
        elseif debug == nil or debug.getupvalue(value, 1) == nil then
          return string_format("loadstring(%q)", string_dump(value))
        end
        closure_cnt = closure_cnt + 1
        local res = {string.dump(value)}
        for i = 1,math.huge do
          local name, v = debug.getupvalue(value,i)
          if name == nil then break end
          res[i+1] = v
        end
        return "closure " .. dumplua(res, ident, "closures["..closure_cnt.."]")
      end
    end
    function dumplua(value, ident, path)
      return fcts[type(value)](value, ident, path)
    end
    if varname == nil then
      varname = "return "
    elseif varname:match("^[%a_][%w_]*$") then
      varname = varname .. " = "
    end
    if fastmode then
      setmetatable(keycache, {__index = make_key })
      out[1] = varname
      table.insert(out,dumplua(value, 0))
      return table.concat(out)
    else
      setmetatable(keycache, {__index = make_key })
      local items = {}
      for i=1,10 do items[i] = '' end
      items[3] = dumplua(value, ident or 0, "t")
      if closure_cnt > 0 then
        items[1], items[6] = dumplua_closure:match("(.*\n)\n(.*)")
        out[#out+1] = ""
      end
      if #out > 0 then
        items[2], items[4] = "local t = ", "\n"
        items[5] = table.concat(out)
        items[7] = varname .. "t"
      else
        items[2] = varname
      end
      return table.concat(items)
    end
  end

  function shallowcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
  end
#end

#function configurebasicparameters
  windowwidth = 120
  windowheight = 40
  bufferwidth = 120
  bufferheight = 300
  defaultforeground = 'w'
  defaultbackground = 'K'
  _setwindowsize(windowwidth, windowheight)
  _setbuffersize(bufferwidth, bufferheight)
  _setdefaultcolor(defaultforeground, defaultbackground)
#end