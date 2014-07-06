#function playmenu
  menuitems = {
  [1] = "파티",
  [2] = "상태",
  [3] = "스킬",
  [4] = "장비",
  [5] = "도구",
  [6] = "일지",
  [7] = "설정",
  [8] = "저장",
  [9] = "불러오기"
}
  menuactive = {}
  function activatesubmenu(...)
    for i = 1, arg.n do
      menuactive[i] = true
    end
  end

  function inactivatesubmenu(...)
    for i = 1, arg.n do
      menuactive[i] = false
    end
  end

  function dungeonmenu()
    campmenu()
  end

  function campmenu()
    local playerchoice
    while(playerchoice ~= "-1") do
      playerchoice = ask("조작할 메뉴를 선택해 주십시오", unpack(showavailablemenu()))
      if playerchoice == "1" then
        partymenu()
      elseif playerchoice == "2" then
        statusmenu()
      elseif playerchoice == "3" then
        skillmenu()
      elseif playerchoice == "4" then
        equipmenu()
      elseif playerchoice == "5" then
        inventorymenu("menu")
      elseif playerchoice == "6" then
        journalmenu()
      elseif playerchoice == "7" then
        optionmenu()
      elseif playerchoice == "8" then
        savemenu()
      elseif playerchoice == "9" then
        loadmenu()
      end
    end
  end

  function partymenu()

  end

  function statusmenu()
    local playerchoice
    while(playerchoice ~= "-1") do
      playerchoice = ask("파티 멤버를 선택해 주십시오", "-1")
    end
  end

  function skillmenu()
    local playerchoice
    while(playerchoice ~= "-1") do
      playerchoice = ask("사용할 스킬을 선택해 주십시오", "-1")
    end
  end

  function equipmenu()
    local playerchoice
    while(playerchoice ~= "-1") do
      playerchoice = ask("파티 멤버를 선택해 주십시오", "-1")
    end
  end

  function inventorymenu(type)
    local endmenu, stringitemlist, itemtable, useditem
    while(endmenu ~= "-1") do
      itemtable = {}
      stringitemlist = ""
      useditem = -1
      for k, v in pairs(inventory,nil) do
        if not (type == "battle") or ItemList[k].Battle then
          stringitemlist = stringitemlist .. "[" .. k .. "] " .. ItemList[k].Name .. " " .. inventory[k] .. "개 "
          table.insert(itemtable, tostring(k))
        end
      end
      printl (stringitemlist)
      printl ("[-1] 나가기")
      endmenu = ask("무엇을 하시겠습니까?", "-1", unpack(itemtable))
      if (endmenu ~= "-1") then
        printl ("[" .. endmenu .. "] " .. ItemList[tonumber(endmenu)].Name .. " 나머지 " .. inventory[tonumber(endmenu)] .. "개")
        useditem = ask("아이템을 사용하시겠습니까? [0] 예 [1] 아니오", "0", "1")
        if (useditem == "0") and (type == "battle") then
          return tonumber(endmenu)
        elseif (useditem == "0") then
          useitem(tonumber(endmenu))
        end
      end
      
    end
  end

  function journalmenu()
    
  end

  function optionmenu()

  end

  function savemenu()
    
  end

  function loadmenu()
    
  end

  function showavailablemenu()
    local moveliststring = ""
    local movelist = {}
    for k, v in ipairs(menuitems) do
      if menuactive[k] then
        moveliststring = moveliststring .. "[" .. k .. "] " .. v .. " "
        table.insert(movelist, tostring(k))
      end
    end
    moveliststring = moveliststring .. "[0] 메뉴 닫기"
    table.insert(movelist, "0")
    printl(moveliststring)
    return movelist
  end

  function showcurrentpartymembers(purpose)

  end

  function showallpartymembers(purpose)

  end
#end