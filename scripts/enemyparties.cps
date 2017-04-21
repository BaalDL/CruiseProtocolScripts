#function enemypartyheader
  function initializeenemyparty(epT)
    local ep = {}
    local enemyamount = {}
    local enemyamountname = {"甲", "乙", "兵", "丁", "戊"}
    local counter = 1
    for k, _ in pairs(epT) do
      local r = math.random(k, MAXENEMY)
      epT[k], epT[r] = epT[r], epT[k]
    end
    for k, v in pairs(epT) do
      ep[k] = EnemyHandler.init(epT[k])
      if not enemyamount[epT[k]] then
        enemyamount[epT[k]] = 1
      else
        enemyamount[epT[k]] = enemyamount[epT[k]] + 1
      end
    end
    for k, _ in pairs(epT) do
      if (enemyamount[epT[k]] > 1) then
        counter = 1
        for l, _ in pairs(ep) do
          if (ep[l].name == EnemyTempletes[epT[k]].name) then
            ep[l].name = ep[l].name .. enemyamountname[counter]
            counter = counter + 1
          end
        end
      end
    end
    return ep
  end
#end

#function enemypartylist
  EnemyPartyTempletes = {}

  EnemyPartyTempletes["thugs1"] = {"thug", "thug","knifethug"}
  EnemyPartyTempletes["thugs2"] = {"thug", "thug", "thug"}
  EnemyPartyTempletes["thugs3"] = {"knifethug", "knifethug", "knifethug", "thug"}
  EnemyPartyTempletes["thugs4"] = {"knifethug", "knifethug", "thug", "thug"}

  EnemyPartyTempletes["twoimps"] = {"tutorialimp", "tutorialimp"}
  EnemyPartyTempletes["threeimps"] = {"tutorialimp", "tutorialimp", "tutorialimp"}
#end