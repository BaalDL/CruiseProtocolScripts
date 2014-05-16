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
  enemy.info = EnemyInfo[enemy.templetes]
  
  enemy.playerCommand = function(self, party, enemyparty)
  end

  enemy.AICommand = EnemyTempletes[enemyT].AICommand
  return enemy
end

party = {}
enemyparty = {}

--임시 영역. 제대로 된 전투데이터 삽입자로 대체해야 함.
  party[1] = EnemyHandler.init("thug")
  party[2] = EnemyHandler.init("thug")
  party[3] = EnemyHandler.init("thug")
  -- enemyparty[1] = EnemyHandler.init("thug")
  -- enemyparty[2] = EnemyHandler.init("knifethug")
  -- enemyparty[3] = EnemyHandler.init("thug")

  party[1].ally = true
  party[2].ally = true
  party[3].ally = true

  party[1].name = "남자"
  party[2].name = "여자"
  party[3].name = "사람"
  party[1].maxHP = 10000
  party[1].currHP = 10000
  party[1].ResourceType = "Mana"
  party[2].ResourceType = "Ki"
  party[3].ResourceType = "Rage"

  -- enemyparty[1].name = enemyparty[1].name .. "A"
  -- enemyparty[2].name = enemyparty[2].name .. "B"
  -- enemyparty[3].name = enemyparty[3].name .. "C"
  enemyparty = initializeenemyparty(EnemyPartyTempletes["thugs1"])

function initializebattle(battle)
  local p = battle.party
  local e = battle.enemyparty
  orderedCharacters = {}
  battleStopWatch = 200
  local i = 1
  targettable = {}
  targettable["10"] = battle.party
  targettable["100"] = battle.enemyparty
  for k, v in pairs(p) do
    p[k].turntime = math.floor((battleStopWatch / p[k].physicalSpeed) + math.random(10))
	table.insert(orderedCharacters, p[k]) 
	p[k].targetnumber = 10 + i
	targettable[tostring(10+i)] = p[k]
	i = i + 1
  end
  i = 1
  for k, v in pairs(e) do
    e[k].turntime = math.floor((battleStopWatch / e[k].physicalSpeed) + math.random(10))
	table.insert(orderedCharacters, e[k])
	e[k].targetnumber = 100 + i
	targettable[tostring(100+i)] = e[k]
	i = i + 1
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

function battlehandler(party, enemyparty)
	currentbattle = {}
	currentbattle.party = party
	currentbattle.enemyparty = enemyparty
	initializebattle(currentbattle)
	battleeachturn()
	while (not checkbattleend()) do
	  battleeachturn()
	end
	if checkbattleend() == "defeat" then
	  printl ("전투에서 패배하였습니다.")
	else
	  printl ("전투에서 승리하였습니다.")
	end
end

function battleeachturn()
	message = ""
	delay = 10
	local usedskill
  progressturntime(orderedCharacters)
	message = message .. orderedCharacters[1].name .. "의 턴입니다."
	orderedCharacters[1].controllable = orderedCharacters[1].ally and orderedCharacters[1].alive --조작을 불가능케 하는 상태이상등에 대한 처리가 추가되어야 함. 
  if orderedCharacters[1].controllable then
	  message = message .. "\n" .. "행동을 선택해 주십시오."
	  orderedCharacters[1].playerCommand(orderedCharacters[1], party, enemyparty)
	elseif orderedCharacters[1].ally then
	  message = message .. "\n" .. orderedCharacters[1].name .. "(은)는 행동할 수 없다…."
	else
	  usedskill = orderedCharacters[1].AICommand(orderedCharacters[1], party, emenyparty)
	end
	draweachtime(message)
	message = ""
	if orderedCharacters[1].controllable then
	  usedskill = askplayer(orderedCharacters[1], party, enemyparty, battle)
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
    delay = math.floor((battleStopWatch / orderedCharacters[1][usedskill.DelayType]) + math.random(5))
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
  while (not playercommand) do
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
    printl(moveliststring .. "[-1] 대기(취소)")
    playercommand = ask("무엇을 하시겠습니까?", unpack(movelist))
	  pc = tonumber(playercommand)
  
    if (pc <= 8 and pc >= 0) then
	    playertarget = lookuptarget(char.skills[pc].MoveType, char.skills[pc].Target, char.targetnumber)
	    if (playertarget == "100") then
        local targets = enemyparty
        for k, v in pairs(targets) do
        end
        skillhandler(char, char.skills[pc], targets)
      elseif (playertarget ~= "-1") then
        local targets = {targettable[playertarget]}
	      skillhandler(char, char.skills[pc], targets)
      end
	  end
    if (playertarget == "-1") then
      playercommand, playersingletarget = false, singletarget
      movelist = {"-1"}
      moveliststring = ""
      local endaskt = getc()
      erase(startaskt, endaskt)
    end
  end
  return char.skills[pc]
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
    if type == "Heal" or
      type == "Support" then
      selection = ask("누구를 목표로 삼습니까?", unpack(targets))
    end
  elseif target == "AnAllyIncludingDead" then
    for k, v in pairs(p) do
      table.insert(targets, tostring(e[k].targetnumber))
    end
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

function skillhandler(char, skill, skilltarget)
  message = message .. "\n" .. char.name .. "의 " .. skill.Name .. "!"
  local opponents = enemyparty
  if not char.ally then
    opponents = party
  end
  local targets = {}
  if skill.MoveType == "Attack" then
    if skill.Target == "AnEnemy" or 
	  skill.Target == "Self" or
	  skill.Target == "AnAlly" or
	  skill.Target == "WholeAlly" then
	    targets = skilltarget
    elseif skill.Target == "WholeEnemy" then
      for k, v in pairs(skilltarget) do
        if skilltarget[k].alive then table.insert(targets, skilltarget[k]) end
      end
    elseif skill.Target == "RandomEnemies" then
      local numTarget = math.random(skill.minTarget, skill.maxTarget)
      for k, v in pairs(pickrandomtarget(opponents, numTarget)) do
        table.insert(target, v)
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
    end
	end
	
	for k, v in pairs(targets) do
	  if not checkavailable(char, skill, targets[k], battle) then break end
	  inflictdamage(char, skill, targets[k], battle)
	end
end

function calculatedamage(actor, skill, target, battle)
  local damage = 0
  if skill.DamageCalculationType == "Basic" then
    damage = math.ceil(skill.AttackParameter * actor[skill.AttackerParameter] / target[skill.TargetParameter])
  end
  return damage
end

function inflictdamage(actor, skill, target, battle)
  local damage = calculatedamage(actor, skill, target, battle)
  message = message .. "\n" .. target.name .. "에게 " .. damage .. "의 데미지!"
  if target.currHP - damage > 0 then
    target.currHP = target.currHP - damage
  else
    characterdie(actor, skill, target, battle)
  end
end

function checkavailable(actor, skill, target, battle)
  if not target.alive and skill.MoveType == "Attack" then
    message = message .. "\n" .. target.name .. "(은)는 이미 전투불능이다!"
    return false
  end
  return true
end

function characterdie(actor, skill, target, battle)
  target.currHP = 0
  target.alive = false
  target.status = "전투불능"
  table.remove(orderedCharacters[target.turnorder])
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
  for i = 1, #party do
    if party[i].alive then
	    table.insert(alivelist,party[i])
	  end
  end
  if next(alivelist) == nil then
  message = message .. "\n그러나 공격할 수 있는 대상이 없다!"
    return false
  end
  local targetlist = combo(alivelist, math.min(amount, #alivelist))
  return targetlist[math.random(#targetlist)]
end

function checkbattleend()
  local partyeliminated, enemypartyeliminated = true, true
  for i = 1, #party do
    if party[i].alive then
	  partyeliminated = false
      break
	end
  end
  if partyeliminated then return "defeat" end
  for i = 1, #enemyparty do
    if enemyparty[i].alive then
	  enemypartyeliminated = false
      break
	end
  end
  if enemypartyeliminated then return "victory" end
  return false
end
#end