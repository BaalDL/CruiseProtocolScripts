#function loadptypebattlefunctions

  --정해진 크기의 블럭을 출력한다. 출력할 블럭은 argument에 행 단위로 집어넣는다. next는 "right"나 "down", "enter"를 받아서 width 내지 height에 입력한 만큼 커서 위치를 바꾼다.
  function printblock(width, height, next, ...)
    for i = 1, arg.n do
      if arg[i] then
        draw (arg[i], getct() - 1 + i)
      end
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

  function makeephemeralblock(char, progress)
    if char then
      local ally = char.ally
      local WIDTH = EWIDTH
      if ally then WIDTH = PWIDTH end
      if next(char.currEphemerals) == nil then
        return nil
      else
        local lines = {}
        local line = ''
        local lengthline = 0
        for k, v in pairs(char.currEphemerals) do
          if v[2] > -1 then
            if progress and char.newEphemerals[k] then
              if lengthline + ephemerallist[k].dlength + #tostring(0) + 2 + #tostring(v[2]) <= WIDTH then
                line = line .. ephemerallist[k].display .. tostring(0) .. "→" .. tostring(v[2])
                lengthline = lengthline + ephemerallist[k].dlength + #tostring(0) + 2 + #tostring(v[2])
              else
                table.insert(lines, line)
                line = ephemerallist[k].display .. tostring(0) .. "→" .. tostring(v[2])
                lengthline = ephemerallist[k].dlength + #tostring(0) + 2 + #tostring(v[2])
              end
            elseif progress then
              if lengthline + ephemerallist[k].dlength + #tostring(v[2]+1) + 2 + #tostring(v[2]) <= WIDTH then
                line = line .. ephemerallist[k].display .. tostring(v[2]+1) .. "→" .. tostring(v[2])
                lengthline = lengthline + ephemerallist[k].dlength + #tostring(v[2]+1) + 2 + #tostring(v[2])
              else
                table.insert(lines, line)
                line = ephemerallist[k].display .. tostring(v[2]+1) .. "→" .. tostring(v[2])
                lengthline = ephemerallist[k].dlength + #tostring(v[2]+1) + 2 + #tostring(v[2])
              end
            else
              if lengthline + ephemerallist[k].dlength + #tostring(v[2]) <= WIDTH then
                line = line .. ephemerallist[k].display .. tostring(v[2])
                lengthline = lengthline + ephemerallist[k].dlength + #tostring(v[2])
              else
                table.insert(lines, line)
                line = ephemerallist[k].display .. tostring(v[2])
                lengthline = ephemerallist[k].dlength + #tostring(v[2])
              end
            end
          else
            if lengthline + ephemerallist[k].dlength <= WIDTH then
              line = line .. ephemerallist[k].display
              lengthline = lengthline + ephemerallist[k].dlength
            else
              table.insert(lines, line)
              line = ephemerallist[k].display
              lengthline = ephemerallist[k].dlength
            end
          end
        end
        table.insert(lines, line)
        return lines
      end
    else
      return nil
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

  function defensivecolor(skilltype, deftype, deffactor, info, ally)
    local toreturn = ""
    if not info[skilltype] and not ally then
      toreturn = "/fK/bw？/x"
    else
      if deftype[skilltype] == "s" then
        if deffactor[skilltype] == 100 then
          toreturn = "/fW"
        elseif deffactor[skilltype] == 0 then
          toreturn = "/fK/bk"
        elseif deffactor[skilltype] > 100 then
          toreturn = "/fy"
        elseif deffactor[skilltype] < 100 then
          toreturn = "/fb"
        end
      elseif deftype[skilltype] == "n" then
        toreturn = "/fK/bk"
      elseif deftype[skilltype] == "r" then
        toreturn = "/fy/bb"
      end
      toreturn = toreturn .. attackType.toChar(skilltype) .. "/x"
    end
    
    return toreturn
  end

  function defensivechar(t,f, i, a, physical)
    local toreturn
    if physical then
      toreturn = defensivecolor("Slash", t, f, i, a)
      toreturn = toreturn .. defensivecolor("Strike", t, f, i, a)
      toreturn = toreturn .. defensivecolor("Pierce", t, f, i, a)
      toreturn = toreturn .. defensivecolor("Bite", t, f, i, a)
      toreturn = toreturn .. defensivecolor("Bullet", t, f, i, a)
      toreturn = toreturn .. defensivecolor("Throwing", t, f, i, a)
      toreturn = toreturn .. defensivecolor("Burst", t, f, i, a)
    elseif not physical then
      toreturn = defensivecolor("Fire", t, f, i, a)
      toreturn = toreturn .. defensivecolor("Water", t, f, i, a)
      toreturn = toreturn .. defensivecolor("Ice", t, f, i, a)
      toreturn = toreturn .. defensivecolor("Grass", t, f, i, a)
      toreturn = toreturn .. defensivecolor("Wind", t, f, i, a)
      toreturn = toreturn .. defensivecolor("Electric", t, f, i, a)
      toreturn = toreturn .. defensivecolor("Ground", t, f, i, a)
      toreturn = toreturn .. defensivecolor("Luminous", t, f, i, a)
      toreturn = toreturn .. defensivecolor("Dark", t, f, i, a)
    end
    return toreturn
  end

  --매번 화면을 그리는 함수. argument로 전투 메세지를 전달해야 한다.
  function draweachtime(progress, char, ...)
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
    local nameline, hpilne, mpline, orderline, defline1, defline2
    local maxlines, ephlines
    local eephimerals = {}
    local pephimerals = {}
    local e = currentbattle.enemyparty
    local p = currentbattle.party
    for k = 1, 5 do
      if e[k] then
        nameline = "[" .. tostring(e[k].targetnumber) .. "]" .. e[k].name
        hpline = "     " .. "HP [" .. makebar(EBARWIDTH, e[k].currHP, e[k].maxHP, e[k].info, '*') .. "]"
        if e[k].ResourceType == "Mana" then
          mpline = "     " .. "魔 [" .. makebar(EBARWIDTH, e[k].currResource, e[k].maxResource, e[k].info, '*') .. "]"
        elseif e[k].ResourceType == "Ki" then
          mpline = "     " .. "氣 [" .. makebar(EBARWIDTH, e[k].currResource, e[k].maxResource, e[k].info, '*') .. "]"
        elseif e[k].ResourceType == "Rage" then
          mpline = "     " .. "怒 [" .. makebar(EBARWIDTH, e[k].currResource, e[k].maxResource, e[k].info, '*') .. "]"
        else  
          mpline = ""
        end
        order = stringorder(e[k].turnorder)
        local blanklen = EWIDTH - string.len(order) - 2
        orderline = string.rep(" ",blanklen) .. order
        defline1 = defensivechar(e[k].defensiveType,e[k].defensiveFactor,EnemyDefenseInfo[e[k].templetes],false,true)
        defline2 = defensivechar(e[k].defensiveType,e[k].defensiveFactor,EnemyDefenseInfo[e[k].templetes],false,false)
      else
        nameline = ""
        hpline = ""
        mpline = ""
        orderline = ""
        defline1 = ""
        defline2 = ""
      end
      printblock(EWIDTH, 6, (k < 5) and "right" or "enter", nameline, hpline, mpline, orderline, defline1, defline2)
    end
    maxlines = 0
    for k = 1, 5 do
      ephlines = makeephemeralblock(e[k], progress and e[k] == char)
      if ephlines then
        maxlines = math.max(maxlines, #ephlines)
        eephimerals[k] = ephlines
      end
    end
    if maxlines > 0 then
      for k = 1, 5 do
        if eephimerals[k] then
          printblock(EWIDTH, maxlines, (k < 5) and "right" or "enter", unpack(eephimerals[k]))
        else
          printblock(EWIDTH, maxlines, (k < 5) and "right" or "enter", "")
        end
      end
    end
    printdelimiter("-")
    for i = 1, arg.n do
    printl (arg[i])
    end
    printdelimiter("-")
    for k = 1, 4 do
      if p[k] then
        nameline = "[" .. tostring(p[k].targetnumber)  .. "]" .. p[k].name
        hpline = "     " .. "HP [" .. makebar(PBARWIDTH, p[k].currHP, p[k].maxHP, true, '*') .. "]"
        if p[k].ResourceType == "Mana" then
          mpline = "     " .. "魔 [" .. makebar(PBARWIDTH, p[k].currResource, p[k].maxResource, true, '*') .. "]"
        elseif p[k].ResourceType == "Ki" then
          mpline = "     " .. "氣 [" .. makebar(PBARWIDTH, p[k].currResource, p[k].maxResource, true, '*') .. "]"
        elseif p[k].ResourceType == "Rage" then
          mpline = "     " .. "怒 [" .. makebar(PBARWIDTH, p[k].currResource, p[k].maxResource, true, '*') .. "]"
        else
          mpline = ""
        end
        order = stringorder(p[k].turnorder)
        local blanklen = PWIDTH - string.len(order) - 2
        orderline = string.rep(" ",blanklen) .. order
      else
        nameline = ""
        hpline = ""
        mpline = ""
        orderline = ""
      end
      printblock(PWIDTH, 4, (k < 4) and "right" or "enter", nameline, hpline, mpline, orderline)
    end
    maxlines = 0
    for k = 1, 4 do
      ephlines = makeephemeralblock(p[k], progress and p[k] == char)
      if ephlines then
        maxlines = math.max(maxlines, #ephlines)
        pephimerals[k] = ephlines
      end
    end
    if maxlines > 0 then
      for k = 1, 4 do
        if pephimerals[k] then
          printblock(PWIDTH, maxlines, (k < 4) and "right" or "enter", unpack(pephimerals[k]))
        else
          printblock(PWIDTH, maxlines, (k < 4) and "right" or "enter", "")
        end
      end
    end
    printmid("PARTY")
    printdelimiter("=")
    _setwindowposition(t, 0)
  end
#end