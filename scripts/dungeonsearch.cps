#function dungeonsearchfunctions
  function dungeondraw(currentfloor, wholedungeon)
    local mapdata = wholedungeon.map[currentfloor]
    local mapdraw = {}
    for i = 1, mapdata.height do
      for j = 1, mapdata.width do
        if mapdata.visualmap[(i-1)*mapdata.width+j] == "■" then
          mapdraw[#mapdraw+1] = "■"
        else
          k = mapdata[(i-1)*mapdata.width+j]
          if (k == "wall") then mapdraw[#mapdraw+1] = "＃"
          elseif (k == "blank") then mapdraw[#mapdraw+1] = "　"
          elseif (k == "door") then mapdraw[#mapdraw+1] = "門"
          elseif (k == "transparent") then mapdraw[#mapdraw+1] = "▥"
          elseif (k == "nofloor") then mapdraw[#mapdraw+1] = "凶"
          else
            k = wholedungeon[mapdata[(i-1)*mapdata.width+j]].dungeonobjecttype
            if (k == "steponevent") then mapdraw[#mapdraw+1] = "　"
            elseif (k == "blocked") then mapdraw[#mapdraw+1] = "閉"
            elseif (k == "locked") then mapdraw[#mapdraw+1] = "問"
            elseif (k == "chest") then mapdraw[#mapdraw+1] = "箱"
            elseif (k == "openedchest") then mapdraw[#mapdraw+1] = "相"
            elseif (k == "enemy") then mapdraw[#mapdraw+1] = "敵"
            elseif (k == "boss") then mapdraw[#mapdraw+1] = "敵"
            elseif (k == "hiddenpassage") then mapdraw[#mapdraw+1] = "＃"
            elseif (k == "openpassage") then mapdraw[#mapdraw+1] = "口"
            elseif (k == "entry") then mapdraw[#mapdraw+1] = "入"
            elseif (k == "exit") then mapdraw[#mapdraw+1] = "出"
            elseif (k == "start") then mapdraw[#mapdraw+1] = "　"
            elseif (k == "wall") then mapdraw[#mapdraw+1] = "＃"
            elseif (k == "blank") then mapdraw[#mapdraw+1] = "　"
            elseif (k == "door") then mapdraw[#mapdraw+1] = "門"
            elseif (k == "npc") then mapdraw[#mapdraw+1] = wholedungeon[mapdata[(i-1)*mapdata.width+j]].icon
            elseif (k == "nofloor") then mapdraw[#mapdraw+1] = "凶"
            else mapdraw[#mapdraw+1] = "Error"
            end
          end
        end
      end
      mapdraw[#mapdraw+1] = "\n"
    end
    mapdraw[(mapdata.playervertical-1)*(mapdata.width+1)+mapdata.playerhorizontal] = "主"
    _print(table.concat(mapdraw))
    --_print(wholedungeon.zonetext[mapdata.zonemap[(mapdata.playervertical-1)*mapdata.width+mapdata.playerhorizontal]])
    drawrelatively(mapdata.zonemap[(mapdata.playervertical-1)*mapdata.width+mapdata.playerhorizontal], -20, 41)
    if wholedungeon.zonetext[mapdata.zonemap[(mapdata.playervertical-1)*mapdata.width+mapdata.playerhorizontal]] then
      drawrelatively(wholedungeon.zonetext[mapdata.zonemap[(mapdata.playervertical-1)*mapdata.width+mapdata.playerhorizontal]], -19, 41)
    end
    _print("")
    return currentfloor, wholedungeon
  end

  function dungeonupdate(currentfloor, wholedungeon, dungeoninput)
    local mapdata = wholedungeon.map[currentfloor]
    moveobject(mapdata, wholedungeon, dungeoninput, true)
    mapdata.visualmap = automapper(currentfloor, wholedungeon)
    return currentfloor, wholedungeon
  end

  function dungeongetinput()
    return ask("어떻게 할까?", "w", "a", "s", "d")
  end

  function moveobject(mapdata, wholedungeon, dungeoninput, player)
    local x = mapdata.playerhorizontal
    local y = mapdata.playervertical
    local newx, newy
    newx = x
    newy = y
    if (dungeoninput == 'w') then newy = newy - 1
    elseif (dungeoninput == 's') then newy = newy + 1
    elseif (dungeoninput == 'a') then newx = newx - 1
    elseif (dungeoninput == 'd') then newx = newx + 1
    end
    if (newx < 1 or newx > mapdata.width or newy < 1 or newy > mapdata.height) then return -1
    end
    if player == true then
      local k = mapdata[(newy-1)*mapdata.width+newx]
      if (k == "wall") or (k == "transparent") or (k == "nofloor") then return -1
      elseif (k == "blank" or k == "start") then
        mapdata.playerhorizontal = newx
        mapdata.playervertical = newy
      elseif (k == "door") then
        mapdata.playerhorizontal = newx
        mapdata.playervertical = newy
      else
        k = wholedungeon[mapdata[(newy-1)*mapdata.width+newx]]
        if (k.dungeonobjecttype == "steponevent") then
          mapdata.playerhorizontal = newx
          mapdata.playervertical = newy
          k.event()
        elseif (k.dungeonobjecttype == "blocked") then
          printlw("문은 열리지 않는다. 반대쪽에서 잠긴 것 같다.")
          return -1
        elseif (k.dungeonobjecttype == "locked") then
          if k.key then
            mapdata.playerhorizontal = newx
            mapdata.playervertical = newy
            printlw("가지고 있는 열쇠로 문을 열었다!")
            k.dungeonobjecttype = "door"
          else
            printlw("문은 잠겨 있다. 열쇠가 어디 있을 듯 하다.")
          end
          return -1
        elseif (k.dungeonobjecttype == "chest") then
          mapdata.playerhorizontal = newx
          mapdata.playervertical = newy
          printlw("상자가 있다! 아이템을 얻었다.(아직 그런 건 없음)")
          k.dungeonobjecttype = "openedchest"
        elseif (k.dungeonobjecttype == "openedchest") then
          mapdata.playerhorizontal = newx
          mapdata.playervertical = newy
        elseif (k.dungeonobjecttype == "enemy") then
          printlw("문을 열고 넘어가니, 적이 기다리고 있다!")
          enemyparty = initializeenemyparty(EnemyPartyTempletes["thugs1"])
          local result = battlehandler(currentpartymembers, enemyparty)
          if result == "victory" then
            mapdata.playerhorizontal = newx
            mapdata.playervertical = newy
            k.dungeonobjecttype = "blank"
          end
        elseif (k.dungeonobjecttype == "boss") then
          printlw("문을 열고 넘어가니, 적이 기다리고 있다!")
          enemyparty = initializeenemyparty(EnemyPartyTempletes["thugs4"])
          local result = battlehandler(currentpartymembers, enemyparty)
          if result == "victory" then
            mapdata.playerhorizontal = newx
            mapdata.playervertical = newy
            k.dungeonobjecttype = "blank"
          end
        elseif (k.dungeonobjecttype == "hiddenpassage") then
          mapdata.playerhorizontal = newx
          mapdata.playervertical = newy
          printlw("벽이라고 생각한 곳에 문이 있었다!")
          k.dungeonobjecttype = "openpassage"
        elseif (k.dungeonobjecttype == "openpassage") then
          mapdata.playerhorizontal = newx
          mapdata.playervertical = newy
        elseif (k.dungeonobjecttype == "entry") then
          return -1
        elseif (k.dungeonobjecttype == "wall") then return -1
        elseif (k.dungeonobjecttype == "blank") then
          mapdata.playerhorizontal = newx
          mapdata.playervertical = newy
        elseif (k.dungeonobjecttype == "door") then
          mapdata.playerhorizontal = newx
          mapdata.playervertical = newy
        else
          return -1
        end
      end
    else
      return -1
    end
  end

  function automapper(currentfloor, wholedungeon)
    mapdata = wholedungeon.map[currentfloor]
    local x = mapdata.playerhorizontal
    local y = mapdata.playervertical
    local movex = x
    local movey = y
    mapdata.visualmap[(y-1)*mapdata.width+x] = "　"
    local n = mapdata.visiblerange
    local i, j, fieldi, fieldj, stepx, stepy, errorprev, error, k, l, checkvisible, tile
    for i = -n, n do
      for j = -(n - math.abs(i)), (n - math.abs(i)), 2*(n - math.abs(i)) do
        movex = x
        movey = y
        if j < 0 then
          fieldj = -j
          stepy = -1
        else
          fieldj = j
          stepy = 1
        end
        if i < 0 then
          fieldi = -i
          stepx = -1
        else
          fieldi = i
          stepx = 1
        end
        
        twoi = fieldi * 2
        twoj = fieldj * 2
        if fieldi > fieldj then
          errorprev = fieldi
          error = fieldi
          for k = 1, fieldi do
            movex = movex + stepx
            if (movex < 1) or (movex > mapdata.width) then break end
            error = error + twoj
            if error > twoi then
              movey = movey + stepy
              if (movey < 1) or (movey > mapdata.height) then break end
              error = error - twoi
              if (error + errorprev < twoi) then
                l = (movey-1-stepy)*mapdata.width+movex
                mapdata.visualmap[l] = "　"
                checkvisible = checktile(mapdata[l], (wholedungeon[mapdata[l]] and wholedungeon[mapdata[l]].dungeonobjecttype))
              elseif (error + errorprev > twoi) then
                l = (movey-1)*mapdata.width+movex-stepx
                mapdata.visualmap[l] = "　"
                checkvisible = checktile(mapdata[l], (wholedungeon[mapdata[l]] and wholedungeon[mapdata[l]].dungeonobjecttype))
              else
                l = (movey-1-stepy)*mapdata.width+movex
                mapdata.visualmap[l] = "　"
                checkvisible = checktile(mapdata[l], (wholedungeon[mapdata[l]] and wholedungeon[mapdata[l]].dungeonobjecttype))
                l = (movey-1)*mapdata.width+movex-stepx
                mapdata.visualmap[l] = "　"
                checkvisible = checktile(mapdata[l], (wholedungeon[mapdata[l]] and wholedungeon[mapdata[l]].dungeonobjecttype))
              end
            end
            l = (movey-1)*mapdata.width+movex
            mapdata.visualmap[l] = "　"
            checkvisible = checktile(mapdata[l], (wholedungeon[mapdata[l]] and wholedungeon[mapdata[l]].dungeonobjecttype))
            errorprev = error;
            if not checkvisible then break end
          end
        else
          errorprev = fieldj
          error = fieldj
          for k = 1, fieldj do
            movey = movey + stepy
            if (movey < 1) or (movey > mapdata.height) then break end
            error = error + twoi
            if error > twoj then
              movex = movex + stepx
              if (movex < 1) or (movex > mapdata.width) then break end
              error = error - twoj
              if (error + errorprev > twoj) then
                l = (movey-1-stepy)*mapdata.width+movex
                mapdata.visualmap[l] = "　"
                checkvisible = checktile(mapdata[l], (wholedungeon[mapdata[l]] and wholedungeon[mapdata[l]].dungeonobjecttype))
              elseif (error + errorprev < twoj) then
                l = (movey-1)*mapdata.width+movex-stepx
                mapdata.visualmap[l] = "　"
                checkvisible = checktile(mapdata[l], (wholedungeon[mapdata[l]] and wholedungeon[mapdata[l]].dungeonobjecttype))
              else
                l = (movey-1-stepy)*mapdata.width+movex
                mapdata.visualmap[l] = "　"
                checkvisible = checktile(mapdata[l], (wholedungeon[mapdata[l]] and wholedungeon[mapdata[l]].dungeonobjecttype))
                l = (movey-1)*mapdata.width+movex-stepx
                mapdata.visualmap[l] = "　"
                checkvisible = checktile(mapdata[l], (wholedungeon[mapdata[l]] and wholedungeon[mapdata[l]].dungeonobjecttype))
              end
            end
            l = (movey-1)*mapdata.width+movex
            mapdata.visualmap[l] = "　"
            checkvisible = checktile(mapdata[l], (wholedungeon[mapdata[l]] and wholedungeon[mapdata[l]].dungeonobjecttype))
            errorprev = error;
            if not checkvisible then break end
          end     
        end
        if (n - math.abs(i) == 0) then break end
      end
    end
    return mapdata.visualmap
  end

  function checktile(tile, alt)
    visible = false
    if (tile == "wall") then visible = false
    elseif (tile == "blank") then visible = true
    elseif (tile == "door") then visible = false
    elseif (tile == "transparent") then visible = true
    elseif (tile == "nofloor") then visible = true
    elseif (alt == "steponevent") then visible = true
    elseif (alt == "chest") then visible = true
    elseif (alt == "openedchest") then visible = true
    elseif (alt == "npc") then visible = true
    elseif (alt == "enemy") then visible = true
    elseif (alt == "boss") then visible = true
    elseif (alt == "blank") then visible = true
    end
    return visible
  end

  function initializedungeonfile(map, width, height)
    map = map:gsub("\n", "")
    assert((width*height*2 == map:len()), "size of a map and width * height do not correspond each other.")
    mapdata = {}
    mapdata.width = width
    mapdata.height = height
    for i = 1, map:len() , 2  do
      local c = map:sub(i,i+1)
      local x = ""
      if (c == "＃") then x = "wall"
      elseif (c == "　") then x = "blank"
      elseif (c == "門") then x = "door"
      elseif (c == "▥") then x = "transparent"
      elseif (c == "凶") then x = "nofloor"
      else
        x = c
      end
      mapdata[(i+1)/2] = x
    end
    return mapdata
  end

  function encountmanager(currentfloor, player)

  end

  function enterdungeon(dungeonkey, entrancekey)
    local d = world.dungeon[dungeonkey]
    local i
    if (d.initialevent ~= nil and not d.flags["initial"]) then
      d.flags["initial"] = true
      d.initialevent()
      printl("")
    end
    local currentfloor = d[entrancekey].floor
    local currentmap = d.map[currentfloor]
    currentmap.playerhorizontal = d[entrancekey].placewidth
    currentmap.playervertical = d[entrancekey].placeheight
    currentmap.visiblerange = player.dungeonvisiblerange
    currentmap.visualmap = automapper(currentfloor, d)
    dungeondraw(currentfloor, d)
    while true do
      i = dungeongetinput()
      currentfloor, d = dungeonupdate(currentfloor, d, i)
      currentfloor, d = dungeondraw(currentfloor, d)
    end
  end

  execute("firstdungeon")
  execute("openingdungeon")

  for k, v in pairs(world.dungeon) do
    v.initialize()
  end

#end

#function firstdungeon
  world.dungeon["firstdungeon"] = {}
  world.dungeon["firstdungeon"].flags = {}

  world.dungeon["firstdungeon"].initialize = function()
    local d = world.dungeon["firstdungeon"]
    local width = 20
    local height = 20
    local firstlevel = [[
    ＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃
    ＃　　　　　　　　　　　　　　　　＃Ｆ＃
    ＃　　　＃　＃＃　　　　＃＃＃＃　＃　＃
    ＃　　　　　Ｉ＃　　　　　　Ｇ＃　＃　＃
    ＃　　　＃＃＃＃＃＃＃＃Ｈ＃＃＃　＃　＃
    ＃　　　　　　　　　　　　　　＃　　Ｅ＃
    ＃＃＃＃＃＃＃＃＃＃＃＃門＃＃＃＃＃　＃
    ＃　　　　　　　　　　　　　　　　＃　＃
    ＃＃門＃＃＃＃＃＃＃＃＃＃＃　　　＃　＃
    ＃　Ｊ　　　　　　　　　　＃　　　＃　＃
    ＃　　　　＃＃＃＃門＃＃＃＃＃門＃＃　＃
    ＃　　　　＃　　　　　　　＃　　　＃　＃
    ＃　　　　＃　＃＃Ｋ＃＃　＃　　　＃　＃
    ＃　　　　＃　＃　　　＃　＃　　　＃　＃
    ＃　　　　＃Ｌ＃　Ｎ　＃Ｍ＃＃Ｄ＃＃　＃
    ＃＃＃＃＃＃＃＃＃Ｃ＃＃＃＃　　　　　＃
    ＃　　　＃　　　　　　　　＃＃＃＃＃門＃
    ＃　　　門Ａ　　　　　＃　＃　　　　　＃
    ＃　　　＃　　　　　Ｂ＃　　　　　　　＃
    ＃０＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃]]
    
    local firstlevelzone = [[
    ＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃
    ＃ㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅋㅋㅋㅋㅋ＃ㅊ＃
    ＃ㅌㅌㅌ＃ㅌ＃＃ㅌㅌㅌㅌ＃＃＃＃ㅋ＃ㅈ＃
    ＃ㅌㅌㅌㅌㅌㅌ＃ㅌㅌㅌㅌㅍㅌㅌ＃ㅋ＃ㅈ＃
    ＃ㅌㅌㅌ＃＃＃＃＃＃＃＃ㅛ＃＃＃ㅋ＃ㅈ＃
    ＃ㅌㅌㅌㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍ＃ㅋㅋㅇ＃
    ＃＃＃＃＃＃＃＃＃＃＃＃ㅜ＃＃＃＃＃ㅅ＃
    ＃ㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎ＃ㅅ＃
    ＃＃ㅠ＃＃＃＃＃＃＃＃＃＃＃ㅎㅎㅎ＃ㅅ＃
    ＃ㄲㄲㄲㄲㄲㄲㄲㄲㄲㄲㄲㄲ＃ㅎㅎㅎ＃ㅅ＃
    ＃ㄲㄲㄲㄲ＃＃＃＃ㅡ＃＃＃＃＃ㅗ＃＃ㅅ＃
    ＃ㄲㄲㄲㄲ＃ㄸㄸㄸㄸㄸㄸㄸ＃ㅂㅂㅂ＃ㅅ＃
    ＃ㄲㄲㄲㄲ＃ㄸ＃＃ㅃ＃＃ㄸ＃ㅂㅂㅂ＃ㅅ＃
    ＃ㄲㄲㄲㄲ＃ㄸ＃ㅃㅃㅃ＃ㄸ＃ㅂㅂㅂ＃ㅅ＃
    ＃ㄲㄲㄲㄲ＃ㄸ＃ㅃㅃㅃ＃ㄸ＃＃ㅕ＃＃ㅅ＃
    ＃＃＃＃＃＃＃＃＃ㅣ＃＃＃＃ㅁㅁㅁㅁㄹ＃
    ＃ㄱㄱㄱ＃ㄴㄴㄴㄴㄴㄴㅑㅑ＃＃＃＃＃ㅓ＃
    ＃ㄱㄱㄱㅏㄴㄴㄴㄴㄴㄴ＃ㅑ＃ㄷㄷㄷㄷㄷ＃
    ＃ㄱㄱㄱ＃ㄴㄴㄴㄴㄴㄴ＃ㅑㅑㄷㄷㄷㄷㄷ＃
    ＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃]]
    
    firstlevelzone = firstlevelzone:gsub("\n", "")
    d.map = {initializedungeonfile(firstlevel, height, width)}
    d.map[1].visualmap = {}
    d.map[1].zonemap = {}
    for i=1, height*width do
      d.map[1].visualmap[i] = "■"
      d.map[1].zonemap[i] = firstlevelzone:sub(2*i-1,2*i)
    end
    
    d["０"] = {dungeonobjecttype="entry", placewidth=2, placeheight=19, linkto="outside", linkwhere="０", floor = 1,}

    d["Ａ"] = {dungeonobjecttype="steponevent", event=d.firstdungeonA}
    d.flags["A"] = false
    d["Ｂ"] = {dungeonobjecttype="chest", item="null"}
    d["Ｃ"] = {dungeonobjecttype="blocked"}
    --firstdungeonCopen = false
    d["Ｄ"] = {dungeonobjecttype="locked", key=false}
    d["Ｅ"] = {dungeonobjecttype="steponevent", event=d.firstdungeonE}
    d.flags["E"] = false
    d["Ｆ"] = {dungeonobjecttype="steponevent", event=d.firstdungeonF}
    d["Ｇ"] = {dungeonobjecttype="chest", item="null"}
    d["Ｈ"] = {dungeonobjecttype="hiddenpassage", open=false}
    d["Ｉ"] = {dungeonobjecttype="chest", item="null"}
    d["Ｊ"] = {dungeonobjecttype="enemy", group="null"}
    d["Ｋ"] = {dungeonobjecttype="boss", group="null"}
    d["Ｌ"] = {dungeonobjecttype="chest", item="null"}
    d["Ｍ"] = {dungeonobjecttype="chest", item="null"}
    d["Ｎ"] = {dungeonobjecttype="steponevent", event=d.firstdungeonN}
    
    d.zonetext = {}
    
    d.zonetext["ㄱ"] = [[
    돌 벽으로 둘러싸인 공간이다. 바깥으로 통하는 문은 어느 샌가 닫혀있다.
    으슬으슬한 한기가 피부에 와닿는다.
    동쪽으로 문이 보인다.]]
    
    d.zonetext["ㅏ"] = [[
    문은 작은 소리를 내며 열렸다. 은근히 멀리까지 보인다.
    인기척은 보이지 않는다. 북쪽으로 문이 보인다.
    그 동쪽으로 작은 통로가 있는지 빛이 흘러나오는 것 같다.]]
    
    d.zonetext["ㄴ"] = [[
    조금 넓은 방이다. 탁자 위에 그릇 같은 것들이 널부러져 있다.
    동굴 생활이라고 치면 여기는 거실 같은 곳일까. 연병장?]]
    
    d.zonetext["ㅑ"] = [[
    좁은 통로다. 통로 저편으로 빛이 보인다.]]

    d.zonetext["ㄷ"] = [[
    침침한 빛 아래 나무상자들이 군데군데 흩어져 있다.
    값나가는 것은 없어 보인다.]]

    d.zonetext["ㅓ"] = [[
    조심스레 문을 여니, 두 갈래 길이 보인다.
    왼쪽으로 꺾이는 길 끝에 문이 보이고, 직진하는 길은 끝이 보이지 않는다.]]

    d.encounter = {}

    d.encounter["ㄱ"] = null
  end

  world.dungeon["firstdungeon"].firstdungeonA = function()
    if not world.dungeon["firstdungeon"].flags["A"] then
      printpara("무심코 발을 내딛는데 바닥에 덫이 깔려 있었다!",
      "아슬아슬하게 회피했다...")
      world.dungeon["firstdungeon"].flags["A"] = true
    else
      printlw("침입자를 막는 덫이 놓여 있다. 슬금슬금 피해 지나가자.")
    end
  end
  world.dungeon["firstdungeon"].firstdungeonE = function()
    --지각력 체크
    if (not world.dungeon["firstdungeon"].flags["E"] and not world.dungeon["firstdungeon"]["Ｄ"].key) then
      printpara("어라,",
      "북쪽 복도 끝에서 무언가가 빛난 것 같다.")
      world.dungeon["firstdungeon"].flags["E"] = true
    end
  end
  world.dungeon["firstdungeon"].firstdungeonF = function()
    if not world.dungeon["firstdungeon"]["Ｄ"].key then
      printpara("무언가가 떨어져 있다...",
      "어떤 문을 열 수 있는 열쇠인 것 같다. 가지고 있자.")
      world.dungeon["firstdungeon"]["Ｄ"].key = true
    end
  end
  world.dungeon["firstdungeon"].firstdungeonN = function()
    if world.dungeon["firstdungeon"]["Ｃ"]["type"] == "blocked" then
      printpara("문에는 커다란 걸쇠가 걸려 있다.",
      "걸쇠를 내렸다...")
      world.dungeon["firstdungeon"]["Ｃ"]["type"] = "door"
    end
  end

#end

#function openingdungeon
  world.dungeon["openingdungeon"] = {}
  world.dungeon["openingdungeon"].flags = {}

  world.dungeon["openingdungeon"].initialize = function()
    local d = world.dungeon["openingdungeon"]
    local width = 20
    local height = 20
    local firstlevel = [[
    ＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃
    ＃　　　Ｊ　　　　　　　Ｉ　　　　　　＃
    ＃　凶　＃　＃＃　　　　＃＃＃＃　　　＃
    ＃凶凶　　　　＃　　　凶凶　　＃　凶　＃
    ＃　　　＃＃＃＃＃＃＃＃＃＃＃＃　凶　＃
    ＃　　　　　　　　　　＃Ｈ　　　　　　＃
    ＃＃門＃＃＃＃＃＃＃＃＃門＃＃＃＃＃＃＃
    ＃　Ｋ　　　　　　　Ｎ＃　　　　Ｑ＃Ｆ＃
    ＃＃門▥▥＃＃＃＃＃＃＃＃＃Ｑ　Ｑ＃　＃
    ＃　Ｌ　　　＃凶　　　　ＱＰＱ　　＃　＃
    ＃　　　　Ｍ門　　　　　Ｑ＃Ｑ　　▥　＃
    ＃凶凶　　　＃凶　　　　　＃凶　　▥　＃
    ＃＃＃＃＃＃＃＃＃門＃＃　＃　　　▥　＃
    ＃　　　凶　　　　　　＃　＃　Ｇ二▥Ｅ＃
    出　　　　一　　　　　＃Ｏ＃＃Ｄ＃＃　＃
    ＃＃＃＃＃▥▥▥▥＃＃＃＃＃　　　　Ｃ＃
    ＃　　　＃Ｂ　　　　　Ｚ　＃＃＃＃＃門＃
    ＃　　　門Ａ　　　凶凶＃　＃凶　　　　＃
    ＃　Ｓ　＃　Ｘ　凶凶Ｘ＃　　Ｙ　　ＸＸ＃
    ＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃]]
    
    local firstlevelzone = [[
    ＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃
    ＃ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ＃
    ＃ㅇㅇㅇ＃ㅇ＃＃ㅇㅇㅇㅇ＃＃＃＃ㅇㅇㅇ＃
    ＃ㅇㅇㅇㅇㅇㅇ＃ㅇㅇㅇㅇㅇㅇㅇ＃ㅇㅇㅇ＃
    ＃ㅇㅇㅇ＃＃＃＃＃＃＃＃＃＃＃＃ㅇㅇㅇ＃
    ＃ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ＃ㅇㅇㅇㅇㅇㅇㅇ＃
    ＃＃ㅛ＃＃＃＃＃＃＃＃＃ㅗ＃＃＃＃＃＃＃
    ＃ㅈㅈㅈㅈㅈㅈㅈㅈㅈㅈ＃ㅅㅅㅅㅅㅅ＃ㅂ＃
    ＃＃ㅜ▥▥＃＃＃＃＃＃＃＃＃ㅅㅅㅅ＃ㅁ＃
    ＃ㅊㅊㅊㅊㅊ＃ㅋㅋㅋㅋㅋㅋㅡㅅㅅㅅ＃ㅁ＃
    ＃ㅊㅊㅊㅊㅊㅠㅋㅋㅋㅋㅋㅋ＃ㅅㅅㅅ▥ㅁ＃
    ＃ㅊㅊㅊㅊㅊ＃ㅋㅋㅋㅋㅋㅋ＃ㅅㅅㅅ▥ㅁ＃
    ＃＃＃＃＃＃＃＃＃ㅣ＃＃ㅋ＃ㅅㅅㅅ▥ㅁ＃
    ＃ㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌ＃ㅋ＃ㅅㅅㅅ▥ㅁ＃
    ㅘㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌ＃ㅋ＃＃ㅕ＃＃ㅁ＃
    ＃＃＃＃＃▥▥▥▥＃＃＃＃＃ㅁㅁㅁㅁㄹ＃
    ＃ㄱㄱㄱ＃ㄴㄴㄴㄴㄴㄴㅑㅑ＃＃＃＃＃ㅓ＃
    ＃ㄱㄱㄱㅏㄴㄴㄴㄴㄴㄴ＃ㅑ＃ㄷㄷㄷㄷㄷ＃
    ＃ㄱㄱㄱ＃ㄴㄴㄴㄴㄴㄴ＃ㅑㅑㄷㄷㄷㄷㄷ＃
    ＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃]]
    
    firstlevelzone = firstlevelzone:gsub("\n", "")
    d.map = {initializedungeonfile(firstlevel, height, width)}
    d.map[1].visualmap = {}
    d.map[1].zonemap = {}
    for i=1, height*width do
      d.map[1].visualmap[i] = "■"
      d.map[1].zonemap[i] = firstlevelzone:sub(2*i-1,2*i)
    end
    
    d["Ｓ"] = {dungeonobjecttype="start", placewidth=2, placeheight=19, linkto="", linkwhere="", floor=1}

    d["Ａ"] = {dungeonobjecttype="steponevent", event=d.A}
    d.flags["A"] = false
    d["Ｂ"] = {dungeonobjecttype="steponevent", event=d.B}
    d.flags["B"] = false
    d["Ｚ"] = {dungeonobjecttype="steponevent", event=d.BB}
    d["Ｙ"] = {dungeonobjecttype="steponevent", event=d.Y}
    d["Ｘ"] = {dungeonobjecttype="blank"}
    d["Ｃ"] = {dungeonobjecttype="steponevent", event=d.C}
    d.flags["C"] = false
    d["Ｄ"] = {dungeonobjecttype="locked", key=false}
    d["Ｅ"] = {dungeonobjecttype="steponevent", event=d.E}
    d.flags["E"] = false
    d["Ｆ"] = {dungeonobjecttype="steponevent", event=d.F}
    d.flags["F"] = false
    d["Ｇ"] = {dungeonobjecttype="steponevent", event=d.G}
    d.flags["G"] = false
    d["Ｈ"] = {dungeonobjecttype="steponevent", event=d.H}
    d.flags["H"] = false
    d["Ｉ"] = {dungeonobjecttype="enemy", group="null"}
    d["Ｊ"] = {dungeonobjecttype="enemy", group="null"}
    d["Ｋ"] = {dungeonobjecttype="steponevent", event=d.K}
    d.flags["K"] = false
    d["Ｌ"] = {dungeonobjecttype="steponevent", event=d.L}
    d["Ｍ"] = {dungeonobjecttype="enemy", group="null"}
    d["Ｎ"] = {dungeonobjecttype="chest", item="null"}
    d["Ｏ"] = {dungeonobjecttype="chest", item="null"}
    d["Ｐ"] = {dungeonobjecttype="door", item="null"}
    d["Ｑ"] = {dungeonobjecttype="blank"}

    d["一"] = {dungeonobjecttype="npc", icon="/fb人/x"}
    d["二"] = {dungeonobjecttype="npc", icon="/fb차/x"}
    
    d.zonetext = {}
    
    d.zonetext["ㄱ"] = [[
    벽으로 둘러싸인 공간이다.
    나는 왜 여기 있는 걸까….
    으슬으슬한 한기가 피부에 와닿는다.
    문이 하나 보인다. 나갈 수 있는 곳은 저기 뿐인가.]]
    
    d.zonetext["ㅏ"] = [[
    문은 작은 소리를 내며 열렸다. 건물이 이어지고 있다.
    잎으로 창살이 보인다. 창살 바깥도 건물 안이다.
    창살 사이로 지나가기는 어려워 보인다.]]
    
    d.zonetext["ㄴ"] = [[
    조금 넓은 방이다. 서랍 같은 것이 놓여 있지만, 다들 어지럽혀져 있다.
    금전출납기 같은 것이 부서진 채 널부러져 있는데, 카운터 같은 곳이었을까.
    그렇다면 철창 바깥쪽이 손님들이 드나들던 공간이었겠지.]]
    
    d.zonetext["ㅑ"] = [[
    좁은 통로다.]]

    d.zonetext["ㄷ"] = [[
    침침한 빛 아래 나무상자들이 군데군데 흩어져 있다.
    값나가는 것은 없어 보인다.]]

    d.zonetext["ㅓ"] = [[
    조심스레 문을 여니, 두 갈래 길이 보인다.
    왼쪽으로 꺾이는 길 끝에 문이 보이고, 직진하는 길은 얼마 가지 않아 막혀 있다.]]

    d.zonetext["ㄹ"] = [[
    문을 열고 나오자 북쪽과 서쪽으로 복도가 이어진다.
    서쪽 복도에는 문이 있고, 북쪽 복도에는 창살이 보인다.]]

    d.zonetext["ㅁ"] = [[
    좁은 복도다.
    살짝 어둡지만 창살과 문을 통해 들어오는 빛은 꽤 밝다.]]

    d.encounter = {}

  end

  world.dungeon["openingdungeon"].initialevent = function()
    printw("…")
    printw("…")
    printw("…")
    printlw("…!")
    sayw("/fb？？？/x", "…명 반응이 …어!")
    sayw("/fg？？？/x", "…라고 했어?")
    printpara("멀리서 사람들이 외치는 소리가 들린다….")
    sayw("/fb？？？/x", "생명 …이 있다고!", "선행정찰 때 아무 흔적도 …고 하지 않았어?")
    sayw("/fg？？？/x", "에이, …은 없어. 쥐나 야생… 정도겠지.", "챙기기나 …자고.")
    sayw("/fb？？？/x", "이 실루엣은 사람 …야.", "어쨌든 그래. 넌 안쪽을 찾아.", "난 이쪽 신경을 써야겠어.")
    printpara("소리는 점점 선명하게 들린다.", "아니, 내가 정신이 드는 것 같다.")
    sayw("/fb？？？/x", "거기 안에 있는 사람!", "내 말이 들리나?", "대답하지 않으면 적의가 있는 걸로 간주하겠어!")
    printpara("정신은 없지만 뭐라고 대답해야 할 것 같다.", "…하지만, 몸에 힘이 잘 들어가지 않는다.", "눈도 제대로 뜨지 못한 채 뭐라고 웅얼댈 뿐이다.")
    sayw("/fb？？？/x", "뭐야? 더 크게 말해! 아니, 이리 나와!")
    printpara("겨우 눈을 뜬다.", "…모르는 천장이다.", "나는 창고같은 방에 웅크려 누워 있었다. 찬 바닥 때문인지 몸이 쑤셔온다.", "몸을 일으키려 하자 목구멍에서 신음 소리가 새어나온다.")
    sayw("/fb？？？/x", "혹시 대답할 몸 상태가 아닌가? 정신 차려! /fk이런 경우에는 어떻게 하더라…/x", "그래, 이름! 이름을 말할 수 있겠어?")
    printpara("내 이름….")
    printl("[DEBUG] 이름 정하기 루틴 들어가야함")
    player.Name = "주인강"
    printpara("내 이름은 /fW" .. player.Name .. "/x…", "기억은 그렇다.", "이런 상황에서 이름을 묻는 상대방이 신기하긴 하지만,", "효과는 있는지 머리가 돌아가는 것 같다.")
    sayw("/fb？？？/x", "…혹시나 해서 묻는 거지만, 몸의 감각은 있나?")
    printpara("몸의 감각…도 돌아오는 것 같다.", "내 몸은….")
    printl("[DEBUG] 캐릭터 메이킹 루틴 들어가야함")
    printpara("이제 몸을 일으킬 수 있을 것 같다.", "몇 번 기침을 하고 나자, 목소리도 나올 듯 하다.", "슬슬 밖에 있는 사람에게 대답을 해 주자.")
    sayw("/fb？？？/x", "다행히 살아있는 것 같군. 목소리를 들려주지 않겠어?")

    local q = {}
    q.question = ""
    q.references = {}

    q[1] = {answer = "답변이 늦어져서 미안하군요. 여기… 사람 있어요."}

    q[2] = {answer = "나는 /fW" .. player.Name .. "/x입니다. 적의는 없어요."}
    
    q[3] = {answer = "여긴 어디죠? 당신은 누구죠?"}

    playerspeak(q)

    sayw("/fb？？？/x", "오, 이제 말 할 수 있나 보군!", "이제 이 쪽으로 나와주지 않겠나?")
    printpara("목소리는 문의 저편에서 들리는 것 같다.", "어차피 다른 출구도 없으니 저 쪽으로 나가 볼까.")
  end

  world.dungeon["openingdungeon"].A = function()
    if not world.dungeon["openingdungeon"].flags["A"] then
      sayw("/fb？？？/x", "이 쪽이야!",
      "다행히 움직일 수는 있는 모양이군.",
      "가까이 와 줘. 이야기를 좀 하지.")
      printpara("왼편에서 나를 깨운 목소리가 들린다.",
        "철창 저편에서 내게 손짓하는 사람이 있다.",
        "가까이 가서 이야기를 들어 보자.")
      world.dungeon["openingdungeon"].flags["A"] = true
    else
    end
  end
  world.dungeon["openingdungeon"].BB = function()
    if not world.dungeon["openingdungeon"].flags["B"] then
      sayw("/fb？？？/x", "이, 이봐!",
      "이 쪽으로 오게. 이야기를 좀 하자고.")
      printpara("…가까이 가서 이야기를 들어 보자.")
      moveobject(world.dungeon["openingdungeon"].map[1], world.dungeon["openingdungeon"], "a", true)
    else
    end
  end
  world.dungeon["openingdungeon"].B = function()
    if not world.dungeon["openingdungeon"].flags["B"] then
      sayw("/fb？？？/x", "정말 살아있는 사람이군.",
      "실례했어. 위험이 따르는 일이라.")
      printpara("경계를 늦추지 않으면서도 친절하게 말을 거는 사람은 총기 같은 것과 방탄복으로 무장한 남자였다.",
        "20대를 갓 넘긴 젊은 청년 같지만, 꽤 낡아 보이는 몸에 걸친 것들과 얼굴의 흙먼지 때문인지 꽤 나이가 들어보인다.",
        "……말투 때문일지도.")
      local q = {}
      q.question = ""
      q.references = {}
      q[1] = {answer = "여긴 어디죠? 그리고 당신은 누구죠?"}
      q[2] = {answer = "위험이라니, 그게 무슨 얘기죠?"}
      q[3] = {answer = "살아있는 사람이라니… 마치 그렇지 않은 게 돌아다닌다는 듯이 말씀하시는군요."}
      local a = playerspeak(q)
      if (a == 1) then
        sayw("/fb？？？/x", "여긴 어디냐니… 이상한 말을 하는군.", "여긴 보다시피 상점가 폐허고 난 당신이 왜 여기 있는지 더 궁금한데.")
        printpara("폐허? 내가 왜 이런 곳에 있는 거지?", "이 사람은 여기서 뭘 하고 있는 거고?")
      elseif (a == 2) then
        sayw("/fb？？？/x", "위험했고말고. 지금 이렇게 당신이 나와줘서 망정이지.", "내 입장에서는 괴물이 튀어나왔을 수도 있는데.")
        printpara("괴물? 대체 무슨 소리를 하는 거지?", "복장도 그렇고 뭔가 농담 같지는 않은데.")
      else
        sayw("/fb？？？/x", "…설마 모르는 건가? 당신, 어디 동굴 안에서 살다 나왔나?", "여긴 괴물들이 우글거린다고. 괜히 무장하고 다니는 게 아냐.")
        printpara("그렇게 말한 그는 자신의 총기-스러운-무언가를 슬쩍 들어 보였다.", "설마 진짜 총인가? 대체 무슨 소리지?")
      end
      sayw("/fb？？？/x", "아 그래. 나는 /fb차기현/x이야.")
      sayw("/fb차기현/x", "천호동에 있는 거주지에서 채집꾼 일을 맡고 있어.")
      printpara("거주지? 채집꾼?", "…도무지 현대 한국의 대화에서 있을 수 없는 단어들 같은데.", "그렇게 생각하고 있자니, /fb차기현/x이라고 스스로를 소개한 남자는",
        "어떤 사실을 깨달은 듯이 놀란 표정을 지으며 숨을 삼켰다.")
      sayw("/fb차기현/x", "설마 당신… /fY박사/x가 말한 전이자…라는 건가?", "진짜 나오는 거였나….")
      q[1] = {answer = "전이자가 뭐죠?"}
      q[2] = {answer = "아까부터 저를 사람이 아닌 것 취급을 하시는데…"}
      q[3] = nil
      a = playerspeak(q)
      if (a == 1) then
        sayw("/fb차기현/x", "아… 듣고 놀라지 말라고.", "당신이 전이자라면 말이지만, 여긴 당신이 살던 세계가 아냐.", "…설명하기 어렵지만.")
      else
        sayw("/fb차기현/x", "기분 상했다면 미안해.", "하지만 정말 맞닥뜨릴 줄은 몰랐거든.", "다른 세상에서 온 사람…하고 말이지.")
      end
      sayw("/fb차기현/x", "더 설명해줬으면 하는 표정이지만, 나도 자세히 아는 건 아냐.", "하지만 자세히 설명해줄 수 있는 사람에게 데려다 줄 수는 있지.",
        "…그리고 어차피, 이 건물에서 나가면 어느 정도 이해하게 될 거고.", "'사람이 사는 곳'까지 안내가 어차피 필요할텐데,", "날 따라오는게 어때?",
        "어느 정도 보호도 해 줄 수 있어.")
      q[1] = {answer = "…좋아요. 따라가죠."}
      q[2] = {answer = "설명해 줄 수 있는 사람?"}
      q[3] = {answer = "건물에서 나가면 이해한다는 게 무슨 말이죠?"}
      q[4] = {answer = "사람이 사는 곳이라뇨?"}
      a = playerspeak(q)
      while(a ~= 1) do
        if (a == 2) then
          sayw("/fb차기현/x", "뭐… 이 '전이자' 얘기를 나한테 해 준 사람인데.", "거주지에 살고 있고, 다들 /fY박사/x라고 불러.",
            "당신같은 사람을 만나면, 자기에게 데려다 달라는 부탁을 받았는데…", "괴상한 사람이지만, 나쁜 사람은 아냐.")
        elseif (a == 3) then
          sayw("/fb차기현/x", "말 그대로… 뭐 사실 나도 잘 몰라.", "/fY박사/x가 그렇게 말한 기억이 났을 뿐이야.",
            "뭐 나가 보면 알겠지. 당신도 나도.")
        else
          sayw("/fb차기현/x", "역시 그 부분이 신경쓰이나 보군.", "이 부근은 사람이 많이 살지 않아.", "살아있는 사람들은 대부분 모여서 살고 있어.",
            "…이런 세상이니까. 스스로를 지키지 않으면 살아남기 어렵지.")
        end
        table.remove(q, a)
        a = playerspeak(q)
      end
      sayw("/fb차기현/x", "좋았어. 그렇게 결정했으면 당장 합류하지.", "철창은 통과하기 힘들겠지만, 동쪽에 길이 있어.",
        "전에도 와 본 곳이니 아마 틀림없어. 그쪽으로 나와 줘. 외길이니 헷갈릴 일은 없을거야.",
        "아. 바닥이 군데군데 꺼져 있느니 조심하라고.")
      printpara("그렇게 말하고, 차기현이라는 남자는 건너편에 있는 문으로 사라졌다.")
      world.dungeon["openingdungeon"]["一"].dungeonobjecttype = "blank"
      world.dungeon["openingdungeon"].flags["B"] = true
    end
  end
  world.dungeon["openingdungeon"].Y = function()
    if not world.dungeon["openingdungeon"].flags["Y"] then
      printpara("어라…", "건물이 흔들린다.", "…", "……", "………잠잠해졌다.","눈 앞의 벽 일부가 무너져서 바닥에 잔해가 쌓였다.",
        "다행히 지나가는 데 지장은 없을 것 같다.")
      world.dungeon["openingdungeon"]["Ｘ"].dungeonobjecttype = "wall"
      world.dungeon["openingdungeon"].flags["Y"] = true
    end
  end
  world.dungeon["openingdungeon"].C = function()
    if (not world.dungeon["openingdungeon"].flags["E"]) then
      sayw("/fb차기현/x", "이봐!")
      printpara("이 쪽에도 철창이 있다. 그 남자의 목소리가 들린다.")
      sayw("/fb차기현/x", "이 쪽으로 와 줘!")
    end
  end
  world.dungeon["openingdungeon"].E = function()
    if (not world.dungeon["openingdungeon"].flags["E"]) then
      printpara("/fb차기현/x이 왼편을 가리키며 말한다.")
      sayw("/fb차기현/x", "오, 다치진 않았나 보군. 건물이 슬슬 한계인지 흔들리던데.",
        "내가 있는 방도 일부가 무너져 내렸는데 별 일 없었나?",
        "그건 그렇고 여기 오른쪽에 있는 문… 아니, 당신 입장에선 왼쪽이군.",
        "아무래도 잠겨있는 것 같아. 혹시 그 쪽에서 열 수 있나 봐 주겠나?",
        "이쪽에는 잠금장치가 없어서, 아마 열쇠가 그 안에 있거나 할 거야.",
        "찾아봐줘. 이 쪽에서 찾으면 건네주지.")
      world.dungeon["openingdungeon"].flags["E"] = true
    end
  end
  world.dungeon["openingdungeon"].F = function()
    if not world.dungeon["openingdungeon"]["Ｄ"].key then
      printpara("무언가가 떨어져 있다...",
      "어떤 문을 열 수 있는 열쇠인 것 같다. 가지고 있자.")
      world.dungeon["openingdungeon"]["Ｄ"].key = true
    end
  end
  world.dungeon["openingdungeon"].G = function()
    if not world.dungeon["openingdungeon"].flags["G"] then
      printpara("문을 열고 나오자 지금까지 철창 건너서만 본 청년이 당신을 맞아준다.",
      "기분탓인지 모르겠지만, 안심한 표정을 지은 것 같다.")
      sayw("/fb차기현/x", "무사히 합류해서 다행이군.",
        "가능성은 낮다고 생각했지만, 괴물이 없다는 보장도 없어서 말이지.",
        "그러면 이제 밖으로 나가자고.",
        "우리 입장에선 채집 작업을 예상보다 일찍 끝내는 거지만…",
        "뭐 의외의 대물을 수거해 버렸으니 상관 없겠지.")
      printpara("/fb차기현/x은 자기 딴에는 농담이라는 듯 내 쪽을 살피며 억지로 소리를 내어 웃고 있다.")
      sayw("/fb차기현/x", "…내가 '우리'라는 말을 했던가?",
        "동료가 있어. 함께 합류해서 돌아가자고… 잠깐만. 또 흔들리잖아.")
      printpara("청년이 말하는 도중 건물이 다시 흔들리기 시작했다…",
        "…아까보다 크다!",
        "몸을 낮추고 몸을 지켰다.", "…", "……", "………", "…………잠잠해졌다.",
        "주변을 둘러보니, 여기저기가 무너져 있다.")
      world.dungeon["openingdungeon"]["Ｐ"].dungeonobjecttype = "wall"
      world.dungeon["openingdungeon"]["Ｑ"].dungeonobjecttype = "wall"
      world.dungeon["openingdungeon"]["二"].dungeonobjecttype = "nofloor"
      sayw("/fb차기현/x", "이거… 내가 들어온 문이 파묻혀 버렸군.",
        "내가 서 있던 자리는 아예 꺼져버렸고 말이야. 위헝했어….")
      sayw("/fb차기현/x", "뭐, 다른 쪽 길로 나가보자고.",
        "몸 상태가 얼마나 좋은지 모르겠으니, 당신 페이스대로 가자고.")
      printl("[DEBUG] /fb차기현/x을 파티원에 추가")
      world.dungeon["openingdungeon"].flags["G"] = true
    end
  end

#end