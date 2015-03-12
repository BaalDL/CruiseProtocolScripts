#function ephemerallist

  ephemerallist = {}

  ephemerallist["burn"] = {
  	display = "/bR/fY火/x",
    dlength = 2,
    diminishMessage = function(char)
      return char.name .. "의 화상이 사라졌다!"
    end,
    atcountturn = function(char, battle)
      message = message .. "\n화상의 피해가 " .. char.name .. "(을)를 덮친다!"
      inflictdamage(nil, SkillList["SystemBurnDamage"], char, battle, nil)
    end,
    minDuration = 2,
    maxDuration = 5
  }

  ephemerallist["frozen"] = {
    display = "/bB/fW凍/x",
    dlength = 2,
    diminishMessage = function(char)
      return char.name .. "의 동상이 사라졌다!"
    end,
    minDuration = 2,
    maxDuration = 5
    }

  ephemerallist["sleep"] = {
    display = "/bG/fBzZ/x",
    dlength = 2,
    diminishMessage = function(char)
      return char.name .. "(은)는 졸음에서 깨어났다!"
    end,
    minDuration = 2,
    maxDuration = 5
  }

  ephemerallist["paralyzed"] = {
    display = "/bY/fw痲/x",
    dlength = 2,
    diminishMessage = function(char)
      return char.name .. "의 마비가 풀렸다!"
    end,
    minDuration = 2,
    maxDuration = 5
  }

  ephemerallist["stoned"] = {
    display = "/bM/fY石/x",
    dlength = 2,
    diminishMessage = function(char)
      return char.name .. "(이)가 석화에서 자유로워졌다!"
    end,
    minDuration = 2,
    maxDuration = 5
  }

  ephemerallist["blind"] = {
    display = "/bw/fk盲/x",
    dlength = 2,
    diminishMessage = function(char)
      return char.name .. "의 실명이 나았다!"
    end,
    minDuration = 2,
    maxDuration = 5
  }

  ephemerallist["cursed"] = {
    display = "/bk/fw呪/x",
    dlength = 2,
    diminishMessage = function(char)
      return char.name .. "의 저주가 풀렸다!"
    end,
    atcountturn = function(char, battle)
      message = message .. "\n저주가 " .. char.name .. "(을)를 덮친다!"
      inflictdamage(nil, SkillList["SystemCurseDamage"], char, battle, nil)
    end,
    minDuration = 2,
    maxDuration = 5
  }

  ephemerallist["manadepletion"] = {
    display = "/bk/fR魔/x",
    dlength = 2,
    diminishMessage = function(char)
      return char.name .. "의 주변에 다시 마나가 감돈다!"
    end
  }

#end