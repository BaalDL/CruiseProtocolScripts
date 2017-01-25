#function playercharacterdata
  execute ("playerskills")

  player = {}
  addsave("player")
  inventory = {}
  addsave("inventory")
  player.skills = {}
  for _, v in ipairs(PlayerSkillHelper.GetSkillsByTag("Default")) do
    player.skills[v] = true
  end
  player.skills["journeytype_loot"] = true


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
  inventory[101] = 1
  inventory[102] = 5
  inventory[103] = 5
  inventory[104] = 5
  inventory[201] = 3
  table.sort(inventory)
#end