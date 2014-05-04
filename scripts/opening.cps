#function ftypeinitialize
execute("header_characters")
execute("header_playerinfo")
#end










#function ptypeinitialize
date = 0
phase = 3
places = {}
placeflag = {}
tosave = {name=true, money=true, byss=true, date=true, phase=true, places=true, placeflag=true}
toreset = {}

// 임시
fname = "디"
gname = "폴트"
name = "디폴트"
#end

#function ptypeopening
printcurrentdate ()
printcurrenttime (2, 17)
printl ("")
printplace("미래과학원 캠퍼스")
printpara("나를 태우고 온 택시가 멀어져 간다.",
"간단한 짐이 든 가방을 어깨에 고쳐메고, 찬 공기를 깊게 들이쉰다.",
"입학 절차를 확인하러 가야 한다. 위치는 분명히… 창의관 입학관리처.")
local temp = {}
temp[100] = "창의관"
gotoplace(true, temp)
printplace("창의관", "강의동으로 사용되는 건물인 것 같다.", "개강 전이라 그런지 한산해 보인다.")
temp[100] = nil
temp[1001] = "입학관리처 사무실"
gotoplace(true, temp)
printplace("입학관리처 사무실", "직원들이 분주하게 일하고 있다.", "나와 비슷한 나이대의 학생들이 서류를 들고 왔다갔다하고 있다.")
printlw ("젊은 직원 한 명이 나를 보고 손짓한다.")
sayw ("남자 직원", "신입생이죠? 이쪽으로 오세요.", "이름을 알려주시겠어요?")
name = nil
fname, gname = "", ""
while not name do
	while (fname == "") do
		fname = ask ("당신의 성은?")
	end
	while (gname == "") do
		gname = ask ("당신의 이름은?")
	end
	local ok =  ask ("당신의 이름은 " .. fname .. " " .. gname .. "이 맞습니까?(0:yes, 1:no)", "0", "1")
	if (ok == "0") then
		name = fname .. gname
	elseif (ok == "1") then
		fname = ""
		gname = ""
	end
end
addsave("name", "fname", "gname")
sayw ("남자 직원", "네, " .. name .. "학생이요... 잠시만 기다려주세요.",
"어디보자... 네. 주민등록증 보여주세요. 네. 확인 됐습니다.",
"서류는 인터넷으로 제출하셨고요, 확인 했습니… 어라?",
"이상하네. 다른 서류는 다 있는데 진로상담용 설문지가 제출이 안 되어 있네요?")
printlw ("분명 그 서류는 인터넷에서 작성해서 저장을 제대로 했던 기억인데...")
printl ("1. 그럴 리가 없어요. 제대로 제출했는데요.")
printl ("2. 중요한 서류인가요?")
printl ("3. 뭐가 잘못되었나요?")
local x = ask("", "1", "2", "3")
if x == "1" then
	sayw ("남자 직원", "아 네. 이거 이상하네. 다른 서류랑 일괄 처리하는거라",
	"이것만 없을 리가 없는데... 전산 오류라도 난 건가?",
	"죄송하니다. 아마 저희 쪽 잘못인 것 같은데... 한 장 지금 간단하게 작성해 주실래요?",
	"애초에 그렇게 중요한 서류는 아닌데 일단 필요해서…")
elseif x == "2" then
	sayw ("남자 직원", "아, 아닙니다. 중요한 서류는 아닌데…",
	"일단 없으면 좀 곤란해서... 죄송하지만 한 장 작성해 주세요.",
	"써보셨으니까 아시겠지만, 그렇게 대단한 내용은 없잖아요?")
else
	sayw ("남자 직원", "아, 그 저희가 전산 처리가 뭐 잘못된 것 같네요.",
	"죄송하지만 이전에 쓰셔서 제출하셨던 내용 그대로 다시 작성해주실 수 있나요?")
end
printpara ("남자 직원은 미안한 표정을 지으며 책상 서랍에서 한 장의 서류를 꺼내서 내게 내민다.",
"진로상담용 설문지라 해도 대단한 건 없고, 내가 해온 활동이나 취미 같은 걸 간단히 적는 거였다.",
"어떻게 썼었는지는 대충 기억에 남아있으니, 요점만 추려서 빨리 써 버리자.")
local ok = false
local selfadjust = ""
while not ok do
	selfadjust = ""
	printlw ("저는...")
	printl ("1. 몸을 움직이는 것을 좋아하는 활발한 학생이었습니다.")
	printl ("2. 어릴 때부터 책을 읽고 생각하는 것을 좋아했습니다.")
	printl ("3. 친구들과 노는 것을 즐겨 원만한 교우관계를 유지했습니다.")
	local x = ask("", "1", "2", "3")
	if x == "1" then
		selfadjust = "저는 운동하는 것을 좋아하는 활발한 학생이었습니다. "
		printlw ("한때는...")
		printl ("1. 학교를 대표해 단거리 주자로 나선 적도 있고,")
		printl ("2. 등산부 부장을 맡을 정도였고,")
		printl ("3. 수영을 정말 즐겨 방학 내내 수영장에 살았었고,")
		local x = ask("", "1", "2", "3")
		if x == "1" then
			selfadjust = selfadjust .. "한때는 학교를 대표해 단거리 주자로 나선 적도 있고, "
			// 백근
		elseif x == "2" then
			selfadjust = selfadjust .. "한때는 등산부 부장을 맡을 정도였고, "
			// 적근
		else
			selfadjust = selfadjust .. "한때는 수영을 정말 즐겨 방학 내내 수영장에 살았었고, "
			// 호흡
		end
		printlw ("친구들과는...")
		printl ("1. 서바이벌 게임을 함께 즐겼습니다.")
		printl ("2. 만나서 축구를 즐겼습니다.")
		printl ("3. 이런저런 말썽을 부리며 돌아다녔습니다.")
		local x = ask("", "1", "2", "3")
		if x == "1" then
			selfadjust = selfadjust .. "친구들과 함께 서바이벌 게임을 즐기곤 했습니다. "
			// 투쟁
		elseif x == "2" then
			selfadjust = selfadjust .. "친구들과 하는 축구를 정말 즐겼습니다. "
			// 배려
		else
			selfadjust = selfadjust .. "악우들과 함께 사방을 누비며 말썽을 부렸습니다. "
			// 악의
		end
	elseif x == "2" then
		selfadjust = "저는 어릴 때부터 책을 읽고 생각하는 것을 좋아했습니다. "
		printlw ("어릴 때에는... ")
		printl ("1. 책을 정말 많이 읽어 주변 어른들을 놀라게 했고,")
		printl ("2. 암산왕이라 불릴 정도였고, ")
		printl ("3. 온갖 종류의 퍼즐을 섭렵했으며,")
		local x = ask("", "1", "2", "3")
		if x == "1" then
			selfadjust = selfadjust .. "어릴 때에는 책을 정말 많이 읽어 주변 어른들을 놀라게 했고, "
			// 기억
		elseif x == "2" then
			selfadjust = selfadjust .. "어릴 때에는 암산왕이라 불릴 정도였고, "
			// 계산
		else
			selfadjust = selfadjust .. "초등학교에 입학하기도 전에 온갖 종류의 퍼즐을 섭렵했으며, "
			// 추론
		end
		printlw ("친구들과는...")
		printl ("1. 논쟁에서 진 적이 없습니다.")
		printl ("2. 곤란한 상황마다 제가 상황을 수습했습니다.")
		printl ("3. 제가 주도적으로 친구들을 이끌었습니다.")
		local x = ask("", "1", "2", "3")
		if x == "1" then
			selfadjust = selfadjust .. "친구들과의 논쟁에서 진 적이 없습니다. "
			// 투쟁
		elseif x == "2" then
			selfadjust = selfadjust .. "친구들이 곤란한 상황에 빠졌을 때마다 번뜩이는 아이디어로 문제를 해결하곤 했습니다. "
			// 배려
		else
			selfadjust = selfadjust .. "명철한 리더십으로 아이들 사이의 대장 격이었습니다. "
			// 희망
		end
	else
		selfadjust = "저는 친구들과 노는 것을 즐겨 원만한 교우관계를 유지했습니다. "
		printlw ("어릴 때부터...")
		printl ("1. 허구헌날 싸우고 다닌다는 소리를 들을 정도로 친구들과 사이가 좋았으며,")
		printl ("2. 싸우는 친구들을 말리는 역할을 도맡아 하며 친구들의 신뢰를 받았고, ")
		printl ("3. 카사노바 소리를 들을 정도로 다양한 친구들을 사귀었으며, ")
		local x = ask("", "1", "2", "3")
		if x == "1" then
			selfadjust = selfadjust .. "어릴 때부터 허구헌날 싸우고 다닌다는 소리를 들을 정도로 친구들과 사이가 좋았으며, "
			// 투쟁
		elseif x == "2" then
			selfadjust = selfadjust .. "어릴 적부터 싸우는 친구들을 말리는 역할을 도맡아 하며 친구들의 신뢰를 받았고, "
			// 배려
		else
			selfadjust = selfadjust .. "어릴 때부터 카사노바 소리를 들을 정도로 다양한 친구들을 사귀었으며, "
			// 운명
		end
		printlw ("친구들 사이에서는... ")
		printl ("1. 끈질기다는 소리를 들을 정도로 친구들과 오래 연락을 유지하고 있습니다.")
		printl ("2. 부처님같다는 소리를 들을 정도로 관용으로 친구들을 대했습니다.")
		printl ("3. 정말 재미있는 친구라는 평을 듣습니다.")
		local x = ask("", "1", "2", "3")
		if x == "1" then
			selfadjust = selfadjust .. "끈질길 정도로 친구들과 오래 연락을 유지하고 있습니다. "
			// 끈기
		elseif x == "2" then
			selfadjust = selfadjust .. "친구들 사이에서 부처님같다는 소리를 들을 정도로 관용으로 친구들을 대했습니다. "
			// 관용
		else
			selfadjust = selfadjust .. "뛰어난 유머 감각으로 정말 재미있는 친구로 있어왔습니다. "
			// 발상
		end
	end
	printlw ("제 장점은...")
	printl ("1. 용감합니다.")
	printl ("2. 주변 사람의 생각을 잘 파악하는 편입니다.")
	printl ("3. 마음이 넓습니다.")
	printl ("4. 조리있게 생각하고 말할 수 있습니다.")
	printl ("5. 한번 손에 잡은 일은 쉽게 놓지 않습니다.")
	local x = ask(">", "1", "2", "3", "4", "5")
	if x == "1" then
		selfadjust = selfadjust.. "제 장점은 용감함이라고 생각합니다. 저는 실패를 두려워하지 않습니다. "
		// 용기
	elseif x == "2" then
		selfadjust = selfadjust.. "저는 인간 경험이 풍부해, 다른 사람이 무엇을 하고 싶은지를 잘 파악하는 편입니다. "
		// 독심
	elseif x == "3" then
		selfadjust = selfadjust.. "친구들은 저를 보고 포용력이 넓어 웬만한 일에 화내지 않는다고 합니다. "
		// 포용력
	elseif x == "4" then
		selfadjust = selfadjust.. "제 강점은 어떤 상황에서도 조리있게 생각하고 말할 수 있는 능력입니다. "
		// 논리
	else
		selfadjust = selfadjust.. "저는 설사 뒤쳐지더라도 포기하지 않는 불굴의 정신의 소유자입니다. "
		// 끈기
	end
	printlw ("앞으로는...")
	printl ("1. 산업의 역군으로 국가에 공헌하고 싶습니다.")
	printl ("2. 과학 기술의 발전으로 인류에 기여하고자 합니다.")
	printl ("3. 세상의 신비들을 하나하나 파헤치는 게 제 꿈입니다.")
	printl ("4. 인생을 즐겁게 살아가자는 게 제 모토입니다.")
	printl ("5. 주변 사람들과 조화되는 삶을 살려 합니다.")
	local x = ask(">", "1", "2", "3", "4", "5")
	if x == "1" then
		selfadjust = selfadjust.. "졸업 이후에는 산업의 역군이 되어 국가에 공헌하고 싶습니다."
		// 용기
	elseif x == "2" then
		selfadjust = selfadjust.. "저는 과학 기술을 발전시켜 인류에 기여하고자 합니다."
		// 독심
	elseif x == "3" then
		selfadjust = selfadjust.. "앞으로 이 세상의 신비를 하나하나 제 손으로 파헤쳐 나가는게 꿈입니다."
		// 포용력
	elseif x == "4" then
		selfadjust = selfadjust.. "어디에 있든지 인생을 즐겁게 살아가는 것이 제 삶의 목표입니다."
		// 논리
	else
		selfadjust = selfadjust.. "언제나 주변 사람들과 조화되는 삶을 살고 싶습니다."
		// 끈기
	end	
	printl(selfadjust)
	local x = ask("이런 내용이던 기억이다. 이대로 제출할까? (0: 이대로 제출. 1: 다시 쓰자.)", "0", "1")
	if x == "0" then
		ok = true
	else
		ok = false
	end
end
sayw("남자 직원", "아, 고마워요. 잠시만 저 쪽에 앉아서 기다려 주실래요?")
printpara("직윈이 안내한 대로 한편에 있는 소파에 앉는다. 이제 숨을 좀 돌리겠다.",
"주변을 둘러보니 학생들이 계속 들어갔다 나왔다 하고 있다." ,
"나랑은 달리 별 문제 없이 입학수속을 진행하고 있는 듯 했다.")
printlw("")

route = "subopening_ptype"
#end

#function subopening_ptype
printpara("학생이 들어왔다 나갔다를 반복하던 어느 순간,",
"이 사무실에 학생이 나밖에 남지 않는 순간이 찾아왔다.",
"키보드 치는 소리와, 헛기침 소리, 시계침 소리가 방을 메운다.")
printcurrenttime(2, 43, 0)
printw ("")
printpara ("시간은 그렇게 지나지 않았다.",
"하지만 앞으로 기숙사에 들어가는 절차를 비롯해",
"몇몇 수속을 더 밟아야 한다는 생각이 들자",
"마음이 다급해지는것도 사실이다….")
printpara ("그 때, 사무실 문을 누가 열고 들어온다.",
"훤칠한 키에 양복을 입은 초로의 노인이다. 새하얗게 센 머리와 자로 잰 듯한 사각형 수염이 인상적이다.",
"내 서류를 처리하던 직원이 일어나서 응대한다. 우리 학교 교수님인 것 같다.",
"남자 직원이 뭐라뭐라 이야기를 하더니 잠깐 나를 흘끗 보고 백발의 교수님에게 다시 말을 건넨다.",
"아마도 내 서류를 처리해야 해서 지금 시간을 낼 수 없으니 기다려달라는 뜻일까.",
"내 예상은 맞아 떨어진 듯, 노인은 곧은 어깨를 한번 으쓱이더니, 뒤를 돌아 내가 있는 소파 쪽으로 온다.",
"나는 엉겁결에 인사한다. 노인은 빙긋 웃더니 내 옆에 앉는다.")
sayw ("노신사", "신입생인가?")
printpara ("의외로 젊은 목소리로, 노인이 말을 건다.",
"얼굴을 자세히 들여다보니 그렇게 늙은 것 같지는 않기도 하다.")
printl ("1. 아, 네. 신입생입니다.")
printl ("2. 네. 지금 수속 밟는 중이에요.")
printl ("3. …")
local x = ask(">", "1", "2", "3")
if x == "1" then
	sayw ("노신사", "그렇군요. 어떤가요, 지금 기분이?")
elseif x == "2" then
	sayw ("노신사", "오오, 그런가요. 새로운 곳에 와서 두근두근한가요?")
else
	sayw ("노신사", "하하, 긴장하지 않아도 되네. 해치지 않아요.",
	"두근두근해서 어쩔 수가 없는 가 보지요?")
end
printl ("1. 하하, 새로운 일이 생길거라 생각하니 두근거립니다.")
printl ("2. 뭐 별 생각 없는 것 같은데요….")
printl ("3. ……글쎄요?")
local x = ask(">", "1", "2", "3")
if x == "1" then
	sayw ("노신사", "오호, 과연...")
	printpara ("노신사는 무언가를 이해했다는 표정으로 끄덕거린다.")
elseif x == "2" then
	sayw ("노신사", "음! 그럴지도 모르지. 나도 그랬으니까.",
	"두근거릴 때도 있었지만 그보다는 주로 떨떠름했어요.")
	printpara ("노신사는 잠깐 추억을 회상하듯 오른쪽 위를 올려다본다.")
else
	sayw ("노신사", "하하, 그래 그래. ",
	"나도 대학에 입학할 때 딱 그랬어요.")
	printpara ("노신사는 껄껄 웃으며 기뻐한다.")
end
sayw ("노신사", "사실 새로운 곳에 오면 언제나 새로운 일이 생기기 마련이네.",
"어떤 일은 자기가 원인이 되기도 하지만, 어떤 일들은 자기 의지와는 상관없이",
"주변 사람들에게 휘말려 겪게 되는 일이기도 하답니다.",
"…나도 이 학교에 임용되었을 때는, 지금 내가 이러리라곤 상상할 수 없었는데…")
printpara ("노인은 잠시 생각에 잠긴 표정을 지었다.",
"약간의 침묵이 흐른다.")
sayw ("노신사", "어쨌든, 대학에서 많은 재미있는 일을 경험하기를 바라요.",
"아, 그래……")
printpara ("백발의 신사는 내 얼굴을 잠시 응시하더니, 생각에 빠진 표정이다.",
"조금 고민하듯 손으로 입을 가리며 낮은 신음을 뱉더니,",
"코트의 안주머니에서 무언가를 꺼낸다. 펜 케이스다.")
sayw ("노신사", "여기서 만난 것도 인연이겠지.",
"뭐 대단한 건 아니지만 자네가 가지세요. 선물일세.",
"그냥 펜이야 펜.")
printpara ("신사는 그렇게 말하고 내게 펜 케이스를 내민다.")
printl ("1. 어... 마음은 감사하지만 사양하겠습니다.")
printl ("2. 네? 왜 이런 걸 제게...")
printl ("3. 감사히 받겠습니다.")
local x = ask(">", "1", "2", "3")
if x == "1" then
	printpara ("그러나 노신사의 박력에 휘말려 받아버리고 말았다….")
elseif x == "2" then
	sayw ("노신사", "뭐, 원래 주기로 한 학생이 있었는데,",
	"이 학교에 오지 않을 모양인 것 같아서 말이지.",
	"원래 난 쓸 일이 없으니 버리긴 아쉽거든.")
	printpara ("노인은 살짝 곤란하단 표정을 지었다.",
	"일단 펜 케이스는 그의 손에서 내 손으로 넘어왔다.")
else
	sayw ("노신사", "하하, 이건 살짝 의외로군.",
	"거절할 줄 알았는데 말이야.")
	printpara ("장난을 치는 줄 알았는데 그런 건 아닌 것 같다.",
	"엉겁결에 받아 버렸다….")
end
sayw("노신사", "이 새로운 환경에서, 자네는 많은 것을 배우게 되겠지.",
"하지만 배우는 것만이 다는 아닙니다. 여러 사람을 만나고, 그 사람들을 대하다 보면,",
"상상도 못 할 일에 휘말리기도 하겠지요.",
"이 펜을, 그런 납득하지 못할 일들의 하나의 맛보기라고 생각하세요. 허허.")
printpara ("이것저것 납득하기 어렵지만, 일단 존대를 하는건지 평대를 하는건지 하대를 하는건지부터 어렵다….",
"남자 직원이 부르는 소리가 들린다. 신사에게 가볍게 인사를 하고 펜을 가방에 넣었다.",
"직원의 설명을 듣고 뒤를 돌아봤을 때는, 이미 노인은 자리를 비우고 없었다…….")

printcurrenttime (3, 11)
printl ("")
printplace("미래과학원 캠퍼스")
#end