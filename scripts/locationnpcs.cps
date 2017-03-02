#function locationnpcs
  
  execute("locationnpcevents")

  LocationNpcsList = {}

  LocationNpcsList["Doctor1"] = {
    Name = "원은철 박사",
    Location = "CheonhoStation",
    Type = "TalkOnly",
    CommandToMeet = "원은철 박사의 『연구소』에 간다",
    CommandToMeetInitial = "박사의 연구소에 간다"
  }

  function RegisterNpcsToLocations()
    for k, v in pairs(LocationNpcsList) do
      if not (LocationsList[v.Location].Npcs) then
        LocationsList[v.Location].Npcs = {}
      end
        table.insert(LocationsList[v.Location].Npcs, k)
    end
  end

  function meetnpc(who)
    if not player.NPC.havemet[who] then
      local I = LocationNpcInitialsList[who]
      if I:Condition() then
        I:Event()
        player.NPC.havemet[who] = true
      else
        I:ConditionNotMet()
        printlw("DEBUG: 원은철 박사에 대한 정보 획득")
        player.NPC.info["Doctor1"] = true
      end
    end
    printlw("DEBUG: 여기에 대화 루틴으로 가는 내용을 구현해야 함")
  end
#end

#function locationnpcevents
  LocationNpcEventsList = {}
  LocationNpcInitialsList = {}

  LocationNpcInitialsList["Doctor1"] = {}
  function LocationNpcInitialsList.Doctor1:Condition()
    return player.NPC.info["Doctor1"]
  end
  function LocationNpcInitialsList.Doctor1:Event()
    self.NpcName = LocationNpcsList["Doctor1"].Name
    local playername = player.Name
    sayw(self.NpcName, "자네가 " .. playername .. "인가?", "기다리고 있었네. 이리로 들어오게.")
  end
  function LocationNpcInitialsList.Doctor1:ConditionNotMet()
    printlw("아무도 없다…….")
  end
#end