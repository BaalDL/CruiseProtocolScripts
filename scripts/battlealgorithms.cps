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
    enemy.defensiveType = shallowcopy(EnemyTempletes[enemyT].defensiveType)
    enemy.defensiveFactor = shallowcopy(EnemyTempletes[enemyT].defensiveFactor)
    enemy.info = EnemyInfo[enemy.templetes]
    enemy.defenseinfo = EnemyDefenseInfo[enemy.templetes]
    enemy.playerCommand = function(self, party, enemyparty)
    end

    enemy.AICommand = EnemyTempletes[enemyT].AICommand
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
    local dicepool = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2}
    local result = dicepool[math.random(#dicepool)]
    local p = battle.party
    local e = battle.enemyparty
    if result == 1 then
      message = "적의 습격!"
      currentbattle.advantage = "enemy"
      for k, v in pairs(p) do
        p[k].turntime = p[k].turntime + math.random(5, 10)
      end
      sortcharacters(orderedCharacters)
    elseif result == 2 then
      message = "적을 습격했다!"
      currentbattle.advantage = "party"
      for k, v in pairs(e) do
        e[k].turntime = e[k].turntime + math.random(7, 15)
      end
      sortcharacters(orderedCharacters)
    else
      message = "적의 출현!"
    end
    draweachtime(message)
    printw( "" )
  end

  function battleeachturn(battle)
  	message = ""
  	local delay = 10
  	local usedskill
    progressturntime(orderedCharacters)
  	message = message .. orderedCharacters[1].name .. "의 턴입니다."
  	orderedCharacters[1].controllable = orderedCharacters[1].ally and orderedCharacters[1].alive --조작을 불가능케 하는 상태이상등에 대한 처리가 추가되어야 함. 
    if orderedCharacters[1].controllable then
  	  message = message .. "\n" .. "행동을 선택해 주십시오."
  	  orderedCharacters[1].playerCommand(orderedCharacters[1], party, enemyparty)
  	elseif orderedCharacters[1].ally then
  	  message = message .. "\n" .. orderedCharacters[1].name .. "(은)는 행동할 수 없다…."
  	elseif orderedCharacters[1].alive then
  	  usedskill = orderedCharacters[1].AICommand(orderedCharacters[1], party, emenyparty)
    else
      message = message .. "\n" .. orderedCharacters[1].name .. "(은)는 행동할 수 없다…."
  	end
  	draweachtime(message)
  	message = ""
  	if orderedCharacters[1].controllable then
  	  usedskill = askplayer(orderedCharacters[1], party, enemyparty, battle)
      if battle.fleed then
        return
      end
      if not usedskill then
        message = "아무 것도 하지 않았다."
  	    delay = math.floor((battleStopWatch / orderedCharacters[1].physicalSpeed) + math.random(15))
      else
        draweachtime(message)
  	    delay = math.floor((battleStopWatch / orderedCharacters[1][usedskill.DelayType]) + math.random(5))
      end
    elseif orderedCharacters[1].ally then
  	  delay = math.floor((battleStopWatch / orderedCharacters[1].physicalSpeed) + math.random(15))
    else
      if usedskill then
        delay = math.floor((battleStopWatch / orderedCharacters[1][usedskill.DelayType]) + math.random(5))
      else
        delay = math.floor((battleStopWatch / orderedCharacters[1].physicalSpeed) + math.random(15))
      end
  	end
  	printw ("엔터키를 눌러 계속합니다.\n")
  	
    
  	orderedCharacters[1].turntime = orderedCharacters[1].turntime + delay
  	sortcharacters(orderedCharacters)
  end

  function askplayer(char, party, enemyparty, battle)
    local startaskt, startaskl = getc()
    local playercommand, playersingletarget = false, singletarget
    local movelist = {"-1"}
    local moveliststring = ""
    local pc = 0
    local itemmove, fleemove
    while (not playercommand) do
      local targets
      itemmove = -2
      moveto(startaskt, startaskl)
  	  if char.attackType then
  	    table.insert(movelist, "0")
  	    moveliststring = moveliststring .. "[0] 공격(" .. attackType.toString(char.attackType) .. ")\n"
  	  end
  	  for i = 1, 8 do	
  	    if char.skills[i] and not (char.skills[i].MoveType == "Passive") then
  	      table.insert(movelist, tostring(i))
  	  	moveliststring = moveliststring .. "[" .. tostring(i) .. "] " .. char.skills[i].Name .. " (" 
          .. ResourceType.toString(char.skills[i].ResourceType) .. ": " .. char.skills[i].ResourceAmount .. ") "
  	    end
  	  end
      table.insert(movelist, "10")
      print(moveliststring .. "\n[10] 아이템 ")
      if battle.fleeable then
        table.insert(movelist, "99")
        print("[99] 도주 ")
      end
      printl("[-1] 대기(취소)")
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
          skillhandler(char, char.skills[pc], targets)
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
        fleemove = tonumber(confirmflee(char, party, enemyparty, battle))
        if (fleemove ~= 1) then
          battle.fleed = fleehandler(char,party, enemyparty, battle)
          if not battle.fleed then
            printl("도주에 실패했다!")
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

  function lookuptarget(type, target, selfnum)
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
      targets = skilltarget
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

    if skill.MoveType == "Attack" then  
      for k, v in pairs(targets) do
        if not checkavailable(char, skill, targets[k], battle) then break end
        inflictdamage(char, skill, targets[k], battle)
      end
    elseif skill.MoveType == "Heal" then
      for k, v in pairs(targets) do
        if not checkavailable(char, skill, targets[k], battle) then break end
        applyheal(char, skill, targets[k])
      end
  	end

  end

  function calculatedamage(actor, skill, target, battle)
    local damage = 0
    if skill.DamageCalculationType == "Basic" then
      damage = math.ceil(skill.AttackParameter * actor[skill.AttackerParameter] / target[skill.TargetParameter] * target.defensiveFactor[skill.AttackType] / 100)
    elseif skill.DamageCalculationType == "FixedUnderType" then
      damage = math.ceil(skill.FixedAmount * target.defensiveFactor[skill.AttackType] / 100)
    elseif skill.DamageCalculationType == "Fixed" then
      damage = math.ceil(skill.FixedAmount)
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
    elseif target.defensiveType[skill.AttackType] == "n" or (target.defensiveType[skill.AttackType] == "n" and reflected) then
      damage = 0
      message = message .. "\n" .. "그러나 " .. target.name .. "에게는 효과가 없었다!"
    elseif target.defensiveType[skill.AttackType] == "r" then
        damage = 0
        message = message .. "\n" .. "그러나 " .. target.name .. "(은)는 공격을 튕겨냈다!"
        inflictdamage(target, skill, actor, battle, true)
    end
    if not target.ally then
      EnemyDefenseInfo[target.templetes][skill.AttackType] = true
      for k, v in pairs(enemyparty) do
        enemyparty[k].defenseinfo = EnemyDefenseInfo[enemyparty[k].templetes]
      end
    end
  end

  function applyheal(actor, skill, target)
    local heal = 0
    if skill.FixedAmount then
      heal = skill.FixedAmount
      message = message .. "\n" .. target.name .. "의 체력이 " .. heal .. " 회복되었다!"
      target.currHP = math.min(target.maxHP, target.currHP + heal)
    end
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
    -- 여기에 온갖 상태이상 초기화 등등을 집어넣는다.
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

  function confirmflee(char, party, enemyparty, advantage)
    local selection
    local table = getfleetable(char, party, enemyparty, advantage)
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

  function fleehandler(char, party, enemyparty, battle)
    battle.fleetry = battle.fleetry + 1
    local result = pickrandomresult(getfleetable(char, party, enemyparty, battle))
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