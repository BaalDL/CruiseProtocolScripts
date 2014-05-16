#function enemypartyheader
  function initializeenemyparty(epT)
    local ep = {}
    for k, v in pairs(epT) do
      table.insert(ep, EnemyHandler.init(epT[k]))
    end
    return ep
  end
#end

#function enemypartylist
  EnemyPartyTempletes = {}

  EnemyPartyTempletes["thugs1"] = {"thug", "thug","knifethug"}
  EnemyPartyTempletes["thugs2"] = {"thug", "thug", "thug"}
  EnemyPartyTempletes["thugs3"] = {"knifethug", "knifethug", "knifethug"}

#end