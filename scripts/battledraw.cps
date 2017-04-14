#function loadptypebattlefunctions

  --정해진 크기의 블럭을 출력한다. 출력할 블럭은 argument에 행 단위로 집어넣는다. next는 "right"나 "down", "enter"를 받아서 width 내지 height에 입력한 만큼 커서 위치를 바꾼다.
  function printblock(width, height, next, ...)
    local args = {n=select('#',...),...}
    for i = 1, args.n do
      if args[i] then
        draw (args[i], getct() - 1 + i)
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

  function makeephemeralblock(char, progress, expand)
    if char then
      local ally = char.ally
      local WIDTH = EWIDTH
      if ally then WIDTH = PWIDTH end
      if next(char.currEphemerals) == nil then
        return nil
      else
        local lines = {}
        local line = ''
        if not expand then
          for k, v in pairs(char.currEphemerals) do
            if v[2] > -1 then
              if progress and char.newEphemerals[k] then
                  if lengthwithouttag(line .. ephemerallist[k][v[1]].display .. tostring(0) .. "→" .. tostring(v[2])) <= WIDTH then
                  line = line .. ephemerallist[k][v[1]].display .. tostring(0) .. "→" .. tostring(v[2])
                else
                  table.insert(lines, line)
                  line = ephemerallist[k][v[1]].display .. tostring(0) .. "→" .. tostring(v[2])
                end
              elseif progress then
                  if lengthwithouttag(line .. ephemerallist[k][v[1]].display .. tostring(v[2]+1) .. "→" .. tostring(v[2])) <= WIDTH then
                  line = line .. ephemerallist[k][v[1]].display .. tostring(v[2]+1) .. "→" .. tostring(v[2])
                else
                  table.insert(lines, line)
                  line = ephemerallist[k][v[1]].display .. tostring(v[2]+1) .. "→" .. tostring(v[2])
                end
              else
                  if lengthwithouttag(line .. ephemerallist[k][v[1]].display .. tostring(v[2])) <= WIDTH then
                  line = line .. ephemerallist[k][v[1]].display .. tostring(v[2])
                else
                  table.insert(lines, line)
                  line = ephemerallist[k][v[1]].display .. tostring(v[2])
                end
              end
            else
                if lengthwithouttag(line .. ephemerallist[k][v[1]].display) <= WIDTH then
                line = line .. ephemerallist[k][v[1]].display
              else
                table.insert(lines, line)
                line = ephemerallist[k][v[1]].display
              end
            end
          end
          table.insert(lines, line)
        else
          for k, v in pairs(char.currEphemerals) do
            line = ephemerallist[k][v[1]].display .. " " .. ephemerallist[k][v[1]].compactdescription
            if v[2] > -1 then
              if progress and char.newEphemerals[k] then
                line = line .. " 0→" .. tostring(v[2]) .. "턴"
              elseif progress then
                line = line .. " " .. tostring(v[2]+1) .. "→" .. tostring(v[2]) .. "턴"
              else
                line = line .. " " .. tostring(v[2]) .. "턴"
              end
            end
            if lengthwithouttag(line) > WIDTH then
              line = ephemerallist[k][v[1]].display .. " " .. ephemerallist[k][v[1]].compactdescription
              table.insert(lines, line)
              if progress and char.newEphemerals[k] then
                line = string.rep(" ", ephemerallist[k][v[1]].dlength + 1) .. " 0→" .. tostring(v[2]) .. "턴"
              elseif progress then
                line = string.rep(" ", ephemerallist[k][v[1]].dlength + 1) .. tostring(v[2]+1) .. "→" .. tostring(v[2]) .. "턴"
              else
                line = string.rep(" ", ephemerallist[k][v[1]].dlength + 1) .. tostring(v[2]) .. "턴"
              end
              table.insert(lines, line)
            else
              table.insert(lines, line)
            end
          end
        end
        return lines
      end
    else
      return nil
    end
  end

  function draworderbar(progress)
    printdelimiter("=")
    printmid("ORDER")
    local line = ""
    local delimiterlength = 0
    if (progress) then
      line = "<DONE> " .. recentCharacter.name .. " "
    end
    for i, v in ipairs(orderedCharacters) do
      if (recentCharacter == v) then
        delimiterlength = lengthwithouttag(line) - 5
      end
      local tag = orderedCharacters[i].ally and "/bb" or "/br"
      line = line .. tag .. stringorder(orderedCharacters[i].turnorder, progress) .. " " .. orderedCharacters[i].name .. "/x "
    end
    printl(line)
    if (progress) then
      printl("|→" .. string.rep("-", delimiterlength) .. "→|")
    end
  end

  function stringorder(order, progress)
    local porder = order + (progress and 1 or 0)
    if (porder == 0) then
      return "<NOW>"
    elseif (porder == 1) then
      return "<NEXT>"
    end
    return "NEXT " .. porder
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
      elseif deftype[skilltype] == "a" then
        toreturn = "/fy/bg"
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
    local args = {n=select('#',...),...}
    local t, l = getc()
    if (t >= BUFFERHEIGHT - WINDOWHEIGHT - 1) then
      t = BUFFERHEIGHT - WINDOWHEIGHT - 1
    end
    moveto(t, l)
    for i=1, WINDOWHEIGHT do
      printdelimiter(" ")
    end
    moveto(t, l)
    if (player.battlepreference.draworderbar) then
      draworderbar(progress)
    end
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
        order = stringorder(e[k].turnorder, progress)
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
      ephlines = makeephemeralblock(e[k], progress and e[k] == char, player.battlepreference.expandephemeral)
      if ephlines then
        maxlines = math.max(maxlines, #ephlines)
        eephimerals[k] = ephlines
      end
    end
    if maxlines > 0 then
      for k = 1, 5 do
        if eephimerals[k] then
          printblock(EWIDTH, maxlines, (k < 5) and "right" or "enter", table.unpack(eephimerals[k]))
        else
          printblock(EWIDTH, maxlines, (k < 5) and "right" or "enter", "")
        end
      end
    end
    printdelimiter("-")
    for i = 1, args.n do
    printl (args[i])
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
        order = stringorder(p[k].turnorder, progress)
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
      ephlines = makeephemeralblock(p[k], progress and p[k] == char, player.battlepreference.expandephemeral)
      if ephlines then
        maxlines = math.max(maxlines, #ephlines)
        pephimerals[k] = ephlines
      end
    end
    if maxlines > 0 then
      for k = 1, 4 do
        if pephimerals[k] then
          printblock(PWIDTH, maxlines, (k < 4) and "right" or "enter", table.unpack(pephimerals[k]))
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