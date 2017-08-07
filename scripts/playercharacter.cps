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

  player.params = {"strength", "manuever", "agility", "fortitude", "intelligence", "wisdom", "decision", "willpower", "charisma", "luck"}
  player.paramnames = {"근력", "조작", "기민", "강인", "지식", "지혜", "판단", "의지", "매력", "행운"}

  player.parammt = {}
  function player.parammt.__add(a, b)
    if getmetatable(a) ~= player.parammt or getmetatable(b) ~= player.parammt then
      error("attempt to parammt.__add which do not havs param metatable", 2)
    elseif #a ~= #b then
      error("attempt to parammt.__add two tables which do not have same elements")
    end
    local result = a
    for k, v in pairs(result) do
      if result[k] == nil then
        result[k] = b[k]
      elseif b[k] == nil then
      else
        result[k] = result[k] + b[k]
      end
    end
    return result
  end

  setmetatable(player.params, player.parammt)

  for _, v in ipairs(PlayerSkillHelper.GetSkillsByTag("Default")) do
    player.skills[v] = true
  end
  player.skills["journeytype_loot"] = true -- TEMPORARY

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
  player.dungeonvisiblerange = 7
  player.dungeonmenuavailable = false
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

#function playercharactergeneration
  function playercharacterparamgeneration()
    local default = {5, 5, 5, 5, 5, 5, 5, 5, 5, 5}
    setmetatable(default, player.parammt)
    player.params = player.params + default
  end

  charactergenerationcommand = {}
  charactergenerationcommand.references = {}
  charactergenerationcommand.returns = {"params", "skills"}
  charactergenerationcommand.commands = {}

  function charactergenerationcommand:initial()
    charactergenerationcommand.commands["params"] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
    charactergenerationcommand.commands["skills"] = {}
  end
#end