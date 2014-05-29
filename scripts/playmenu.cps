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
    local playerchoice = ask("조작할 메뉴를 선택해 주십시오", unpack(showavailablemenu()))
    if playerchoice == "1" then

    elseif playerchoice == "2" then

    elseif playerchoice == "3" then

    elseif playerchoice == "4" then

    elseif playerchoice == "5" then

    elseif playerchoice == "6" then

    elseif playerchoice == "7" then

    elseif playerchoice == "8" then

    elseif playerchoice == "9" then

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