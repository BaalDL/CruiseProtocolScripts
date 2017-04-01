#function playercharacterdata
  execute ("playerskills")

  player = {}
  player.Name = "주인강"
  addsave("player")
  inventory = {}
  addsave("inventory")
  money = 0
  maxmoney = 999999
  addsave("money")
  byss = 0
  maxbyss = 999999
  addsave("byss")
  player.skills = {}
  player.skillpoint = 0
  player.maxskillpoint = 100
  player.flags = {}
  
  for _, v in ipairs(PlayerSkillHelper.GetSkillsByTag("Default")) do
    player.skills[v] = true
  end
  player.skills["journeytype_loot"] = true

  function player.addskillpoint(amount)
    player.skillpoint = math.min(player.skillpoint + amount, player.maxskillpoint)
    printl(player.Name .. "의 스킬 포인트가 " .. player.skillpoint .. "(이)가 되었다.")
    if (player.skillpoint == player.maxskillpoint) then
      printl("스킬 포인트가 최대치에 달해 더 이상 오르지 않는다.")
    end
  end
  function player.addmoney(amount)
    money = math.min(money + amount, maxmoney)
    printl(amount ..  "만큼의 돈을 획득해 소지금이 " .. money .. "(이)가 되었다.")
    if (money == maxmoney) then
      printl("소지금이 최대치에 달해 더 이상 오르지 않는다.")
    end
  end

  player.journeydistance = 200
  player.minimumstrayrate = 0.5
  player.journeypreference = {}
  player.journeypreference.maxturns = 1
  player.journeypreference.nothing = 2
  player.journeypreference.lootable = 2
  player.journeypreference.enemyencounter = 2
  player.journeypreference.npcencounter = 2
  player.journeypreference.randomevent = 2
  player.journeypreference.discover = 2
  player.journeypreference.confirm = false
  player.journeypreference.autocommand = true
  player.battlepreference = {}
  player.battlepreference.expandephemeral = true
  player.battlepreference.draworderbar = true
  inventory[101] = 1
  inventory[102] = 5
  inventory[103] = 5
  inventory[104] = 5
  inventory[201] = 3
  table.sort(inventory)
#end