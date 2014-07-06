#function itemheader
  execute("itemlist")

  function useitem(touse)
    local itemdata = ItemList[touse]
    if itemdata.ItemType == "Heal" then
      local target = lookuptarget("Heal", party)
    end
  end

  function itemtarget(type, target)
  local targets = {"-1"}
  local p = currentbattle.party
  local e = currentbattle.enemyparty
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
      if p[k].alive then table.insert(targets, tostring(e[k].targetnumber)) end
    end
    table.sort(targets)
    if type == "Heal" or
      type == "Support" then
      selection = ask("누구를 목표로 삼습니까?", unpack(targets))
    end
  elseif target == "AnAllyIncludingDead" then
    for k, v in pairs(p) do
      table.insert(targets, tostring(e[k].targetnumber))
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