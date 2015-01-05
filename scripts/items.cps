#function itemheader

  function useitem(touse)
    local itemdata = ItemList[touse]
    local targets
    printl(itemdata.Name .. "(을)를 사용했다!")
    if itemdata.ItemType == "Heal" then
      local target = itemtarget("Heal", "AnAlly")
      if (target == "100") then
        targets = enemyparty
      elseif (target == "10") then
        targets = party
      elseif (target ~= "-1") then
        targets = {targettable[target]}
      end
      itemhandler(char, touse, targets)
    end
    printl(message)
    message = ""
  end

  function itemtarget(type, target)
    local targets = {"-1"}
    local p = partyhandler(currentpartymembers)
    local e
    if currentbattle then
      p = currentbattle.party
      e = currentbattle.enemyparty
    end
    local selection

    if target == "AnEnemy" then
      for k, v in pairs(e) do
        if e[k].alive then table.insert(targets, tostring(e[k].targetnumber)) end
      end
      table.sort(targets)
      if type == "Attack" then
        selection = ask("누구를 공격합니까?", unpack(targets))
      elseif type == "Harass" then
        selection = ask("누구를 목표로 삼습니까?", unpack(targets))
      end
    elseif target == "WholeEnemy" or
      target == "RandomEnemies" or
      target == "PWREnemies" then
      selection = ask("적 전체를 목표로 삼습니까?", "-1", "100")
    elseif target == "AnAlly" then
      for k, v in pairs(p) do
        if p[k].alive then table.insert(targets, tostring(p[k].targetnumber)) end
      end
      table.sort(targets)
      if type == "Heal" or
        type == "Support" then
        selection = ask("누구를 목표로 삼습니까?", unpack(targets))
      end
    elseif target == "AnAllyIncludingDead" then
      for k, v in pairs(p) do
        table.insert(targets, tostring(p[k].targetnumber))
      end
      table.sort(targets)
      if type == "Heal" or
        type == "Support" then
        selection = ask("누구를 목표로 삼습니까?", unpack(targets))
      end
    elseif target == "WholeAlly" then
      selection = ask("아군 전체를 목표로 삼습니까?", "-1", "10")
    elseif target == "Self" then
      selection = ask("자기 자신을 목표로 삼습니까?", "-1", selfnum.toString)
    end

    return selection
  end

  function itemhandler(char, item, itemtarget)
    if not item then
      printl ("==NEED DEBUG== no item!")
      return
    end
    local itemdata = ItemList[item]
    if not message then message = "" end
    if char then
      message = message .. char.name .. "(은)는 " .. itemdata.Name .. "(을)를 사용했다!"
    else
      message = message .. itemdata.Name .. "(을)를 사용했다!"
    end
    if (itemdata.ItemType == "Heal") then
      for k, v in pairs(itemtarget) do
        applyheal(char, itemdata, itemtarget[k])
      end
    end
    inventory[item] = inventory[item] - 1
    if (inventory[item] == 0) then
      message = message .. "\n가지고 있던 " .. itemdata.Name .. "(을)를 모두 사용해 버렸다!"
    end
  end

#end

#function itemlist
  ItemList = {}

  ItemList[101] = {
    Name = "빨간약",
    ItemType = "Heal",
    Target = "AnAlly",
    Amount = 20,
    Battle = true
  }
  ItemList[102] = {
    Name = "연고",
    ItemType = "Heal",
    Target = "AnAlly",
    Amount = 50,
    Battle = true
  }
  ItemList[103] = {
    Name = "고급 연고",
    ItemType = "Heal",
    Target = "AnAlly",
    Amount = 100,
    Battle = true
  }
  ItemList[104] = {
    Name = "치유의 구슬",
    ItemType = "Heal",
    Target = "AnAlly",
    Amount = math.huge,
    Battle = true
  }
#end