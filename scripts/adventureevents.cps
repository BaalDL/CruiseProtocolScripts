#function adventureevents

  AdventureEventList = {}
  AdventureEventHelper = {}
  AdventureEventHelper.EventHandler = {}

  function AdventureEventHelper.GetEventsByTag(tag)
    local eventkeys = {}

    for k, v in pairs(AdventureEventList) do
      if v.Tag[tag] then
        table.insert(eventkeys, k)
      end
    end
    return eventkeys
  end

  function AdventureEventHelper.PickRandomEvent(list)
    return list[math.random(1, #list)]
  end

  function AdventureEventHelper.EventHandler.EnemyEncounter(eventkey)
    local event = AdventureEventList[eventkey]
    local enemyparty = initializeenemyparty(EnemyPartyTempletes[event.EncounterList[math.random(1, #event.EncounterList)]])
    battlehandler(enemyparty, true)
  end

  function AdventureEventHelper.EventHandler.Loot(eventkey)
    local event = AdventureEventList[eventkey]
    local eventitem = event.ItemList[math.random(1, #event.ItemList)]
    printlw("응...?")
    printlw("이동 도중 " .. ItemList[eventitem].Name .. "(을)를 1개 입수했다!")
    getitem(eventitem, 1)
  end

  AdventureEventList["ThugsEncounter1"] = {
    Type = "EnemyEncounter",
    Prerequisite = {},
    Grade = "LowLevel",
    Tag = {Encounter = true, Enemy = true, EnemyEncounter = true},
    EncounterList = {"thugs1", "thugs2"},
  }

  AdventureEventList["SimpleItemGet1"] = {
    Type = "Loot",
    Prerequisite = {},
    Grade = "Basic",
    Tag = {Loot = true},
    ItemList = {101, 102, 201, 202, 203, 204, 205, 206, 207}
  }
#end