#function locationnpcs
  
  execute("locationnpcevents")

  NpcGenericStateList = {[1] = "NoInfo", [2] = "NotMet", [3] = "Available", [4] = "NotAvailable"}

  LocationNpcsList = {}

  LocationNpcsList["Doctor1"] = {
    Name = "원은철 박사",
    Location = "CheonhoStation",
    Type = "TalkOnly",
    CommandToMeet = {[1] = "？？？？？？", [2] = "박사라는 사람의 연구소에 간다", [3] = "원은철 박사의 『연구소』에 간다", [4] = "원은철 박사의 『연구소』에 간다"},
    StateList = NpcGenericStateList,
    InitialState = 1,
  }

  function RegisterNpcsToLocations()
    for k, v in pairs(LocationNpcsList) do
      if not (LocationsList[v.Location].Npcs) then
        LocationsList[v.Location].Npcs = {}
      end
        table.insert(LocationsList[v.Location].Npcs, k)
    end
  end

  function InitializeNpcs()
    world.NPC = {}
    for k, v in pairs(LocationNpcsList) do
      world.NPC[k] = {}
      world.NPC[k].state = v.InitialState
    end
  end

  InitializeNpcs()

  function meetnpc(who)
    if (world.NPC[who].state <= 2 and meetnpcinitial(who)) or (world.NPC[who].state == 3) then
      printlw("DEBUG: 여기에 일반 대화 루틴으로 가는 내용을 구현해야 함")
    elseif world.NPC[who].state <= 2 then
      printlw("DEBUG: 여기는 만나지 못했을 때의 처리")
    elseif world.NPC[who].state == 4 then
      printlw("DEBUG: NPC가 만날 수 없을 상황일 때의 처리")
    end
  end

  function meetnpcinitial(who)
    local I = LocationNpcInitialsList[who]
    if I:Condition() then
      I:Event()
      world.NPC[who].state = 3
      return true
    else
      I:ConditionNotMet()
      printlw("DEBUG: 원은철 박사에 대한 정보 획득")
      world.NPC["Doctor1"].state = 2
      return false
    end
  end
#end

#function locationnpcevents
  LocationNpcEventsList = {}
  LocationNpcInitialsList = {}

  LocationNpcInitialsList["Doctor1"] = {}
  function LocationNpcInitialsList.Doctor1:Condition()
    return world.NPC["Doctor1"].state > 1
  end
  function LocationNpcInitialsList.Doctor1:Event()
    self.NpcName = LocationNpcsList["Doctor1"].Name
    local playername = player.Name
    sayw(self.NpcName, "자네가 " .. playername .. "인가?", "기다리고 있었네. 이리로 들어오게.")
    world.NPC["Doctor1"].state = 3
  end
  function LocationNpcInitialsList.Doctor1:ConditionNotMet()
    printlw("아무도 없다…….")
  end
#end