#function dungeonsearchfunctions
  function dungeondraw(currentfloor, wholedungeon)
    mapdata = wholedungeon.map[currentfloor]
    mapdraw = {}
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
    drawrelatively(mapdata.zonemap[(mapdata.playervertical-1)*mapdata.width+mapdata.playerhorizontal], -21, 41)
    if wholedungeon.zonetext[mapdata.zonemap[(mapdata.playervertical-1)*mapdata.width+mapdata.playerhorizontal]] then
      drawrelatively(wholedungeon.zonetext[mapdata.zonemap[(mapdata.playervertical-1)*mapdata.width+mapdata.playerhorizontal]], -20, 41)
    end
    _print("")
    return currentfloor, wholedungeon
  end

  function dungeonupdate(currentfloor, wholedungeon)
    mapdata = wholedungeon.map[currentfloor]
    moveobject(mapdata, wholedungeon, dungeoninput, true)
    mapdata.visualmap = automapper(currentfloor, wholedungeon)
    return currentfloor, wholedungeon
  end

  function dungeongetinput()
    dungeoninput = ask("어떻게 할까?", "w", "a", "s", "d")
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
    local currentfloor = 1
    local currentmap = d.map[currentfloor]
    currentmap.playerhorizontal = d[entrancekey]["placewidth"]
    currentmap.visiblerange = player.dungeonvisiblerange
    currentmap.playervertical = d[entrancekey]["placeheight"]
    currentmap.visualmap = automapper(currentfloor, d)
    dungeondraw(currentfloor, d)
    while true do
      dungeongetinput()
      currentfloor, d = dungeonupdate(currentfloor, d)
      currentfloor, d = dungeondraw(currentfloor, d)
    end
  end

  execute("firstdungeon")

  for k, v in pairs(world.dungeon) do
    v.initialize()
  end

#end

#function firstdungeon
  world.dungeon["firstdungeon"] = {}
  firstdungeon = {}
  firstdungeon.name = "firstdungeon"
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
    
    d["０"] = {dungeonobjecttype="entry", placewidth=2, placeheight=19, linkto="outside", linkwhere="０"}

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