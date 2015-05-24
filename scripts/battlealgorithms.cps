#function battleheader

-- 전투 캐릭터용 템플릿 구조

  EnemyHandler = {}
  EnemyHandler.init = function(enemyT)
    local enemy = {}
    enemy.skills = {}
    enemy.templetes = enemyT
    enemy.name = EnemyTempletes[enemyT].name
    enemy.ally = false
    enemy.alive = true
    enemy.gender = EnemyTempletes[enemyT].genderTable[math.random( #EnemyTempletes[enemyT].genderTable )]
    local t = EnemyTempletes[enemyT].strengthTable
    local p = EnemyTempletes[enemyT].strengthPercent
    
    enemy.maxHP = math.floor(EnemyTempletes[enemyT].HPBase * (1 + p*t[ math.random (#t)]))
    enemy.currHP = enemy.maxHP
    enemy.maxResource = EnemyTempletes[enemyT].ResourceBase
    enemy.currResource = enemy.maxResource
    enemy.resourceType = EnemyTempletes[enemyT].ResourceType
    enemy.physicalAttack = math.floor(EnemyTempletes[enemyT].physicalAttack * (1 + p*t[ math.random (#t)]))
    enemy.physicalDefense = math.floor(EnemyTempletes[enemyT].physicalDefense * (1 + p*t[ math.random (#t)]))
    enemy.physicalSpeed = math.floor(EnemyTempletes[enemyT].physicalSpeed * (1 + p*t[ math.random (#t)]))
    enemy.specialAttack = math.floor(EnemyTempletes[enemyT].specialAttack * (1 + p*t[ math.random (#t)]))
    enemy.specialDefense = math.floor(EnemyTempletes[enemyT].specialDefense * (1 + p*t[ math.random (#t)]))
    enemy.specialSpeed = math.floor(EnemyTempletes[enemyT].specialSpeed * (1 + p*t[ math.random (#t)]))
    enemy.attackType = EnemyTempletes[enemyT].AttackType
    enemy.skills[0] = SkillList[enemy.attackType]
    for i = 1, 8 do
      enemy.skills[i] = EnemyTempletes[enemyT].skills[i]
    end
    enemy.maxSkillCharges = EnemyTempletes[enemyT].maxSkillCharges
    enemy.currSkillCharges = enemy.maxSkillCharges
    enemy.defensiveType = shallowcopy(EnemyTempletes[enemyT].defensiveType)
    enemy.defensiveFactor = shallowcopy(EnemyTempletes[enemyT].defensiveFactor)
    enemy.info = EnemyInfo[enemy.templetes]
    enemy.defenseinfo = EnemyDefenseInfo[enemy.templetes]
    enemy.playerCommand = function(self, party, enemyparty)
    end

    enemy.AICommand = EnemyTempletes[enemyT].AICommand
    enemy.currEphemerals = {}
    enemy.newEphemerals = {}
    return enemy
  end

  party = {}
  enemyparty = {}
  targettable = {}

  function initializebattle(battle)
    local p = battle.party
    local e = battle.enemyparty
    orderedCharacters = {}
    battleStopWatch = 200
    
    targettable["100"] = battle.enemyparty
    for k, v in pairs(p) do
      p[k].turntime = math.floor((battleStopWatch / p[k].physicalSpeed) + math.random(10))
  	  table.insert(orderedCharacters, p[k]) 
    end
    for k, v in pairs(e) do
      e[k].turntime = math.floor((battleStopWatch / e[k].physicalSpeed) + math.random(10))
  	  table.insert(orderedCharacters, e[k])
  	  e[k].targetnumber = 100 + k
  	  targettable[tostring(100+k)] = e[k]
    end
    sortcharacters(orderedCharacters)
  end

  function sortcharacters(X)
    table.sort(X, function(c1, c2)
      return c1.turntime < c2.turntime
    end)
    for k, v in pairs(X) do
      X[k].turnorder = k - 1
    end
  end

  function progressturntime(X)
    local x = X[1].turntime
    for k, v in pairs(X) do
      X[k].turntime = X[k].turntime - x
    end
  end

  function battlehandler(enemyparty, fleeable)
  	currentbattle = {}
  	currentbattle.party = party
    currentbattle.enemyparty = enemyparty
    currentbattle.fleeable = fleeable
    currentbattle.fleed = false
    currentbattle.fleetry = 0
    currentbattle.advantage = false
  	initializebattle(currentbattle)
  	battlefirstturn(currentbattle)
  	while (not (checkbattleend(currentbattle.party, currentbattle.enemyparty) or currentbattle.fleed)) do
  	  battleeachturn(currentbattle)
  	end
    local result = checkbattleend(currentbattle.party, currentbattle.enemyparty)
  	if result == "defeat" then
  	  printl ("전투에서 패배하였습니다.")
  	elseif result == "victory" then
  	  printl ("전투에서 승리하였습니다.")
    else
      printl ("전투에서 도망쳤습니다....")
  	end
    currentbattle = nil
    return result
  end

  function battlefirstturn(battle)
    local table = {16, 2, 2}
    local result = pickrandomresult(table)
    local p = battle.party
    local e = battle.enemyparty
    if result == 2 then
      message = "적의 습격!"
      currentbattle.advantage = "enemy"
      for k, v in pairs(p) do
        p[k].turntime = p[k].turntime + math.random(5, 10)
      end
      sortcharacters(orderedCharacters)
    elseif result == 3 then
      message = "적을 습격했다!"
      currentbattle.advantage = "party"
      for k, v in pairs(e) do
        e[k].turntime = e[k].turntime + math.random(7, 15)
      end
      sortcharacters(orderedCharacters)
    else
      message = "적의 출현!"
    end
    draweachtime(false, nil, message)
    printw( "" )
  end

  function battleeachturn(battle)
  	message = ""
  	local delay = 10
  	local usedskill
    progressturntime(orderedCharacters)
  	message = message .. orderedCharacters[1].name .. "의 턴입니다."
  	orderedCharacters[1].controllable = orderedCharacters[1].ally and orderedCharacters[1].alive and checkcontrollable(orderedCharacters[1]) 
    if orderedCharacters[1].controllable then
  	  message = message .. "\n" .. "행동을 선택해 주십시오."
  	  orderedCharacters[1].playerCommand(orderedCharacters[1], party, enemyparty)
      draweachtime(false, nil, message)
      message = ""
  	end
  	if orderedCharacters[1].controllable then
  	  usedskill = askplayer(orderedCharacters[1], party, enemyparty, battle)
      if battle.fleed then
        return
      end
      if not usedskill then
        message = "아무 것도 하지 않았다."
        countturn(orderedCharacters[1])
        draweachtime(true, orderedCharacters[1], message)
  	    delay = math.floor((battleStopWatch / getparam(orderedCharacters[1], "physicalSpeed")) + math.random(15))
      else
        countturn(orderedCharacters[1])
        draweachtime(true, orderedCharacters[1], message)
  	    delay = math.floor((battleStopWatch / getparam(orderedCharacters[1], usedskill.DelayType)) + math.random(5))
      end
    elseif orderedCharacters[1].ally then
      message = message .. "\n" .. orderedCharacters[1].name .. "(은)는 행동할 수 없다…."
      countturn(orderedCharacters[1])
      draweachtime(true, orderedCharacters[1], message)
  	  delay = math.floor((battleStopWatch / getparam(orderedCharacters[1], "physicalSpeed")) + math.random(15))
    elseif orderedCharacters[1].alive and checkcontrollable(orderedCharacters[1]) then
      usedskill = orderedCharacters[1].AICommand(orderedCharacters[1], party, emenyparty)
      draweachtime(true, orderedCharacters[1], message)
    else
      message = message .. "\n" .. orderedCharacters[1].name .. "(은)는 행동할 수 없다…."
      draweachtime(false, nil, message)
      if usedskill then
        countturn(orderedCharacters[1])
        delay = math.floor((battleStopWatch / getparam(orderedCharacters[1], usedskill.DelayType)) + math.random(5))
      else
        countturn(orderedCharacters[1])
        delay = math.floor((battleStopWatch / getparam(orderedCharacters[1], "physicalSpeed")) + math.random(15))
      end
  	end

    endofturn(orderedCharacters[1])

  	printw ("엔터키를 눌러 계속합니다.\n")
    
  	orderedCharacters[1].turntime = orderedCharacters[1].turntime + delay
  	sortcharacters(orderedCharacters)
  end

  function checkcontrollable(char)
    controllable = true
    for k, v in pairs(char.currEphemerals) do
      if ephemerallist[k][v[1]].atcheckcontrollable then
        controllable = ephemerallist[k][v[1]].atcheckcontrollable(char, currentbattle)
        if not controllable then return false end
      end
    end
    return true
  end

  function askplayer(char, party, enemyparty, battle)
    local startaskt, startaskl = getc()
    local playercommand, playersingletarget = false, singletarget
    local movelist = {}
    local pc = 0
    local itemmove, fleemove

    while (not playercommand) do
      local targets
      itemmove = -2
      moveto(startaskt, startaskl)
      movelist = makemovelist(char, party, enemyparty, battle)
      playercommand = ask("무엇을 하시겠습니까?", unpack(movelist))
  	  pc = tonumber(playercommand)
    
      if (pc <= 8 and pc >= 0) then
  	    playertarget = lookuptarget(char.skills[pc].MoveType, char.skills[pc].Target, char.targetnumber)
  	    
        if (playertarget ~= "-1") then
          if (playertarget == "100") then
            targets = enemyparty
          elseif (playertarget == "10") then
            targets = party
          else
            targets = {targettable[playertarget]}
          end
          skillhandler(char, char.skills[pc], targets, battle)
        end
      elseif (pc == 10) then
        itemmove = inventorymenu("battle")
        if (itemmove ~= -1) then
          playertarget = itemtarget(ItemList[itemmove].ItemType, ItemList[itemmove].Target, char.targetnumber)
          if (playertarget ~= "-1") then
            if (playertarget == "100") then
              targets = enemyparty
            elseif (playertarget == "10") then
              targets = party
            else
              targets = {targettable[playertarget]}
            end
            itemhandler(char, itemmove, targets, battle)
          end
        end
      elseif (pc == 99) then
        local fleetable = getfleetable(char, party, enemyparty, battle)
        fleemove = tonumber(confirmflee(fleetable))
        if (fleemove ~= 1) then
          battle.fleed = fleehandler(battle, fleetable)
          if not battle.fleed then
            message = message .. "도주에 실패했다!"
          end
        end
  	  end
      if (playertarget == "-1") or (itemmove == -1) or (fleemove == 1) then
        playercommand, playersingletarget = false, singletarget
        movelist = {"-1"}
        moveliststring = ""
        local endaskt = getc()
        erase(startaskt, endaskt)
      end
    end
    if (pc == -1) then
      return nil
    elseif (pc <= 8 and pc >= 0) then
      return char.skills[pc]
    elseif pc == 10 then
      return SkillList["UseItem"]
    elseif pc == 99 then
      return SkillList["Flee"]
    end
    return -1
  end

  function makemovelist(char, party, enemyparty, battle)
    local movelist = {}
    local moveliststring = ""
    local movelistamount = ""    
    if char.attackType then
      table.insert(movelist, "0")
      moveliststring = moveliststring .. "[0] 공격(" .. attackType.toString(char.attackType) .. ")\n"
    end
    for i = 1, 8 do
      if char.skills[i] and not (char.skills[i].MoveType == "Passive") then
        moveliststring = moveliststring .. "[" .. tostring(i) .. "] " .. char.skills[i].Name .. " (" 
          .. ResourceType.toString(char.skills[i].ResourceType) .. ": "
        if (char.ResourceType == char.skills[i].ResourceType) and (char.currResource >= char.skills[i].ResourceAmount) then
          table.insert(movelist, tostring(i))
          movelistamount = tostring(char.skills[i].ResourceAmount)
        elseif (char.skills[i].ResourceType == "Mana") and (char.currEphemerals["manadepletion"]) then
          movelistamount = "/fR" .. char.skills[i].ResourceAmount .. "/x"
        elseif (char.skills[i].ResourceType == "Charge" and char.skillCharges[i] > 0) then
          table.insert(movelist, tostring(i))
          movelistamount = tostring(char.skillsCharges[i])
        else
          table.insert(movelist, tostring(i))
          movelistamount = "/fy" .. char.skills[i].ResourceAmount .. "/x"
        end
        moveliststring = moveliststring .. movelistamount .. ") "
      end
    end
    table.insert(movelist, "10")
    _print(moveliststring .. "\n[10] 아이템 ")
    if battle.fleeable then
      table.insert(movelist, "99")
      _print("[99] 도주 ")
    end
    table.insert(movelist, "-1")
    printl("[-1] 대기(취소)")
    return movelist
  end

  function lookuptarget(type, target, selfnum)
    local targets = {"-1"}
    local p = currentbattle.party
    local e = currentbattle.enemyparty
    local selection

    if target == "AnEnemy" or
      target == "AdjacentEnemies" then
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
    elseif target == "WholeAllyIncludingDead" then
      selection = ask("아군 전체를 목표로 삼습니까?", "-1", "10")
    elseif target == "Self" then
      selection = ask("자기 자신을 목표로 삼습니까?", "-1", selfnum.toString)
    end

    return selection
  end

  function skillhandler(char, skill, skilltarget)
    message = message .. "\n" .. char.name .. "의 " .. skill.Name .. "!"
    local opponents = enemyparty
    local samesides = party
    if not char.ally then
      opponents = party
      samesides = enemyparty
    end
    local targets = {}
    if skill.Target == "AnEnemy" or
    skill.Target == "Self" or
    skill.Target == "AnAlly" or
    skill.Target == "AnAllyIncludingDead" or
    skill.Target == "WholeAllyIncludingDead" then
      if not skill.minTarget then
        targets = skilltarget
      else
        local numTarget = math.random(skill.minTarget, skill.maxTarget)
        for k, _ in pairs(skilltarget) do
          for i = 1, numTarget do
            table.insert(targets, skilltarget[k])
          end
        end
      end
    elseif skill.Target == "AdjacentEnemies" then
      targets = skilltarget
      local adjacentTargets = {}
      for k, _ in pairs(skilltarget) do
        local n = skilltarget[k].targetnumber
        if n-1 >= 101 and targettable[tostring(n-1)] and targettable[tostring(n-1)].alive then
          table.insert(adjacentTargets, tostring(n-1))
        end
        if n+1 <= 105 and targettable[tostring(n+1)] and targettable[tostring(n+1)].alive then
          table.insert(adjacentTargets, tostring(n+1))
        end
      end
      for _, v in pairs(adjacentTargets) do
        table.insert(targets, targettable[v])
      end
    elseif skill.Target == "AdjacentAllies" then
      targets = skilltarget
      local adjacentTargets = {}
      for k, _ in pairs(skilltarget) do
        local n = skilltarget[k].targetnumber
        print (n)
        if n-1 >= 11 and targettable[tostring(n-1)] and targettable[tostring(n-1)].alive then
          table.insert(adjacentTargets, tostring(n-1))
        end
        if n+1 <= 15 and targettable[tostring(n+1)] and targettable[tostring(n+1)].alive then
          table.insert(adjacentTargets, tostring(n+1))
        end
      end
      for _, v in pairs(adjacentTargets) do
        table.insert(targets, targettable[v])
      end
    elseif skill.Target == "WholeEnemy" or skill.Target == "WholeAlly" then
      for k, v in pairs(skilltarget) do
        if skilltarget[k].alive then table.insert(targets, skilltarget[k]) end
      end
    elseif skill.Target == "RandomEnemies" then
      local numTarget = math.random(skill.minTarget, skill.maxTarget)
      for k, v in pairs(pickrandomtarget(opponents, numTarget)) do
        table.insert(targets, v)
      end
    elseif skill.Target == "RandomAllies" then
      local numTarget = math.random(skill.minTarget, skill.maxTarget)
      for k, v in pairs(pickrandomtarget(samesides, numTarget)) do
        table.insert(targets, v)
      end    
    elseif skill.Target == "PWREnemies" then
      local numTarget = math.random(skill.minTarget, skill.maxTarget)
      local first, second = unpack(pickrandomtarget(opponents, 2))
      second = second or first
      table.insert(targets, first)
      table.insert(targets, second)
      for i = 3, numTarget do
        if i <= numTarget then table.insert(targets, unpack(pickrandomtarget(opponents, 1))) end
      end
    elseif skill.Target == "PWRAllies" then
      local numTarget = math.random(skill.minTarget, skill.maxTarget)
      local first, second = unpack(pickrandomtarget(samesides, 2))
      second = second or first
      table.insert(targets, first)
      table.insert(targets, second)
      for i = 3, numTarget do
        if i <= numTarget then table.insert(targets, unpack(pickrandomtarget(samesides, 1))) end
      end
    end

    if skill.ResourceAmount then
      costresource(char, skill)
    end

    if skill.MoveType == "Attack" then  
      for k, v in pairs(targets) do
        if not checkavailable(char, skill, targets[k], battle) then break end
        if checkhit(char, skill, targets[k], battle) then
          inflictdamage(char, skill, targets[k], battle)
          if skill.ApplyEphemeral then applyephemeral(char, skill, targets[k], battle) end
        else
          message = message .. "\n하지만 " .. targets[k].name .. "에게는 맞지 않았다!"
        end
      end
    elseif skill.MoveType == "Harass" then
      for k, v in pairs(targets) do
        if not checkavailable(char, skill, targets[k], battle) then break end
        if checkhit(char, skill, targets[k], battle) then
          applyephemeral(char, skill, targets[k], battle)
        else
          message = message .. "\n하지만 " .. targets[k].name .. "에게는 맞지 않았다!"
        end
      end
    elseif skill.MoveType == "Heal" then
      for k, v in pairs(targets) do
        if not checkavailable(char, skill, targets[k], battle) then break end
        applyheal(char, skill, targets[k])
      end
  	end

  end
  
  function checkhit(char, skill, target, battle)
    if not skill.Accuracy then return true end
    local random = math.random() * 100
    local mult = 1
    for k, v in pairs(char.currEphemerals) do
      if ephemerallist[k][v[1]].atcheckhit and "Accuracy" == ephemerallist[k][v[1]].atcheckhit.param then
        mult = mult * ephemerallist[k][v[1]].atcheckhit.amount
      end
    end
    for k, v in pairs(target.currEphemerals) do
      if ephemerallist[k][v[1]].atcheckhit and "Evasion" == ephemerallist[k][v[1]].atcheckhit.param then
        mult = mult * ephemerallist[k][v[1]].atcheckhit.amount
      end
    end
    return random < skill.Accuracy * mult
  end

  function costresource(char, skill)
    local afteramount
    afteramount = char.currResource - skill.ResourceAmount
    if (skill.ResourceType == "Charge") then
      local ok = false
      for k, v in char.skills do
        if (v == skill) and not ok then
          char.currSkillCharges[k] = char.currSkillCharges[k] - 1
          ok = true
        end
      end
    elseif (char.ResourceType == skill.ResourceType) and (afteramount >= 0) then
      char.currResource = afteramount
    elseif ((char.ResourceType == skill.ResourceType) and (afteramount < 0)) or (char.ResourceType ~= skill.ResourceType) then
      if char.ResourceType == skill.ResourceType then
        char.currResource = 0
      else 
        afteramount = -skill.ResourceAmount
      end
      if (skill.ResourceType == "Mana") then
        local depletionturn = math.floor((-2 * afteramount) / skill.ResourceAmount) + 1
        applyephemeral("", SkillList["SystemManaDepletion"], char, depletionturn)
        message = message .. "\n무리하게 마나를 끌어 써 " .. char.name .. " 주변의 마나가 시든다!\n" .. depletionturn .. "턴 동안 마나 사용 불가!"
      elseif (skill.ResourceType == "Ki") then
        char.turntime = -afteramount
        message = message .. "\n기력이 모자라 행동이 지체된다!"
      elseif (skill.ResourceType == "Rage") then
        local hpdamage = math.ceil(-char.maxHP * afteramount / 100)
        char.currHP = math.max(char.currHP - hpdamage, 1)
        message = message .. "\n분노의 영향으로 HP가 소모된다!\n" .. char.name .. "에게 " .. hpdamage .."의 데미지!"
      end
    end   
  end

  function getparam(char, param)
    local mult = 1
    for k, v in pairs(char.currEphemerals) do
      if ephemerallist[k][v[1]].atgetparam and param == ephemerallist[k][v[1]].atgetparam.param then
        mult = mult * ephemerallist[k][v[1]].atgetparam.amount
      end
    end
    return char[param] * mult
  end

  function calculatedamage(actor, skill, target, battle)
    local damage = 0
    if skill.DamageCalculationType == "Basic" then
      damage = math.ceil(skill.AttackParameter * getparam(actor, skill.AttackerParameter) / getparam(target, skill.TargetParameter) * target.defensiveFactor[skill.AttackType] / 100)
    elseif skill.DamageCalculationType == "FixedUnderType" then
      damage = math.ceil(skill.FixedAmount * target.defensiveFactor[skill.AttackType] / 100)
    elseif skill.DamageCalculationType == "Fixed" then
      damage = math.ceil(skill.FixedAmount)
    elseif skill.DamageCalculationType == "TargetMaxHPPercentageUnderType" then
      damage = math.ceil(target.maxHP * skill.Percentage / 100 * target.defensiveFactor[skill.AttackType] / 100)
    end
    return damage
  end

  function inflictdamage(actor, skill, target, battle, reflected)
    local damage
    if target.defensiveType[skill.AttackType] == "s" then
      damage = calculatedamage(actor, skill, target, battle)
      message = message .. "\n" .. target.name .. "에게 " .. damage .. "의 데미지!"
      if target.currHP - damage > 0 then
        target.currHP = target.currHP - damage
      else
        characterdie(actor, skill, target, battle)
      end
    elseif target.defensiveType[skill.AttackType] == "n" or (target.defensiveType[skill.AttackType] == "r" and reflected) or (target.defensiveType[skill.AttackType] == "r" and not actor) then
      damage = 0
      message = message .. "\n" .. "그러나 " .. target.name .. "에게는 효과가 없었다!"
    elseif target.defensiveType[skill.AttackType] == "r" and actor then
      damage = 0
      message = message .. "\n" .. "그러나 " .. target.name .. "(은)는 공격을 튕겨냈다!"
      inflictdamage(target, skill, actor, battle, true)
    elseif target.defensiveType[skill.AttackType] == "a" then
      damage = calculatedamage(actor, skill, target, battle)
      printl(damage .. "아헤가오")
      message = message .. "\n" .. "그러나 " .. target.name .. "(은)는 공격을 흡수했다!"
      applyheal(actor, SkillList["SystemAbsorbHeal"], target, damage)
    end
    if not target.ally then
      EnemyDefenseInfo[target.templetes][skill.AttackType] = true
      for k, v in pairs(enemyparty) do
        enemyparty[k].defenseinfo = EnemyDefenseInfo[enemyparty[k].templetes]
      end
    end
  end

  function applyheal(actor, skill, target, ...)
    local heal = 0
    if skill.HealByArgument then
      heal = arg[1]
      message = message .. "\n" .. target.name .. "의 체력이 " .. heal .. " 회복되었다!"
      target.currHP = math.min(target.maxHP, target.currHP + heal)
    elseif skill.FixedAmount then
      heal = skill.FixedAmount
      message = message .. "\n" .. target.name .. "의 체력이 " .. heal .. " 회복되었다!"
      target.currHP = math.min(target.maxHP, target.currHP + heal)
    end
  end

  function applyephemeral(actor, skill, target, ...)
    for k, v in pairs(skill.ApplyEphemeral) do
      if v == "manadepletion" then
        target.currEphemerals["manadepletion"] = {1, arg[1]}
        target.newEphemerals["manadepletion"] = true
      else
        local ae = applyephemerallist[v]
        if checkephemeral(actor, ae, target, skill) then
          target.currEphemerals[ae.ephemeral] = {ae.rank, math.random(ae.minDuration, ae.maxDuration)}
          target.newEphemerals[ae.ephemeral] = true
          message = message .. "\n" .. ephemerallist[ae.ephemeral][ae.rank].acquireMessage(target)
        end
      end
    end
  end

  function checkephemeral(actor, applyephemeral, target, skill)
    if target.defensiveType[skill.AttackType] == "n" or target.defensiveType[skill.AttackType] == "r" then
      message = message .. "\n" .. target.name .. "(은)는 " .. attackType.toString(skill.AttackType) .. "에 저항하여 " .. ephemerallist[applyephemeral.ephemeral][applyephemeral.rank].name .. "의 영향을 받지 않는다!"
      return false
    end
    local p = applyephemeral.Probability or math.huge
    local random = math.random()
    local mult = target.defensiveFactor[skill.AttackType]
    return random * mult < p
  end

  function checkavailable(actor, skill, target, battle)
    if not target.alive and skill.MoveType == "Attack" then
      message = message .. "\n" .. target.name .. "(은)는 이미 전투불능이다!"
      return false
    elseif not target.alive and skill.Target ~= "AnAllyIncludingDead" and skill.Target ~= "WholeAllyIncludingDead" then
      message = message .. "\n" .. target.name .. "(은)는 전투불능이다!"
      return false
    end
    return true
  end

  function characterdie(actor, skill, target, battle)
    target.currHP = 0
    target.alive = false
    target.status = "전투불능"
    if orderedCharacters[target.turnorder] then table.remove(orderedCharacters[target.turnorder]) end
    target.currEphemerals = {}
    message = message .. "\n" .. target.name .. "(은)는 전투 불능이 되었다!" 
    if not target.ally then
      EnemyInfo[target.templetes] = true
      for k, v in pairs(enemyparty) do
        enemyparty[k].info = EnemyInfo[enemyparty[k].templetes]
      end
    end
  end

  function pickrandomtarget(party, amount, battle)
    local alivelist = {} 
    for k, _ in pairs(party) do
      if party[k].alive then
  	    table.insert(alivelist,party[k])
  	  end
    end
    if next(alivelist) == nil then
    message = message .. "\n그러나 공격할 수 있는 대상이 없다!"
      return false
    end
    local targetlist = combo(alivelist, math.min(amount, #alivelist))
    return targetlist[math.random(#targetlist)]
  end

  function countturn(char)
    for k, v in pairs(char.currEphemerals) do
      if ephemerallist[k][v[1]].atcountturn then
        ephemerallist[k][v[1]].atcountturn(char, currentbattle)
      end
      if char.currEphemerals[k][2] > 1 then
        if not char.newEphemerals[k] then
          char.currEphemerals[k][2] = char.currEphemerals[k][2] - 1
        end
      elseif char.currEphemerals[k][2] == 1 then
        char.currEphemerals[k][2] = 0
        message = message .. "\n" .. ephemerallist[k][v[1]].diminishMessage(char)
      end
    end
  end

  function endofturn(char)
    for k, v in pairs(char.currEphemerals) do
      if char.newEphemerals[k] then
        char.newEphemerals[k] = nil
      end
      if char.currEphemerals[k][2] == 0 then
        char.currEphemerals[k] = nil
      end
    end
  end

  function confirmflee(table)
    local selection
    local percentage = math.ceil(table[1] / (table[1]+table[2]) * 100)
    selection = ask("전투를 포기하고 도주하겠습니까? (성공확률:" .. percentage .. "%) [0] 예 [1] 아니오", "0", "1")
    return selection
  end

  function getfleetable(char, party, enemyparty, battle)
    local fleetable = {(4+battle.fleetry)*char.physicalSpeed, 0}
    for _, v in pairs(party) do
      fleetable[1] = fleetable[1] + math.floor((v.physicalSpeed)/2)
    end
    for _, v in pairs(enemyparty) do
      fleetable[2] = fleetable[2] + v.physicalSpeed
    end
    if (fleetable[1] <= 0) then fleetable[1] = 1 end
    if (fleetable[2] <= 0) then fleetable[2] = 0 end

    if battle.advantage == "player" then
      fleetable[2] = 0
    elseif battle.advantage == "enemy" then
      fleetable[1] = math.floor(fleetable[1] / 2)
      fleetable[2] = fleetable[2] * 2
    end
    return fleetable
  end

  function fleehandler(battle, table)
    battle.fleetry = battle.fleetry + 1
    local result = pickrandomresult(table)
    if result == 1 then
      return true
    else
      return false
    end
  end

  function checkbattleend(party, enemyparty)
    local partyeliminated, enemypartyeliminated = true, true
    for k, _ in pairs(party) do
      if party[k].alive then
  	  partyeliminated = false
        break
  	end
    end
    if partyeliminated then return "defeat" end
    for k, _ in pairs(enemyparty) do
      if enemyparty and enemyparty[k].alive then
  	  enemypartyeliminated = false
        break
  	end
    end
    if enemypartyeliminated then return "victory" end
    return false
  end
#end