#function playercharacterdata
  player = {}
  addsave("player")
  inventory = {}
  addsave("inventory")

  player.journeydistance = 200
  player.minimumstrayrate = 0.5
  inventory[101] = 1
  inventory[102] = 5
  inventory[103] = 5
  inventory[104] = 5
  inventory[201] = 3
  table.sort(inventory)
#end