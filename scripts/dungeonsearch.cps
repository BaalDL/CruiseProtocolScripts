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
            k = mapdata[mapdata[(i-1)*mapdata.width+j]].dungeonobjecttype
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
            elseif (k == "npc") then mapdraw[#mapdraw+1] = mapdata[mapdata[(i-1)*mapdata.width+j]].icon
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
    --_print(mapdata.zonetext[mapdata.zonemap[(mapdata.playervertical-1)*mapdata.width+mapdata.playerhorizontal]])
    drawrelatively(mapdata.zonemap[(mapdata.playervertical-1)*mapdata.width+mapdata.playerhorizontal], -20, 41)
    if mapdata.zonetext[mapdata.zonemap[(mapdata.playervertical-1)*mapdata.width+mapdata.playerhorizontal]] then
      drawrelatively(mapdata.zonetext[mapdata.zonemap[(mapdata.playervertical-1)*mapdata.width+mapdata.playerhorizontal]], -19, 41)
    end
    _print("")
    return currentfloor, wholedungeon
  end

  function dungeonupdate(currentfloor, wholedungeon, dungeoninput)
    local mapdata = wholedungeon.map[currentfloor]
    local directioncheck = {north = true, south = true, east = true, west = true}
    if directioncheck[dungeoninput.maincommand] then
      moveobject(mapdata, wholedungeon, dungeoninput.maincommand, true)
    else
      printl("DEBUG: 메뉴 관련 처리 추가")
    end
    mapdata.visualmap = automapper(mapdata)
    return currentfloor, wholedungeon
  end

  function checkplayermovableall(mapdata)
    local x = mapdata.playerhorizontal
    local y = mapdata.playervertical
    local movables = {}
    if checkplayermovableto(mapdata, x, y-1) then table.insert(movables, "w") end
    if checkplayermovableto(mapdata, x, y+1) then table.insert(movables, "s") end
    if checkplayermovableto(mapdata, x-1, y) then table.insert(movables, "a") end
    if checkplayermovableto(mapdata, x+1, y) then table.insert(movables, "d") end
    return movables
  end

  function checkplayermovableto(mapdata, x, y)
    local movable = {blank = true, start = true, door = true, steponevent = true, chest = true, openedchest = true, enemy = true, boss = true,
    hiddenpassage = true, openpassage = true, exit = true, entry = true, blocked = true, locked = true,}
    if x < 1 or x > mapdata.width or y < 1 or y > mapdata.height then return false
    end
    local k = mapdata[(y-1)*mapdata.width + x]
    if movable[k] then return true
    elseif (k == "wall") or (k == "transparent") or (k == "nofloor") then return false
    else
      k = mapdata[mapdata[(y-1)*mapdata.width+x]].dungeonobjecttype
      if movable[k] then return true
      else return false
      end
    end
  end

  function moveobject(mapdata, wholedungeon, dungeoninput, player)
    local x = mapdata.playerhorizontal
    local y = mapdata.playervertical
    local newx, newy
    newx = x
    newy = y
    if (dungeoninput == 'w') or (dungeoninput == "north") then newy = newy - 1
    elseif (dungeoninput == 's') or (dungeoninput == "south") then newy = newy + 1
    elseif (dungeoninput == 'a') or (dungeoninput == "west") then newx = newx - 1
    elseif (dungeoninput == 'd') or (dungeoninput == "east") then newx = newx + 1
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
        k = mapdata[mapdata[(newy-1)*mapdata.width+newx]]
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
            return -1
          end
        elseif (k.dungeonobjecttype == "chest") then
          mapdata.playerhorizontal = newx
          mapdata.playervertical = newy
          printlw("상자가 있다! 아이템을 얻었다.(아직 그런 건 없음)")
          k.dungeonobjecttype = "openedchest"
        elseif (k.dungeonobjecttype == "openedchest") then
          mapdata.playerhorizontal = newx
          mapdata.playervertical = newy
        elseif (k.dungeonobjecttype == "enemy") then
          printlw("적과 마주쳤다!")
          enemyparty = initializeenemyparty(EnemyPartyTempletes[k.group])
          local result = battlehandler(enemyparty, k.fleeable)
          if result == "victory" then
            mapdata.playerhorizontal = newx
            mapdata.playervertical = newy
            k.dungeonobjecttype = "blank"
          end
        elseif (k.dungeonobjecttype == "boss") then
          printlw("적과 마주쳤다!")
          enemyparty = initializeenemyparty(EnemyPartyTempletes["thugs4"])
          local result = battlehandler(enemyparty, k.fleeable)
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
        elseif (k.dungeonobjecttype == "blank") or (k.dungeonobjecttype == "door") or (k.dungeonobjecttype == "start") then
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

  function automapper(mapdata)
    --Algorithm of Adam Millazo http://www.adammil.net/blog/v125_roguelike_vision_algorithms.html
    local top = {x = 1, y = 1}
    local bottom = {x = 1, y = 0}
    setmetatable(top, MapHelper.slope)
    setmetatable(bottom, MapHelper.slope)
    local visualmap = mapdata.visualmap
    for i = 1, 8 do
      visualmap = automapperoctant(mapdata, i, 1, top, bottom)
    end
    return visualmap
  end

  function automapperoctant(mapdata, octant, initx, top, bottom)
    local originx = mapdata.playerhorizontal
    local originy = mapdata.playervertical
    local vrange = mapdata.visiblerange
    local visualmap = mapdata.visualmap

    for iterx = initx, vrange do
      
      local topY
      if (top.x == 1) then
        topY = iterx
      else
        topY = math.floor(((2 * iterx - 1) * top.y + top.x ) / (2 * top.x))
        if MapHelper.blockslight(mapdata, iterx, topY, octant) then
          local x2yt2p1 = {x = 2 * iterx, y = 2 * topY + 1}
          setmetatable(x2yt2p1, MapHelper.slope)
          if top >= x2yt2p1 and not MapHelper.blockslight(mapdata, iterx, topY + 1, octant) then
            topY = topY + 1
          end
        else
          local ax = 2 * iterx
          if MapHelper.blockslight(mapdata, iterx + 1, topY + 1, octant) then
            ax = ax + 1
          end
          local xayt2p1 = {x = ax, y = 2 * topY + 1}
          setmetatable(xayt2p1, MapHelper.slope)
          if top > xayt2p1 then
            topY = topY + 1
          end
        end
      end
      
      local bottomY
      if (bottom.y == 0) then
        bottomY = 0
      else
        bottomY = math.floor(((2 * iterx - 1) * bottom.y + bottom.x ) / (2 * bottom.x))
        local x2yb2p1 = {x = iterx * 2, y = 2 * bottomY + 1}
        setmetatable(x2yb2p1, MapHelper.slope)
        if(bottom >= x2yb2p1 and MapHelper.blockslight(mapdata, iterx, bottomY, octant) and not MapHelper.blockslight(mapdata, iterx, bottomY+1, octant)) then
          bottomY = bottomY + 1
        end
      end

      local wasOpaque = -1
      for itery = topY, bottomY, -1 do
        if MapHelper.getdistance(0, 0, iterx, itery) <= vrange then
          local isOpaque = MapHelper.blockslight(mapdata, iterx, itery, octant)
          local x4p1y4m1 = {x = 4 * iterx + 1, y = 4 * itery - 1}
          setmetatable(x4p1y4m1, MapHelper.slope)
          local x4m1y4p1 = {x = 4 * iterx - 1, y = 4 * itery + 1}
          setmetatable(x4m1y4p1, MapHelper.slope)
          local isVisible = isOpaque or ((itery ~= topY or top > x4p1y4m1) and (itery ~= bottomY) or bottom < x4m1y4p1)
          if isVisible then visualmap = MapHelper.setvisible(mapdata, iterx, itery, octant) end

          if iterx ~= vrange then
            if isOpaque then
              if wasOpaque == 0 then
                local nx = 2 * iterx
                local ny = 2 * itery + 1
                if MapHelper.blockslight(mapdata, iterx, itery+1, octant) then nx = nx - 1 end
                local xnyn = {x = nx, y = ny}
                setmetatable(xnyn, MapHelper.slope)
                if top > xnyn then
                  if y == bottomY then
                    bottom = xnyn
                    break
                  else
                    visualmap = automapperoctant(mapdata, octant, initx + 1, top, xnyn)
                  end
                else
                  if y == bottomY then
                    return visualmap
                  end
                end
              end
              wasOpaque = 1
            else
              if wasOpaque > 0 then
                local nx = 2 * iterx
                local ny = 2 * itery + 1
                if MapHelper.blockslight(mapdata, iterx + 1, itery + 1, octant) then
                  nx = nx + 1
                end
                local xnyn = {x = nx, y = ny}
                setmetatable(xnyn, MapHelper.slope)
                if bottom > xnyn then
                  return visualmap
                end
                top = xnyn
              end
              wasOpaque = 0
            end
          end
        end
      end
      if(wasOpaque ~= 0) then break end
    end
    return visualmap
  end


  MapHelper = {}
  function MapHelper.xyto1d(x, y, dim)
    return (y-1)*dim + x
  end
  MapHelper.slope = {
    __lt = function(lhs, rhs)
      return lhs.y * rhs.x < lhs.x * rhs.y
    end,
    __le = function(lhs, rhs)
      return lhs.y * rhs.x <= lhs.x * rhs.y
    end
  }
  function MapHelper.octant(x, y, octant, dx, dy)
    local coord = {}
    if octant == 1 then
      coord.x = x + dx
      coord.y = y - dy
    elseif octant == 2 then
      coord.x = x + dy
      coord.y = y - dx
    elseif octant == 3 then
      coord.x = x - dy
      coord.y = y - dx
    elseif octant == 4 then
      coord.x = x - dx
      coord.y = y - dy
    elseif octant == 5 then
      coord.x = x - dx
      coord.y = y + dy
    elseif octant == 6 then
      coord.x = x - dy
      coord.y = y + dx
    elseif octant == 7 then
      coord.x = x + dy
      coord.y = y + dx
    elseif octant == 8 then
      coord.x = x + dx
      coord.y = y + dy
    else
      printl("MapHelper.octant에 들어온 octant의 값이 1에서 8 사이가 아닙니다: octant = " .. tostring(octant))
    end
    return coord
  end
  function MapHelper.blockslight(mapdata, dx, dy, octant)
    local x = mapdata.playerhorizontal
    local y = mapdata.playervertical
    local coord = MapHelper.octant(x, y, octant, dx, dy)
    local index = MapHelper.xyto1d(coord.x, coord.y, mapdata.width)
    if (1 <= index) and (index <= mapdata.height * mapdata.width) then
      return not checktile(mapdata[index], (mapdata[mapdata[index]] and mapdata[mapdata[index]].dungeonobjecttype))
    end
    return true
  end
  function MapHelper.setvisible(mapdata, dx, dy, octant)
    local x = mapdata.playerhorizontal
    local y = mapdata.playervertical
    local coord = MapHelper.octant(x, y, octant, dx, dy)
    local index = MapHelper.xyto1d(coord.x, coord.y, mapdata.width)
    if (1 <= index) and (index <= mapdata.height * mapdata.width) then
      mapdata.visualmap[index] = "　"
    end
    return mapdata.visualmap
  end
  function MapHelper.getdistance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1))
  end

  function checktile(tile, alt)
    visible = false
    if (tile == "blank") then visible = true
    elseif (tile == "transparent") then visible = true
    elseif (tile == "nofloor") then visible = true
    elseif (alt == "steponevent") then visible = true
    elseif (alt == "chest") then visible = true
    elseif (alt == "openedchest") then visible = true
    elseif (alt == "npc") then visible = true
    elseif (alt == "enemy") then visible = true
    elseif (alt == "boss") then visible = true
    elseif (alt == "blank") then visible = true
    elseif (alt == "transparent") then visible = true
    elseif (alt == "nofloor") then visible = true
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
    local i = {}
    i.maincommand = "donothing"
    if (d.initialevent ~= nil and not d.flags["initial"]) then
      d.flags["initial"] = true
      d.initialevent()
      printl("")
    end
    local currentfloor = d.entrances[entrancekey].floor
    local currentkey = d.entrances[entrancekey].key
    local currentmap = d.map[currentfloor]
    currentmap.playerhorizontal = currentmap[currentkey].placewidth
    currentmap.playervertical = currentmap[currentkey].placeheight
    currentmap.visiblerange = player.dungeonvisiblerange
    currentmap.visualmap = automapper(currentmap)
    dungeondraw(currentfloor, d)
    while (i.maincommand ~= "exit") do
      i = playercommand(dungeoncommand, player, currentmap)
      if (i.maincommand == "exit") then break end
      currentfloor, d = dungeonupdate(currentfloor, d, i)
      currentfloor, d = dungeondraw(currentfloor, d)
    end
  end

  dungeoncommand = {}
  dungeoncommand.references = {"player", "mapdata"}
  dungeoncommand.returns = {"maincommand", "itemcommand", "skillcommand", "skillcharacter"}
  dungeoncommand.commands = {}

  function dungeoncommand:initial()
    self.commands.maincommand = "donothing"
    self.commands.itemcommand = nil
    self.commands.skillcommand = nil
    self.commands.skillcharacter = nil

    local movelist, err = makemovelistindungeon(self.references.player, self.references.mapdata)
    if err then
      printlw("이동할 수 있는 곳이 없습니다. 던전을 탈출합니다….")
      self.commands.maincommand = "exit"
      return "terminal"
    end
    self.commands.move = ask("무엇을 하시겠습니까?" .. (self.references.player.dungeonmenuavailable and " [m] 메뉴" or ""), table.unpack(movelist))
    local m = self.commands.move
    if (m == "w") then
      self.commands.maincommand = "north"
    elseif (m == "s") then
      self.commands.maincommand = "south"
    elseif (m == "a") then
      self.commands.maincommand = "west"
    elseif (m == "d") then
      self.commands.maincommand = "east"
    elseif (m == "m") then
      self.commands.maincommand = "menu"
    end
      return "terminal"
  end


  function makemovelistindungeon(player, mapdata)
    local movelist = checkplayermovableall(mapdata)
    local cannotmove
    if (movelist == nil) then cannotmove = true end
    if player.dungeonmenuavailable then
      table.insert(movelist, "m")
    end
    return movelist, cannotmove
  end

  execute("openingdungeon")

  for k, v in pairs(world.dungeon) do
    v.initialize()
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
    ＃　　　　　　　Ｊ三　　Ｉ　　　　　　＃
    ＃　凶　＃　＃＃　　　　＃＃＃　　　　＃
    ＃凶凶　　　　＃　　　凶凶　　＃　凶　＃
    ＃　　　＃＃＃　＃＃＃　＃＃＃＃　凶　＃
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

    d.entrances = {}
    d.entrances[1] = {floor = 1, key = "Ｓ"}

    d.initialevent = function()
      if(false) then
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

        q[2] = {answer = "적의는 없어요."}
        
        q[3] = {answer = "여긴 어디죠? 당신은 누구죠?"}

        playerspeak(q)

        sayw("/fb？？？/x", "오, 이제 말 할 수 있나 보군!", "이제 이 쪽으로 나와주지 않겠나?")
        printpara("목소리는 문의 저편에서 들리는 것 같다.", "어차피 다른 출구도 없으니 저 쪽으로 나가 볼까.")
      end
    end

    local d1 = d.map[1]
    d1.flags = {}

    d1.zonetext = {}
    
    d1.zonetext["ㄱ"] = [[
    벽으로 둘러싸인 공간이다.
    나는 왜 여기 있는 걸까….
    으슬으슬한 한기가 피부에 와닿는다.
    문이 하나 보인다. 나갈 수 있는 곳은 저기 뿐인가.]]
    
    d1.zonetext["ㅏ"] = [[
    문은 작은 소리를 내며 열렸다. 건물이 이어지고 있다.
    잎으로 창살이 보인다. 창살 바깥도 건물 안이다.
    창살 사이로 지나가기는 어려워 보인다.]]
    
    d1.zonetext["ㄴ"] = [[
    조금 넓은 방이다. 서랍 같은 것이 놓여 있지만, 다들 어지럽혀져 있다.
    금전출납기 같은 것이 부서진 채 널부러져 있는데, 카운터 같은 곳이었을까.
    그렇다면 철창 바깥쪽이 손님들이 드나들던 공간이었겠지.]]
    
    d1.zonetext["ㅑ"] = [[
    좁은 통로다.]]

    d1.zonetext["ㄷ"] = [[
    침침한 빛 아래 나무상자들이 군데군데 흩어져 있다.
    값나가는 것은 없어 보인다.]]

    d1.zonetext["ㅓ"] = [[
    조심스레 문을 여니, 두 갈래 길이 보인다.
    왼쪽으로 꺾이는 길 끝에 문이 보이고, 직진하는 길은 얼마 가지 않아 막혀 있다.]]

    d1.zonetext["ㄹ"] = [[
    문을 열고 나오자 북쪽과 서쪽으로 복도가 이어진다.
    서쪽 복도에는 문이 있고, 북쪽 복도에는 창살이 보인다.]]

    d1.zonetext["ㅁ"] = [[
    좁은 복도다.
    살짝 어둡지만 창살과 문을 통해 들어오는 빛은 꽤 밝다.]]

    d1.encounter = {}

    d1.A = function()
      if not d1.flags["A"] then
        sayw("/fb？？？/x", "이 쪽이야!",
        "다행히 움직일 수는 있는 모양이군.",
        "가까이 와 줘. 이야기를 좀 하지.")
        printpara("왼편에서 나를 깨운 목소리가 들린다.",
          "철창 저편에서 내게 손짓하는 사람이 있다.",
          "가까이 가서 이야기를 들어 보자.")
        d1.flags["A"] = true
      else
      end
    end
    d1.BB = function()
      if not d1.flags["B"] then
        sayw("/fb？？？/x", "이, 이봐!",
        "이 쪽으로 오게. 이야기를 좀 하자고.")
        printpara("…가까이 가서 이야기를 들어 보자.")
        moveobject(d1, d, "a", true)
      else
      end
    end
    d1.B = function()
      if not d1.flags["B"] then
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
        d1["一"].dungeonobjecttype = "blank"
        d1.flags["B"] = true
      end
    end
    d1.Y = function()
      if not d1.flags["Y"] then
        printpara("어라…", "건물이 흔들린다.", "…", "……", "………잠잠해졌다.","눈 앞의 벽 일부가 무너져서 바닥에 잔해가 쌓였다.",
          "다행히 지나가는 데 지장은 없을 것 같다.")
        d1["Ｘ"].dungeonobjecttype = "wall"
        d1.flags["Y"] = true
      end
    end
    d1.C = function()
      if (not d1.flags["E"]) then
        sayw("/fb차기현/x", "이봐!")
        printpara("이 쪽에도 철창이 있다. 그 남자의 목소리가 들린다.")
        sayw("/fb차기현/x", "이 쪽으로 와 줘!")
      end
    end
    d1.E = function()
      if (not d1.flags["E"]) then
        printpara("/fb차기현/x이 왼편을 가리키며 말한다.")
        sayw("/fb차기현/x", "오, 다치진 않았나 보군. 건물이 슬슬 한계인지 흔들리던데.",
          "내가 있는 방도 일부가 무너져 내렸는데 별 일 없었나?",
          "그건 그렇고 여기 오른쪽에 있는 문… 아니, 당신 입장에선 왼쪽이군.",
          "아무래도 잠겨있는 것 같아. 혹시 그 쪽에서 열 수 있나 봐 주겠나?",
          "이쪽에는 잠금장치가 없어서, 아마 열쇠가 그 안에 있거나 할 거야.",
          "찾아봐줘. 이 쪽에서 찾으면 건네주지.")
        d1.flags["E"] = true
      end
    end
    d1.F = function()
      if not d1["Ｄ"].key then
        printpara("무언가가 떨어져 있다...",
        "어떤 문을 열 수 있는 열쇠인 것 같다. 가지고 있자.")
        d1["Ｄ"].key = true
      end
    end
    d1.G = function()
      if not d1.flags["G"] then
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
        d1["Ｐ"].dungeonobjecttype = "wall"
        d1["Ｑ"].dungeonobjecttype = "wall"
        d1["二"].dungeonobjecttype = "nofloor"
        sayw("/fb차기현/x", "이거… 내가 들어온 문이 파묻혀 버렸군.",
          "내가 서 있던 자리는 아예 꺼져버렸고 말이야. 위헝했어….")
        sayw("/fb차기현/x", "뭐, 다른 쪽 길로 나가보자고.",
          "몸 상태가 얼마나 좋은지 모르겠으니, 당신 페이스대로 가자고.")
        addtocurrentparty("TutorialMember1")
        sayw("/fb차기현/x", "메뉴를 열어서 지금 상태를 확인할 수 있는 걸 잊지 말고.")
        player.dungeonmenuavailable = true
        d1.flags["G"] = true
      end
    end

  d1.H = function()
    if not d1.flags["H"] then
      printpara("문을 열고 상품 진열대와 기둥의 잔해가 복잡하게 얽혀 있는 공간으로 나오니",
        "공간 한 켠에서 소란스럽게 무언가가 떨어져 깨지고 부서지는 소리가 난다.")
      sayw("/fb차기현/x", "뭐야! /fg강은지/x, 무사해?")
      printpara("차기현은 소리가 들린 쪽을 향해 외쳤다.",
        "요란한 소리가 난 쪽에서 높은 목소리로 대답이 돌아왔다.")
      sayw("/fg강은지/x", "네가 아까 말한 대로네, 선행정찰대는 뭘 한거야!",
        "쥐새끼만한 놈들이지만, 괴물이야!",
        "그 쪽에도 한두 마리 있으니까, 처리 좀 해 줘!")
      sayw("/fb차기현/x", "알겠어!")
      printpara("그렇게 말한 청년은 나를 보고 말한다.")
      sayw("/fb차기현/x", "상황은 알겠지? 내게서 떨어지지 않는 게 좋을 거야.",
        "…어쩌면…",
        "아냐. 일단 죽지 않는 걸 최우선으로 하라고.")
      automapper(d1)
      moveobject(d1, d, "d", true)
      d1.flags["H"] = true
    else
      sayw("/fb차기현/x", "미안하지만 돌아갈 수는 없어.",
        "동료가 위험해.")
      moveobject(d1, d, "d", true)
    end
  end

    d1["Ｓ"] = {dungeonobjecttype="start", placewidth=3, placeheight=19, linkto="", linkwhere=""}

    d1["Ａ"] = {dungeonobjecttype="steponevent", event=d1.A}
    d1.flags["A"] = false
    d1["Ｂ"] = {dungeonobjecttype="steponevent", event=d1.B}
    d1.flags["B"] = false
    d1["Ｚ"] = {dungeonobjecttype="steponevent", event=d1.BB}
    d1["Ｙ"] = {dungeonobjecttype="steponevent", event=d1.Y}
    d1["Ｘ"] = {dungeonobjecttype="blank"}
    d1["Ｃ"] = {dungeonobjecttype="steponevent", event=d1.C}
    d1.flags["C"] = false
    d1["Ｄ"] = {dungeonobjecttype="locked", key=false}
    d1["Ｅ"] = {dungeonobjecttype="steponevent", event=d1.E}
    d1.flags["E"] = false
    d1["Ｆ"] = {dungeonobjecttype="steponevent", event=d1.F}
    d1.flags["F"] = false
    d1["Ｇ"] = {dungeonobjecttype="steponevent", event=d1.G}
    d1.flags["G"] = false
    d1["Ｈ"] = {dungeonobjecttype="steponevent", event=d1.H}
    d1.flags["H"] = false
    d1["Ｉ"] = {dungeonobjecttype="enemy", group="twoimps", fleeable = false}
    d1["Ｊ"] = {dungeonobjecttype="enemy", group="threeimps", fleeable = false}
    d1["Ｋ"] = {dungeonobjecttype="steponevent", event=d1.K}
    d1.flags["K"] = false
    d1["Ｌ"] = {dungeonobjecttype="steponevent", event=d1.L}
    d1["Ｍ"] = {dungeonobjecttype="enemy", group="null"}
    d1["Ｎ"] = {dungeonobjecttype="chest", item="null"}
    d1["Ｏ"] = {dungeonobjecttype="chest", item="null"}
    d1["Ｐ"] = {dungeonobjecttype="door", item="null"}
    d1["Ｑ"] = {dungeonobjecttype="blank"}

    d1["一"] = {dungeonobjecttype="npc", icon="/fb人/x"}
    d1["二"] = {dungeonobjecttype="npc", icon="/fb차/x"}
    d1["三"] = {dungeonobjecttype="npc", icon="/fg강/x"}
    
  end

#end