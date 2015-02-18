#function debugscript
  /*
  print("현재 커서 위치는")
  local a, b = getc()
  printl(getct() .. "," .. getcl() .. "입니다.")
  printlw("전문용어로" .. a .. "," .. b .. "라고도 하죠.")
  moveto(a,b)
  printlw("커서를 옮겨봤는데 보이나요?")
  a, b = getc()
  movev(12)
  moveh(20)
  print("↓")
  moved(1)
  movel(2)
  print("←")
  movel(4)
  print("↑")
  moveu(1)
  movel(2)
  print("▶")
  mover(2)
  printw(">")
  moveto(a,b)
  drawl("이 줄은 16번째 줄에 작성될 예정입니다.", 15)
  printw("")
  drawl("이건 어떻게 작동할까?")
  printw("")
  printl ("Hello World")
  execute ("relate_konojoe")
  */
#end

#function loadrelatedata
  execute ("relate_konojoe")
  relate = {}
  relate[17] = {
    func = konojoe,
    rank = 0
  }

  a, b, c = getdate(0)
  printl ("게임 시작일은 " .. a .. "년 " .. b .. "월 " .. c .. "일입니다.")
  a, b, c = getdate(100)
  printl ("게임 시작 후 100일이 지나면 " .. a .. "년 " .. b .. "월 " .. c .. "일입니다.")

  save("save.csf")
  load("save.csf")
  printl ("주인공 이름은" .. name .. "입니다.")
  printl ("소지금은" .. money .. "입니다.")
#end

#function loadbattledata

  MAXENEMY = 5
  MAXPARTY = 4

  EWIDTH = windowwidth / MAXENEMY
  PWIDTH = windowwidth / MAXPARTY
  -- we assume EBARWIDTH, PBARWIDTH are odd numbers.
  EBARWIDTH = (EWIDTH - string.len("     HP [] "))
  PBARWIDTH = (PWIDTH - string.len("     魔 [] "))


  execute ("skilllist")
  execute ("enemylist")
  execute ("itemlist")
  execute ("ephemerallist")
  execute ("partyheader")
  execute ("partydata")
  execute ("enemypartylist")
  execute ("enemypartyheader")
  execute ("battleheader")
  execute ("itemheader")
  
  addsave("allpartymembers")
  addsave("currentpartymembers")
  addsave("EnemyInfo")
  addsave("EnemyDefenseInfo")
  addreset("allpartymembers")
  addreset("currentpartymembers")  
  addreset("party")
  addreset("EnemyInfo")
  addreset("EnemyDefenseInfo")

  addsave("money")
  addsave("byss")
#end