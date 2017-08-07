#function startgame
  math.randomseed(os.time())
  setwindowname (gamename)
  tosave = {}
  toreset = {}
  world = {}
  world.dungeon = {}
  execute ("loadgeneralfunctions")  
  execute ("loadptypebattlefunctions")
  execute ("configurebasicparameters")
  execute ("loadbattledata")
  execute ("playercharacterdata")
  execute ("dungeonsearchfunctions")
  execute ("adventureoutdoors")
  execute ("infiltration")
  execute ("playmenu")
  execute ("playercommand")
  execute ("npcdialogue")
  activatesubmenu(1,2,3,4,5,6,7,8,9)
  partyhandler(currentpartymembers)
  local playerchoice
  while(playerchoice ~= "-1") do
    printl ("[1] 전투 [2] 저장 [3] 탐사 [4] 탐험 [5] 로드 [6] 메뉴 [8] 대화 [9] 침투 미니게임 [-1] 종료 ")
    playerchoice = ask("무엇을 합니까?", "1", "2", "3", "4", "5", "6", "8", "9", "-1")
    if playerchoice == "1" then
      local enemyparty = initializeenemyparty(EnemyPartyTempletes["thugs1"])
      battlehandler(enemyparty, true)
    elseif playerchoice == "2" then
      save("savetemp.txt")
    elseif playerchoice == "3" then
      enterdungeon("openingdungeon", 1)
    elseif playerchoice == "4" then
      startgamebyenteringinitialposition("CheonhoStation")
    elseif playerchoice == "5" then
      load("savetemp.txt")
    elseif playerchoice == "6" then
      campmenu()
    elseif playerchoice == "8" then
      startdialogue("Doctor1", "Explanation")
      --playerspeak(testinquery, false, player)
    elseif playerchoice == "9" then
      startinfiltration(7, 1, player)
    end
  end

#end

#function loadgeneralfunctions

  --플레이어의 입력을 받는 함수. (입력을 받을 변수) = ask("출력할 문장") 형식으로 쓴다. argument를 넣으면, argument들 이외의 입력을 무시한다.
  function ask(question, ...)
    local args = {n=select('#',...),...}
    local acceptable = false
    local askt, askl = getc()

    while(not acceptable) do
      moveto(askt, askl)
      if args.n > 0 then
        local string = question .. " (" .. args[1]
        for i=2,args.n do
          string = string .. "/" .. args[i]
        end
        string = string .. ")"
        inputq(string, "ans")
        for i=1,args.n do
          if (args[i] == ans) or (tostring(args[i]) == ans) then
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

  function askstrict(question, delegate)
    local acceptable = false
    local askt, askl = getc()

    while(not acceptable) do
      moveto(askt, askl)
      inputq(question, "ans")
      acceptable = delegate(ans)
      if (not acceptable) then
        local endt, endl = getc()
        erase(askt, endt)
      end
    end
    return acceptable
  end

  function getplayerchoice(question, choicetable)
    local choices = {}
    local choiceivpairs = {}
    local questionnaire = ""
    for k, v in pairs(choicetable) do
      if (v.Key == "newline") then
        questionnaire = questionnaire .. "\n"
      else
        questionnaire = questionnaire .. "[" .. tostring(v.Number) .. "] " .. v.Description .. " "
        table.insert(choices, v.Number)
        choiceivpairs[v.Number] = v.Key
      end
    end
    _print (questionnaire .. "\n")
    return choiceivpairs[tonumber(ask(question, table.unpack(choices)))]
  end

  function buildplayerchoice(instruction)
    choicetable = {}
    return choicetable
  end

  --특정한 장소에 들어갔을 때 표시되는 장소 표시용 함수. argument를 넣으면, 장소를 묘사하는 텍스트가 추가적으로 붙는다.
  function printplace(placename, ...)
    local args = {n=select('#',...),...}
    printl ("")
    _print ("~=~+~=~ ")
    _print (placename)
    printl (" ~=~+~=~")
    printlw ("")
    for i=1, args.n do
      printlw (args[i])
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
    local args = {n=select('#',...),...}
    printl ("<" .. actor .. ">")
    for i=1, args.n do
      printl ("|" .. args[i])
    end
    printl ("--------")
  end

  --캐릭터의 대사를 띄워준다. argument에 말하게 될 대사를 넣을 수 있다. 플레이어의 입력을 기다린다.
  function sayw(actor, ...)
    local args = {n=select('#',...),...}
    printl ("<" .. actor .. ">")
    for i=1, args.n-1 do
      printlw ("|" .. args[i])
    end
    if args.n > 0 then
      printl ("|" .. args[args.n])
    end
    printlw ("--------")
  end

  --여러 줄을 표시하되, 매번 기다린다.
  function printpara(...)
    local args = {n=select('#',...),...}
    for i=1, args.n do
      printlw (args[i])
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

  --현재 커서 위치로부터 일정 거리만큼 떨어진 위치에 string을 표시하고, 커서를 원래 위치로 돌린다.
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
    if not endl then endl = WINDOWWIDTH end
    local blankstring = string.rep(" ", WINDOWWIDTH - 1 - startl)
    moveto(startt, startl) 
    printl (blankstring)
    blankstring = string.rep(" ", WINDOWWIDTH - 1)
    for i = startt, endt do
      printl (blankstring)
    end
    blankstring = string.rep(" ", endl - 1)
    printl (blankstring)
  end

  function pickrandomresult(favortable)
    local wholecases = 0
    for _, v in pairs(favortable) do
      wholecases = wholecases + v
    end
    local value = math.random(wholecases)
    for k, v in pairs(favortable) do
      value = value - v
      if (value <= 0) then
        return k
      end
    end
    return nil --오류
  end

  --한 줄을 가득 지정한 문자열로 채운다.
  function printdelimiter(char)
  printl ( string.rep(char, (WINDOWWIDTH - 1)/string.len(char)))
  end

  --지정한 문자열을 가운데 정렬로 표시한다.
  function printmid(line)
    moveh(0)
    local length = string.len(line)
    if length >= WINDOWWIDTH - 1 then
      printl (line)
    else
      printl ( string.rep(' ', (WINDOWWIDTH - length)/2) .. line )
    end
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

  function randomlist(originall, samp)
    local newlist
    local l = {table.unpack(originall)}
    newlist = {}
    if not samp then 
      samp = 0 
    else
      samp = #l - samp
    end
    while #l > samp do
      local idx
      idx = math.random(1, #l)
      newlist[#newlist + 1] = l[idx]
      table.remove(l, idx)
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
    local destination = ask("번호를 입력해 주십시오.", table.unpack(placelist))      
    return destination
  end

  -- 세이브 파일에 입력할 변수들을 추가한다.
  function addsave(name)
    table.insert(tosave, name)
  end

  function addreset(name)
    toreset[name] = true
  end

  function save(filename)
    local savetable = {}
    for _, v in pairs(tosave) do
      savetable[v] = _G[v]
      DEBUGPRINT(_G[v])
    end
    table.save(savetable, filename)
  end

  function load(filename)
    for k, _ in pairs(toreset) do
      _G[k] = nil
    end
    local t = table.load(filename)
    DEBUGPRINT(t)
    for k, v in pairs(t) do
      _G[k] = v
      DEBUGPRINT(v, k)
    end
    afterload()
  end

  function afterload()
    partyhandler(currentpartymembers)
  end

  function savemenu(...)

  end

  function loadmenu(...)

  end

  --execute("datadumper")
  execute("tablesaveload")

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

  function DEBUGPRINT(anything, name)
    if name then
      name = name .. ": "
    else
      name = ""
    end
    if (type(anything) == "table") then
      _print(name .. table.tostring(anything) .. "\n")
    else
      _print(name .. (tostring(anything) or "") .. "\n")
    end
  end

  function CHECKGLOBALS(func, ud)
    local luainternal = {bit32 = true, coroutine = true, debug = true, io = true, math = true, os = true, package = true, string = true, table = true,
    _G = true, _VERSION = true, }

    for k, v in pairs(_G) do
      if (type(v) == "function" and not func) then
      elseif (type(v) == "userdata" and not ud) then
      elseif luainternal[k] then
      else
        printl(k .. "\t" .. tostring(v))
      end
    end
  end

  function lengthwithouttag(str)
    local strwithouttag = string.gsub(str, '/b.', '')
    strwithouttag = string.gsub(strwithouttag, '/f.', '')
    strwithouttag = string.gsub(strwithouttag, '/x', '')
    strwithouttag = string.gsub(strwithouttag, '/X', '')
    return string.len(strwithouttag)
  end
#end

#function configurebasicparameters
  WINDOWWIDTH = 120
  WINDOWHEIGHT = 40
  BUFFERWIDTH = 120
  BUFFERHEIGHT = 300
  DEFAULTFOREGROUND = 'w'
  DEFAULTBACKGROUND = 'K'
  local askt, askl = getc()
  _setwindowsize(WINDOWWIDTH, WINDOWHEIGHT)
  _setbuffersize(BUFFERWIDTH, BUFFERHEIGHT)
  _setdefaultcolor(DEFAULTFOREGROUND, DEFAULTBACKGROUND)
  moveto(askt, askl)
#end