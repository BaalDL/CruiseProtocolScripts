#function adventureoutdoors
  execute("locations")
  execute("passages")
  execute("adventureevents")
  execute("regions")
  execute("passageshelper")

  function enterlocation(location)
    addvisitedlocation(location)
    player.location = location
    depictcurrentlocation()
  end

  function addvisitedlocation(location)
    if LocationsList[location] then
      VisitedLocationsList[location] = true
    else
      printl("●● DEBUG: location은 LocationList에 존재하는 key여야 합니다. 형식은 string입니다. 입력된 값: " .. location)
    end
  end

  function depictcurrentlocation()
    local location = player.location
    printplace(LocationsList[location].Name)
  end

  function askplayerinlocation()
    local playercommand = false
    local movelist = {}
    local location = player.location
    movelist = makemovelistinlocation()
    playercommand = ask("무엇을 하시겠습니까?", unpack(movelist))
    if (playercommand == "0") then
      printl(LocationsList[location].Description)
      return "standstill"
    elseif (playercommand == "1") then

    elseif (playercommand == "2") then
      return "walkto", "CheonhoStation" -- NEED IMPLEMENTATION!!
    elseif (playercommand == "99") then
      return "gameend"
    end
  end

  function makemovelistinlocation()
    local movelist = {}
    local moveliststring = ""
    local movelistamount = ""
    local location = player.location
    table.insert(movelist, "0")
    moveliststring = moveliststring .. "[0] 살펴보기"
    if LocationsList[location].IsInPassage then
      table.insert(movelist, "1")
      moveliststring = moveliststring .. " [1] 경로 이동"
    end
    if checkvisitedneighbors(location) then
      table.insert(movelist, "2")
      moveliststring = moveliststring .. " [2] 인접 이동"
    end
    table.insert(movelist, "99")
    moveliststring = moveliststring .. " [99] 게임 종료"
    printl(moveliststring)
    return movelist
  end

  function checkvisitedneighbors(location)
    --[[
    for neighbor, _ in pairs(LocationsList[location].RouteTo) do
      if VisitedLocationsList[neighbor] then return true end
    end
    return false
    ]]--
    return true -- must implement algorithm to make neighbor dynamically <- is this possible?
  end

  function startgamebyenteringinitialposition(location)
    runadventureloop("initial", location)
  end

  function runadventureloop(initial, ...)
    local nextturn = initial
    while(true) do
      if nextturn == "initial" then
        enterlocation(arg[1])
        nextturn, target = askplayerinlocation()
      elseif nextturn == "standstill" then
        nextturn, target = askplayerinlocation()
      elseif nextturn == "walkto" then
        local startpoint = player.location
        local endpoint = "MongchontoseongStation" -- DEBUG
        local journey = getjourney(player, startpoint, endpoint)
        enterlocation(target)
        nextturn, target = askplayerinlocation()
      elseif nextturn == "gameend" then
        printl ("게임을 종료합니다.")
        break
      end
    end
  end
#end