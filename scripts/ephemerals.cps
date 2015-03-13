#function ephemerallist

  ephemerallist = {}

  ephemerallist["burn"] = {
  	display = "/bR/fY火/x",
    dlength = 2,
    acquireMessage = function(char)
      return char.name .. "의 몸을 화염이 덮친다!"
    end,
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
    acquireMessage = function(char)
      return char.name .. "의 몸 곳곳이 얼어붙는다!"
    end,
    diminishMessage = function(char)
      return char.name .. "의 동상이 사라졌다!"
    end,
    minDuration = 2,
    maxDuration = 5
    }

  ephemerallist["sleep"] = {
    display = "/bG/fBzZ/x",
    dlength = 2,
    acquireMessage = function(char)
      return char.name .. "의 의식이 멀어진다…."
    end,
    diminishMessage = function(char)
      return char.name .. "(은)는 졸음에서 깨어났다!"
    end,
    atcheckcontrollable = function(char, battle)
      message = message .. "\n" .. char.name .. "(은)는 졸고 있다…."
      return false
    end,
    minDuration = 2,
    maxDuration = 5
  }

  ephemerallist["paralyzed"] = {
    display = "/bY/fw痲/x",
    dlength = 2,
    acquireMessage = function(char)
      return char.name .. "의 몸 곳곳이 뻣뻣해진다!"
    end,
    diminishMessage = function(char)
      return char.name .. "의 마비가 풀렸다!"
    end,
    atcheckcontrollable = function(char, battle)
      if math.random(10) <= 3 then
        message = message .. "\n" .. char.name .. "(이)가 예상치 못하게 몸이 저려온다!"
        return false
      else
      	message = message .. "\n" .. char.name .. "(은)는 간신히 몸을 가누었다!"
      	return true
      end
    end,
    minDuration = 2,
    maxDuration = 5
  }

  ephemerallist["stoned"] = {
    display = "/bM/fY石/x",
    dlength = 2,
    acquireMessage = function(char)
      return char.name .. "의 몸 일부분이 굳는다!"
    end,
    diminishMessage = function(char)
      return char.name .. "(이)가 석화에서 자유로워졌다!"
    end,
    minDuration = 2,
    maxDuration = 5
  }

  ephemerallist["blind"] = {
    display = "/bw/fk盲/x",
    dlength = 2,
    acquireMessage = function(char)
      return char.name .. "의 눈 앞이 깜깜해진다!"
    end,
    diminishMessage = function(char)
      return char.name .. "의 실명이 나았다!"
    end,
    minDuration = 2,
    maxDuration = 5
  }

  ephemerallist["cursed"] = {
    display = "/bk/fw呪/x",
    dlength = 2,
    acquireMessage = function(char)
      return char.name .. "(은)는 저주받았다!"
    end,
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