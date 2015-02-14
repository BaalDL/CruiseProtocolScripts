#function itemheader

  function useitem(touse)
    local itemdata = ItemList[touse]
    local targets
    local target = itemtarget(itemdata.ItemType, itemdata.Target)
    if (target ~= "-1") then
      if (target == "100") then
        targets = enemyparty
      elseif (target == "10") then
        targets = party
      else
        targets = {targettable[target]}
      end
      itemhandler(char, touse, targets)
    end
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
      if type == "Attack" or type == "Harass" then
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

  function itemhandler(char, item, itemtarget, battle)
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
    elseif (itemdata.ItemType == "Support") then
    elseif (itemdata.ItemType == "Attack") then
      for k, v in pairs(itemtarget) do
        inflictdamage(char, itemdata, itemtarget[k], battle)
      end
    elseif (itemdata.ItemType == "Harass") then
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
    FixedAmount = 20,
  }
  ItemList[102] = {
    Name = "연고",
    ItemType = "Heal",
    Target = "AnAlly",
    FixedAmount = 50,
  }
  ItemList[103] = {
    Name = "고급 연고",
    ItemType = "Heal",
    Target = "AnAlly",
    FixedAmount = 100,
  }
  ItemList[104] = {
    Name = "치유의 구슬",
    ItemType = "Heal",
    Target = "AnAlly",
    FixedAmount = math.huge,
  }
  ItemList[201] = {
    Name = "명멸하는 칼날",
    ItemType = "Attack",
    Target = "AnEnemy",
    DamageCalculationType = "FixedUnderType",
    FixedAmount = 50,
    AttackType = "Slash",
    BattleOnly = true
  }
  ItemList[202] = {
    Name = "명멸하는 주먹",
    ItemType = "Attack",
    Target = "AnEnemy",
    DamageCalculationType = "FixedUnderType",
    FixedAmount = 50,
    AttackType = "Strike",
    BattleOnly = true
  }
  ItemList[203] = {
    Name = "명멸하는 바늘",
    ItemType = "Attack",
    Target = "AnEnemy",
    DamageCalculationType = "FixedUnderType",
    FixedAmount = 50,
    AttackType = "Pierce",
    BattleOnly = true
  }
  ItemList[204] = {
    Name = "명멸하는 엄니",
    ItemType = "Attack",
    Target = "AnEnemy",
    DamageCalculationType = "FixedUnderType",
    FixedAmount = 50,
    AttackType = "Bite",
    BattleOnly = true
  }
  ItemList[205] = {
    Name = "명멸하는 화살",
    ItemType = "Attack",
    Target = "AnEnemy",
    DamageCalculationType = "FixedUnderType",
    FixedAmount = 50,
    AttackType = "Bullet",
    BattleOnly = true
  }
  ItemList[206] = {
    Name = "명멸하는 톱날",
    ItemType = "Attack",
    Target = "AnEnemy",
    DamageCalculationType = "FixedUnderType",
    FixedAmount = 50,
    AttackType = "Throwing",
    BattleOnly = true
  }
  ItemList[207] = {
    Name = "명멸하는 음파",
    ItemType = "Attack",
    Target = "AnEnemy",
    DamageCalculationType = "FixedUnderType",
    FixedAmount = 50,
    AttackType = "Burst",
    BattleOnly = true
  }
  ItemList[208] = {
    Name = "명멸하는 불꽃",
    ItemType = "Attack",
    Target = "AnEnemy",
    DamageCalculationType = "FixedUnderType",
    FixedAmount = 50,
    AttackType = "Fire",
    BattleOnly = true
  }
  ItemList[209] = {
    Name = "명멸하는 물결",
    ItemType = "Attack",
    Target = "AnEnemy",
    DamageCalculationType = "FixedUnderType",
    FixedAmount = 50,
    AttackType = "Water",
    BattleOnly = true
  }
  ItemList[210] = {
    Name = "명멸하는 한기",
    ItemType = "Attack",
    Target = "AnEnemy",
    DamageCalculationType = "FixedUnderType",
    FixedAmount = 50,
    AttackType = "Ice",
    BattleOnly = true
  }
  ItemList[211] = {
    Name = "명멸하는 생명",
    ItemType = "Attack",
    Target = "AnEnemy",
    DamageCalculationType = "FixedUnderType",
    FixedAmount = 50,
    AttackType = "Grass",
    BattleOnly = true
  }
  ItemList[212] = {
    Name = "명멸하는 바람",
    ItemType = "Attack",
    Target = "AnEnemy",
    DamageCalculationType = "FixedUnderType",
    FixedAmount = 50,
    AttackType = "Wind",
    BattleOnly = true
  }
  ItemList[213] = {
    Name = "명멸하는 전하",
    ItemType = "Attack",
    Target = "AnEnemy",
    DamageCalculationType = "FixedUnderType",
    FixedAmount = 50,
    AttackType = "Electric",
    BattleOnly = true
  }
  ItemList[214] = {
    Name = "명멸하는 대지",
    ItemType = "Attack",
    Target = "AnEnemy",
    DamageCalculationType = "FixedUnderType",
    FixedAmount = 50,
    AttackType = "Ground",
    BattleOnly = true
  }
  ItemList[215] = {
    Name = "명멸하는 광채",
    ItemType = "Attack",
    Target = "AnEnemy",
    DamageCalculationType = "FixedUnderType",
    FixedAmount = 50,
    AttackType = "Luminous",
    BattleOnly = true
  }
  ItemList[216] = {
    Name = "명멸하는 칠흑",
    ItemType = "Attack",
    Target = "AnEnemy",
    DamageCalculationType = "FixedUnderType",
    FixedAmount = 50,
    AttackType = "Dark",
    BattleOnly = true
  }
#end