#function locations
  
  LocationsList = {}
  VisitedLocationsList = {}

  LocationsList["CheonhoMarket"] = {
    Name = "천호시장",
    Type = "Town",
    Coordinate = {37.540992, 127.127802}
  }

  LocationsList["CheonhoStation"] = {
    Name = "천호역",
    Description = [[높고 낮은 건물과 지하차도가 복잡히 얽힌 사거리이다.
    기둥으로 판단하면, 두 개 지하철 노선이 마주치는 '천호' 역이 지하에 있는 듯하다.
    이 살벌한 지상도 지하보다는 안전한 곳이리라.]],
    Type = "Metro",
    MetroType = "Underground",
    Coordinate = {37.538629, 127.123432}
  }

  LocationsList["GangdonggucheongStation"] = {
    Name = "강동구청역",
    Description = [[사람의 기척도 없이 낡아 해진 교차로의 이곳 저곳에 검은 사각형 기둥이 박혀 있다.
    '강동구청' 이라는 이름의 역이 여기 있었던 것 같다.
    바위와 가로수로 얼기설기 막아둔 입구 저 편은 악마들이 우글우글 하겠지.]],
    Type = "Metro",
    MetroType = "Underground",
    Coordinate = {37.530710, 127.120628}
  }

  LocationsList["MongchontoseongStation"] = {
    Name = "몽촌토성역",
    Type = "Metro",
    MetroType = "Underground",
    Coordinate = {37.517529, 127.112733}
    }

  LocationsList["JamsilHighschool"] = {
    Name = "잠실고등학교",
    Type = "School",
    Coordinate = {37.522652, 127.106187}
  }

#end

#function passages
  PassagesList = {}

  PassagesList["RoadToArena"] = {
    Name = "경기장으로 가는 길",
    Locations = {"CheonhoStation", "MongchontoseongStation"}
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

  function calculatedistanceinmeter(coor1, coor2)
    if (type(coor1) ~= "table") or (type(coor2) ~= "table") then
      printl("●● DEBUG: calculatedistanceinmeter 함수의 인자로 table이 아닌 값이 입력되었습니다. 입력된 값: " .. coor1 .. ", " .. coor2)
      return -1
    elseif (type(coor1[1]) ~= "number") or (type(coor1[2]) ~= "number") or (type(coor2[1]) ~= "number") or (type(coor2[2]) ~= "number") then
      printl("●● DEBUG: calculatedistanceinmeter 함수의 인자 table에 number가 아닌 값이 입력되었습니다. 입력된 값: " .. coor1[1] .. ", " .. coor1[2] .. ", " .. coor2[1] .. ", " .. coor2[2])
      return -1
    end

    --http://stackoverflow.com/questions/639695/how-to-convert-latitude-or-longitude-to-meters
    local radius = 6378.137
    local d2r = math.pi / 180
    local sdLat = math.sin((coor2[1] - coor1[1]) * d2r / 2)
    local sdLon = math.sin((coor2[2] - coor1[2]) * d2r / 2)
    local a = sdLat * sdLat + math.cos(coor1[1] * d2r) * math.cos(coor2[1] * d2r) * sdLon * sdLon
    return math.ceil(2 * math.atan(math.sqrt(a)/math.sqrt(1-a)) * radius * 1000)
  end

  function makestrayablepolygon(startpoint, endpoint, type, astray)
    --startpoint \isin LocationsList, endpoint \isin LocationsList.
    --astray \isin [0, 1].
    --return value is a table with three or four coordinates. must be counter-clockwise order.
    --(type == 3) implies return value must be a triangle, in which first entry is startpoint's coordinate.
    --(type == 4) implies return value must be a diamond, in which first entry is startpoint's coordinate, third entry is endpoint's coordinate.
    --(type is neither 3 nor 4) just act as type == 3.

    local coordinates = {}
    coordinates[1] = {startpoint.Coordinate[1], startpoint.Coordinate[2]}
    local vector = {(startpoint.Coordinate[2] - endpoint.Coordinate[2])*astray/2, (endpoint.Coordinate[1] - startpoint.Coordinate[1])*astray/2}
    
    if (type == 4) then
      vector = {vector[1] / 2, vector[2] / 2}
      coordinates[3] = endpoint.Coordinate
      local midpoint = {(coordinates[1][1] + coordinates[3][1])/2, (coordinates[1][2] + coordinates[3][2])/2}
      coordinates[2] = {midpoint[1] + vector[1], midpoint[2] + vector[2]}
      coordinates[4] = {midpoint[1] - vector[1], midpoint[2] - vector[2]}
    else
      coordinates[2] = {endpoint.Coordinate[1] + vector[1], endpoint.Coordinate[2] + vector[2]}
      coordinates[3] = {endpoint.Coordinate[1] - vector[1], endpoint.Coordinate[2] - vector[2]}
    end
    return coordinates
  end

  function checklocationisinpolygon(location, polygon)
    --location must be a string, which is a key of LocationsList
    --polygon must be a return value of makestrayablepolygon
    --return value is true iff location coordinate is in the polygon

    local coordinate = LocationsList[location].Coordinate
    local length = #polygon
    polygon[length+1] = polygon[1]
    local edgeccw --vectors for polygon edges counter clockwise pi/4, to check the location is in the left side of the edges
    local vector
    local epsilon = 0.00000001
    for i=1,length do
      edgeccw = {polygon[i+1][2] - polygon[i][2], polygon[i][1] - polygon[i+1][1]}
      vector = {coordinate[1] - polygon[i][1], coordinate[2] - polygon[i][2]}
      if (edgeccw[1] * vector[1] + edgeccw[2] * vector[2] < 0) then
        return false
      end
    end
    return true
  end

  function strayablelocations(polygon, excludes, ifpassvisited)
    --polygon must be a return value of makestrayablepolygon
    --excludes must be a k-v pair of string-bool, which keys are of LocationsList. we do not check excludes location.(i.e., start or end point)
    --return value is a k-v pair of string-bool, which keys are of LocationsList.
    --if ifpassvisited is true, pass visited location(return value does not contains visited locations).

    local locations = {}
    for k, _ in pairs(LocationsList) do
      if (ifpassvisible and VisitedLocationsList[k]) then
      elseif (excludes[k]) then
      else
        local shallowpolygon = shallowcopy(polygon)
        if (checklocationisinpolygon(k, shallowpolygon)) then
          locations[k] = true
        end
      end
    end

    return locations
  end
#end