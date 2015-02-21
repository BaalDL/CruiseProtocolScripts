#function ephemerallist

  ephemerallist = {}

  ephemerallist["burn"] = {
  	display = "/bR/fY火/x",
    dlength = 2,
    diminishMessage = function(char)
      return char.name .. "의 화상이 사라졌다!"
    end
  }

  ephemerallist["frozen"] = {
    display = "/bB/fW凍/x",
    dlength = 2,
    diminishMessage = function(char)
      return char.name .. "의 동상이 사라졌다!"
    end
  }

  ephemerallist["sleep"] = {
    display = "/bG/fBzZ/x",
    dlength = 2,
    diminishMessage = function(char)
      return char.name .. "(은)는 졸음에서 깨어났다!"
    end
  }

  ephemerallist["paralyzed"] = {
    display = "/bY/fw痲/x",
    dlength = 2,
    diminishMessage = function(char)
      return char.name .. "의 마비가 풀렸다!"
    end
  }

  ephemerallist["stoned"] = {
    display = "/bM/fY石/x",
    dlength = 2,
    diminishMessage = function(char)
      return char.name .. "(이)가 석화에서 자유로워졌다!"
    end
  }

  ephemerallist["blind"] = {
    display = "/bw/fk盲/x",
    dlength = 2,
    diminishMessage = function(char)
      return char.name .. "의 실명이 나았다!"
    end
  }

  ephemerallist["cursed"] = {
    display = "/bk/fw呪/x",
    dlength = 2,
    diminishMessage = function(char)
      return char.name .. "의 저주가 풀렸다!"
    end
  }

#end