#function npcdialogue
  execute("playerspeak")
  function startdialogue(npckey, dialoguekey)
    local dialogue = LocationNpcDialogueList[npckey][dialoguekey]
    local pointer = "initial"
    while (pointer ~= "terminal") do
      if (dialogue[pointer].type == "inquery") then
        pointer = dialogue[pointer].next[playerspeak(dialogue[pointer].inquery, table.unpack(dialogue[pointer].inqueryreferences))]
      elseif (dialogue[pointer].type == "monologue") then
        sayw(LocationNpcsList[npckey].Name, table.unpack(dialogue[pointer].scripts))
        pointer = dialogue[pointer].next
      elseif (dialogue[pointer].type == "empty") then
        pointer = dialogue[pointer].next
      elseif (dialogue[pointer].type == "subdialogue") then
        startdialogue(npckey, dialogue[pointer].subkey)
        pointer = "initial"
      end
    end
  end

#end