#function locations
  
  LocationsList = {}
  VisitedLocationsList = {}

  LocationsList["CheonhoMarket"] = {
    Name = "천호시장",
    Type = "Town",
    RouteTo = {
      CheonhoStation = 2
    }
  }

  LocationsList["CheonhoStation"] = {
    Name = "천호역",
    Description = [[높고 낮은 건물과 지하차도가 복잡히 얽힌 사거리이다.
    기둥으로 판단하면, 두 개 지하철 노선이 마주치는 '천호' 역이 지하에 있는 듯하다.
    이 살벌한 지상도 지하보다는 안전한 곳이리라.]],
    Type = "Metro",
    MetroType = "Underground",
    RouteTo = {
      CheonhoMarket = 2,
      GangdonggucheongStation = 4
    }
  }

  LocationsList["GangdonggucheongStation"] = {
    Name = "강동구청역",
    Description = [[사람의 기척도 없이 낡아 해진 교차로의 이곳 저곳에 검은 사각형 기둥이 박혀 있다.
    '강동구청' 이라는 이름의 역이 여기 있었던 것 같다.
    바위와 가로수로 얼기설기 막아둔 입구 저 편은 악마들이 우글우글 하겠지.]],
    Type = "Metro",
    MetroType = "Underground",
    RouteTo = {
      CheonhoStation = 4,
      MongchontoseongStation = 6
    }

  }

  LocationsList["MongchontoseongStation"] = {
    Name = "몽촌토성역",
    Type = "Metro",
    MetroType = "Underground",
    RouteTo = {
      GangdonggucheongStation = 6
    }
  }

#end

#function passages
  PassagesList = {}

  PassagesList["RoadToArena"] = {
    Name = "경기장으로 가는 길",
    Locations = {"CheonhoStation", "GangdonggucheongStation"}
  }
#end

#function passageshelper
  for k, _ in pairs(PassagesList) do
    for _, v in ipairs(PassagesList[k].Locations) do
      if LocationsList[v] then
        if not LocationsList[v].IsInPassage then LocationsList[v].IsInPassage = {} end
        table.insert(LocationsList[v].IsInPassage, k)
      else
        printl("●● DEBUG: PassageList 항목의 Locations table의 값은 LocationList에 존재하는 key여야 합니다. 형식은 string입니다. 입력된 값: " .. v)
      end
    end
  end
#end