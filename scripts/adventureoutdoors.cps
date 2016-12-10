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

  function addknownlocation(location)
    if LocationsList[location] then
      KnownLocationsList[location] = true
    else
      printl("●● DEBUG: location은 LocationList에 존재하는 key여야 합니다. 형식은 string입니다. addknownlocation에 입력된 값: " .. location)
    end
  end

  function addvisitedlocation(location)
    if LocationsList[location] then
      VisitedLocationsList[location] = true
    else
      printl("●● DEBUG: location은 LocationList에 존재하는 key여야 합니다. 형식은 string입니다. addvisitedlocation에 입력된 값: " .. location)
    end
  end

  function depictcurrentlocation()
    local location = player.location
    printplace(LocationsList[location].Name)
  end

  function makemovelistinlocation()
    local movelist = {}
    local moveliststring = ""
    local location = player.location
    table.insert(movelist, "0")
    moveliststring = moveliststring .. "[0] 살펴보기"
    if LocationsList[location].IsInPassage then
      table.insert(movelist, "1")
      moveliststring = moveliststring .. " [1] 여정"
    end
    if checkvisitedneighbors(location) then
      table.insert(movelist, "2")
      moveliststring = moveliststring .. " [2] 직접 이동"
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
    local commands = {}
        enterlocation(arg[1])
    commands.move = "arrival"
    while(true) do
      commands = playercommand(departurecommand, player)
      if commands.move == "arrival" then
      elseif commands.move == "standstill" then
      elseif commands.move == "journey" then
        local startpoint = player.location
        local journey = getjourney(player, startpoint, commands.destination)
        enterlocation(commands.destination)
      elseif commands.move == "gameend" then
        printl ("게임을 종료합니다.")
        break
      end
    end
  end

  function makejourneylist()
    local journeylist = {}
    local additionallist = {}
    local journeyliststring = ""
    local location = player.location
    local counter = 1
    for k, v in pairs(KnownLocationsList) do
      if not VisitedLocationsList[k] then
        table.insert(journeylist, tostring(counter))
        table.insert(additionallist, k)
        journeyliststring = journeyliststring .. "[" .. tostring(counter) .. "] " .. LocationsList[k].Name .. " "
        counter = counter + 1
      end
    end
    printl(journeyliststring)
    table.insert(journeylist, "-1")
    printl("[-1] 대기(취소)")
    return journeylist, additionallist
  end

  departurecommand = {}
  departurecommand.references = {"player"}
  departurecommand.returns = {"move", "destination"}
  departurecommand.commands = {}
  departurecommand.resetpositiononinitial = true

  function departurecommand:initial()
    self.commands.move = "standstill"
    self.commands.destination = ""
    local movelist = makemovelistinlocation()
    local playercommand = ask("무엇을 하시겠습니까?", unpack(movelist))

    if (playercommand == "0") then
      printl(LocationsList[location].Description)
      return "initial"
    elseif (playercommand == "1") then
      return "journey"
    elseif (playercommand == "2") then
      return "goto" -- NEED IMPLEMENTATION
    elseif (playercommand == "3") then
      return "patrol" -- NEED IMPLEMENTATION
    elseif (playercommand == "99") then
      self.commands.move = "gameend"
      return "terminal"
    end
  end

  function departurecommand:journey()
    addknownlocation("MongchontoseongStation") -- DEBUG
    addknownlocation("JamsilHighschool") -- DEBUG
    local journeylist, additionallist = makejourneylist()
    local playercommand = ask("어디를 향하시겠습니까?", unpack(journeylist))
    if (playercommand == "-1") then
      return "initial"
    else
      self.commands.move = "journey"
      self.commands.destination = additionallist[tonumber(playercommand)]
      printl(LocationsList[self.commands.destination].Name .. "(으)로 떠납니다.")
      return "terminal"
    end
  end

  function departurecommand:goto()
    return "terminal"
  end

#end