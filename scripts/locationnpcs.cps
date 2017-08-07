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
      world.NPC[k].flags = {}
    end
  end

  InitializeNpcs()

  function meetnpc(who)
    if (world.NPC[who].state <= 2 and meetnpcinitial(who)) or (world.NPC[who].state == 3) then
      startdialogue(who, "General")
      --printlw("DEBUG: 여기에 일반 대화 루틴으로 가는 내용을 구현해야 함")
    elseif world.NPC[who].state <= 2 then
      --printlw("DEBUG: 여기는 만나지 못했을 때의 처리")
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
  LocationNpcDialogueList = {}

  LocationNpcInitialsList["Doctor1"] = {}
  function LocationNpcInitialsList.Doctor1:Condition()
    return world.NPC["Doctor1"].state > 1
  end
  function LocationNpcInitialsList.Doctor1:Event()
    self.NpcName = LocationNpcsList["Doctor1"].Name
    local playername = player.Name
    sayw(self.NpcName, "자네가 " .. playername .. "인가?", "기다리고 있었네. 이리로 들어오게.")
    printlw("[TODO: 박사라는 인물에 대한 묘사]")
    world.NPC["Doctor1"].state = 3
  end
  function LocationNpcInitialsList.Doctor1:ConditionNotMet()
    printlw("아무도 없다…….")
  end

  LocationNpcDialogueList["Doctor1"] = {

    General = {
      initial = {
        category = "inquery",
        inqueryreferences = {},
        inquery = {
          initialquestion = "무슨 일로 왔나?",
          question = "그래, 다른 볼 일이 있는가?",
          references = {},
          [1] = {answer = "여쭙고 싶은 것이 있습니다."},
          [2] = {answer = "안녕히 계시길."},
        },
        nextkey = {
          [1] = 101,
          [2] = "terminal"
        },
      },
      [101] = {
        category = "subdialogue",
        subkey = "Explanation",
      },
    },

    Explanation = {
      initial = {
        category = "inquery",
        inqueryreferences = {},
        inquery = {
          question = "무엇이 알고 싶나?",
          references = {},
          [1] = {
            answer = "이 세계는 대체 무엇입니까?",
            onlyshow = function() return not world.NPC["Doctor1"].flags["whatisthisworld"] end,
            consequence = function() world.NPC["Doctor1"].flags["whatisthisworld"] = true end,
          },
          [2] = {
            answer = "이 세계에 대해 다시 말씀해 주십시오.",
            onlyshow = function() return world.NPC["Doctor1"].flags["whatisthisworld"] end,
          },
          [3] = {
            answer = "지금은 더 질문하지 않겠습니다.",
          }
        },
        nextkey = {101, 102, "terminal"},
      },
      [101] = {
        category = "monologue",
        nextkey = "initial",
      },
      [102] = {
        category = "empty",
        nextkey = 101,
      },
    },
  }

  LocationNpcDialogueList["Doctor1"]["Explanation"][101].scripts = {"이 '세계'라... 자네도 느꼈을 수 있겠지만, 이곳은 지리적으로는 자네가 알고 있을 서울특별시가 맞네.",
  "단지 자네가 생활하고 있었던 서울은 아니야.",
  "자네가 '원래 있었던' 서울은… 정확한 수치는 아마 다를 수도 있겠지만,",
  "주거 인구 약 천만 명. 자동차만 해도 삼백만 대가 넘는 거대 도시.",
  "하루에 소비되는 식량만 해도 보수적으로 잡아 삼천 톤에 달하는",
  "그야말로, 고립되어서는 단 하루도 버틸 수 없는 도시였을 걸세.",
  "하지만 이 세계는 우리가 발을 딛고 있는 이 도시를 제외한 모든 것이 존재하지 않는 세계일세.",
  "도시 경계 바깥으로는 그저 모든 것을 녹이는 안개가 이어질 뿐.",
  "그 정도가 내가 이 세계에 대해 알고, 말할 수 있는 것이네.",
  "이 세계의 근원이나, '원래' 세계와의 관계… 그런 것들은 내가 잘 모르는 것들이야.",
  "어쩌면 자네가, 내가 이 세계를 이해하는 걸 도와줄 수도 있겠지.",}

#end