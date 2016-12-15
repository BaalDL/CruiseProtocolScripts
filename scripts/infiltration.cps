#function infiltration
  
  currentinfiltrationpanel = {}
  infiltrationmaxsize = 16
  possibleshapes = {"□", "■", "☆", "★", "○", "●", "△", "▲", "◇", "◆", "♤", "♠", "♡", "♥", "♧", "♣"}
  possiblecolors = {"/fW/bk", "/fK/bw", "/fY/bb", "/fB/by", "/fR/bc", "/fC/br", "/fG/bm", "/fM/bg"}
  possiblecolorsextended = {"/fW/bk", "/fK/bw", "/fY/bb", "/fB/by", "/fR/bc", "/fC/br", "/fG/bm", "/fM/bg", "/fw/bK", "/fk/bW", "/fy/bB", "/fb/bY", "/fr/bC", "/fc/bR", "/fg/bM", "/fm/bG"}
  rowstrings = {"Ａ", "Ｂ", "Ｃ", "Ｄ", "Ｅ", "Ｆ", "Ｇ", "Ｈ", "Ｉ", "Ｊ", "Ｋ", "Ｌ", "Ｍ", "Ｎ", "Ｏ", "Ｐ"}
  columnstrings = {"１", "２", "３", "４", "５", "６", "７", "８", "９", "10", "11", "12", "13", "14", "15", "16"}

  function startinfiltration(inputsize, difficulty, player)
    local size = inputsize
    if size > infiltrationmaxsize then
      size = infiltrationmaxsize
    end
    currentinfiltrationpanel = initializepanel(size, difficulty)
    drawinfiltrationpanel(currentinfiltrationpanel)
    ask("해제할 좌표를 지정하십시오.")
  end

  function initializepanel(size, difficulty)
    local panel = {}
    panel.size = size
    panel.tiles = getrandomtiles(size)
    panel.positions = getrandompositions(size)
    panel.triesleft = size - difficulty
    return panel
  end

  function drawinfiltrationpanel(panel)
    local paneltable = {}
    local panelstring = "　　"
    for i = 1, panel.size, 1 do
      paneltable[i] = {}
    end
    for i = 1, #panel.tiles, 1 do
      local row = panel.positions[i][1]
      local column = panel.positions[i][2]
      for j = 1, panel.size, 1 do
        paneltable[row][j] = i
        paneltable[j][column] = i
      end
    end

    for j = 1, panel.size, 1 do
      panelstring = panelstring .. columnstrings[j]
    end
    panelstring = panelstring .. "\n" .. "　/fk？" .. string.rep("？", panel.size) .. "？/x\n"
    for i = 1, panel.size, 1 do
      panelstring = panelstring .. rowstrings[i] .. "/fk？/x"
      for j = 1, panel.size, 1 do
        panelstring = panelstring .. panel.tiles[paneltable[i][j]]
      end
      panelstring = panelstring .. "？\n"
    end
    panelstring = panelstring .. "　/fk？" .. string.rep("？", panel.size) .. "？/x\n"
    _print(panelstring)
  end

  function getrandomtiles(size)
    local tiles = {}
    local shapes = randomlist(possibleshapes, size)
    local colors
    if (size <= 8) then
      colors = randomlist(possiblecolors, size)
    else
      colors = randomlist(possiblecolorsextended, size)
    end
    for i, v in ipairs(shapes) do
      tiles[i] = colors[i] .. shapes[i] .. "/x"
    end
    return tiles
  end

  function getrandompositions(size)
    local numbers = {}
    for i = 1, size do
      numbers[i] = i
    end
    local row = randomlist(numbers, size)
    local column = randomlist(numbers, size)
    local coord = {}
    for i, _ in ipairs(row) do
      coord[i] = {row[i], column[i]}
    end
    return coord
  end
#end