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
    while(not ifclearedinfiltration(currentinfiltrationpanel)) do
      drawinfiltrationpanel(currentinfiltrationpanel)
      local coord = askstrict("해제할 좌표를 지정하십시오. [-1]중단", verifyalgebraicnotation)
      if (coord == "abort") then break end
      infiltrationeachturn(currentinfiltrationpanel, coord)
    end
  end

  function infiltrationeachturn(panel, coord)
    local p = panel.positions
    if (p[#p - panel.solved][1] == coord[1] and p[#p - panel.solved][2] == coord[2]) then
      printl("SUCCESS")
      panel = updatepanel(panel)
    else
      printl("FAIL!")
    end
  end

  function initializepanel(size, difficulty)
    local panel = {}
    panel.size = size
    panel.tiles = getrandomtiles(size)
    panel.positions = getrandompositions(size)
    panel.triesleft = size - difficulty
    panel.solved = 0
    return panel
  end

  function updatepanel(panel)
    panel.tiles[#panel.tiles - panel.solved] = "　"
    panel.solved = panel.solved + 1
    return panel
  end

  function ifclearedinfiltration(panel)
    return (panel.solved == #panel.tiles)
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

  function parsealgebraicnotation(input)
    local coord = {}
    coord[1] = input:match("%a")
    coord[1] = coord[1] and coord[1]:upper():byte() - 64 or -1
    coord[2] = tonumber(input:match("%d+"))
    coord[2] = coord[2] and coord[2] or -1
    return coord
  end

  function verifyalgebraicnotation(input)
    local size = currentinfiltrationpanel.size
    if (input == "-1") then return "abort" end
    local coord = parsealgebraicnotation(input)
    if (coord[1] >= 1 and coord[1] <= size and coord[2] >= 1 and coord[2] <= size) then return coord end
    return false
  end
#end