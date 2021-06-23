--[[
By：一方
Email：Skaberen@outlook.com
]]--

local resultCount = 0
local result = {}
local zero = {}
local data = {}
local tmp = {}
local energy = {}
local energy_status = false
local mFreeze1 = false
local mFreeze2 = false
local xyz = {}

function readValue(address)
	local Orange = {}
	Orange[1] = {}
	Orange[1].address = address
	Orange[1].flags = gg.TYPE_DWORD
	Orange = gg.getValues(Orange)
	return Orange[1].value
end

function get_zero()
	zero[1] = {}
	zero[1].address = result[1].address + 28
	zero[1].flags = gg.TYPE_FLOAT
	zero = gg.getValues(zero)
	zero = zero[1]
	gg.toast("人物坐标获取完毕")
end

function get_energy(address)
	energy[1] = {}
	energy[1].address = address
	energy[1].flags = gg.TYPE_FLOAT
	energy = gg.getValues(energy)
	energy = energy[1]
end

function getEnergy()
	gg.clearResults()
	gg.setRanges(gg.REGION_C_ALLOC)
	gg.searchNumber("338", 4, false, gg.SING_EQUAL, 0, -1)
	gg.refineNumber("338", 4, false, gg.SING_EQUAL, 0, -1)
	resultCount = gg.getResultCount()
	result = gg.getResults(resultCount)

	for k, v in pairs(result) do
		v.isMatch = true
	end
	
	tmp = {}
	for i, v in ipairs(result) do
		tmp[#tmp+1] = {}
		tmp[#tmp].address = v.address - 8
		tmp[#tmp].flags = 4
	end
	tmp = gg.getValues(tmp)
	for i, v in ipairs(tmp) do
		if "" .. v.value ~= "48" then
			result[i].isMatch = false
		end
	end

	tmp = {}
	for i, v in ipairs(result) do
		tmp[#tmp+1] = {}
		tmp[#tmp].address = v.address + 4
		tmp[#tmp].flags = 4
	end
	tmp = gg.getValues(tmp)
	for i, v in ipairs(tmp) do
		if "" .. v.value ~= "0" then
			result[i].isMatch = false
		end
	end
	
	tmp = {}
	for i, v in ipairs(result) do
		tmp[#tmp+1] = {}
		tmp[#tmp].address = v.address + 8
		tmp[#tmp].flags = 4
	end
	tmp = gg.getValues(tmp)
	for i, v in ipairs(tmp) do
		if "" .. v.value ~= "256" then
			result[i].isMatch = false
		end
	end
	
	for i, v in ipairs(result) do
		if (v.isMatch) then
    		data[#data+1] = v.address
    	end
	end
end

function setEnergy()
	tmp = {}
	--for i=1, #data do
		tmp[#tmp+1] = {}
		tmp[#tmp].address = data[1] + 12
		tmp[#tmp].flags = 16
		tmp[#tmp].value = 9999
		if energy_status == true then
			tmp[#tmp].freeze = false
		else
			tmp[#tmp].freeze = true
		end
	--end
	gg.setValues(tmp)
	if energy_status == true then
		gg.removeListItems(tmp)
		gg.toast("能量锁定开关：解锁")
		energy_status = false
	else
		gg.addListItems(tmp)
		gg.toast("能量锁定开关：锁定")
		energy_status = true
	end
end


function Teleport(xyz)
	tmp = {}
	for i=1, 3 do
		tmp[#tmp+1] = {}
		tmp[#tmp].address = zero.address + i * 4
		tmp[#tmp].flags = gg.TYPE_FLOAT
		tmp[#tmp].value = xyz[i]
	end
	gg.setValues(tmp)
end

gg.setVisible(false)
getEnergy() setEnergy()
gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber("3434", 4, false, gg.SING_EQUAL, 0, -1)
gg.refineNumber("3434", 4, false, gg.SING_EQUAL, 0, -1)
resultCount = gg.getResultCount()
if resultCount == 0 then
	gg.toast("人物坐标获取失败")
	os.exit()
end
result = gg.getResults(resultCount)

for k, v in pairs(result) do
	v.isMatch = true
end

tmp = {}
for i, v in ipairs(result) do
	tmp[#tmp+1] = {}
	tmp[#tmp].address = v.address - 8
	tmp[#tmp].flags = 4
end

tmp = gg.getValues(tmp)
for i, v in ipairs(tmp) do
	if "" .. v.value == "56" then
		result[1] = tmp[i]
		break
	end
end

get_zero()
gg.clearResults()

--晨岛
local map1 = {}
local gdCount1 = 0
--晨岛光翼坐标
map1[1] = {}
map1[1][1] = {117.49571990967,2.14908671379,310.85702514648}
map1[1][2] = {52.27350234985,34.10396575928,369.94454956055}
map1[1][3] = {281.88159179688,2.22269964218,188.94566345215}
map1[1][4] = {107.01401519775,24.28181648254,48.49942779541}
map1[1][5] = {414.75527954102,94.82239532471,-6.64422082901}

--云野
local map2 = {}
local gdCount2 = 0
--云野光翼坐标
map2[1] = {}
map2[1][1] = {125.85375213623;148.40830993652;-27.92642974854}
map2[1][2] = {106.17017364502;174.64419555664;26.75840377808}
map2[1][3] = {80.72425842285;160.55029296875;62.6540222168}
map2[1][4] = {-181.66676330566;198.77201843262;24.45411109924}
map2[1][5] = {-214.19834899902;179.97434997559;152.96817016602}
map2[1][6] = {27.35553359985;184.77207946777;278.81311035156}
map2[1][7] = {101.27056884766;181.26351928711;257.22482299805}
map2[1][8] = {66.5023727417;186.11111450195;376.91757202148}
map2[1][9] = {-19.33318710327;58.91622924805;27.37077331543}
map2[1][10] = {137.93855285645;266.59573364258;478.81997680664}
map2[1][11] = {146.46572875977;304.30899047852;537.32904052734}
map2[1][12] = {290.13339233398;200.00207519531;178.79241943359}
map2[1][13] = {348.18463134766;197.88877868652;111.59169006348}


--雨林
local map3 = {}
local gdCount3 = 0
--雨林光翼坐标
map3[1] = {}
map3[1][1] = {2.13302397728;114.62173461914;-257.74035644531}
map3[1][2] = {27.27236175537;98.32046508789;-117.29396820068}
map3[1][3] = {24.22917366028;127.21475982666;-64.9084777832}
map3[1][4] = {80.36828613281;129.32788085938;-12.00599861145}
map3[1][5] = {66.24879455566;99.87233734131;45.67139816284}
map3[1][6] = {104.18180084229;111.61292266846;-111.34979248047}
map3[1][7] = {-44.52954101562;103.50183868408;-18.99171257019}
map3[1][8] = {-20.89667510986;96.37775421143;23.3992023468}
map3[1][9] = {26.23741531372;78.26388549805;-416.63986206055}
map3[1][10] = {9.87658882141;137.31497192383;-213.43074035645}
map3[1][11] = {-65.82335662842;208.65147399902;-202.29818725586}
map3[1][12] = {-68.73613739014;210.23043823242;-295.44775390625}
map3[1][13] = {-22.06701850891;141.86561584473;273.64901733398}
map3[1][14] = {-50.04446792603;149.48065185547;58.78827285767}
map3[1][15] = {117.94002532959;178.50863647461;157.54365539551}
map3[1][16] = {32.15616989136;111.79304504395;58.49747848511}

--霞谷
local map4 = {}
local gdCount4 = 0
--霞谷光翼坐标
map4[1] = {}
map4[1][1] = {-151.72290039062;263.46438598633;-149.25282287598}
map4[1][2] = {165.65696716309;41.44527816772;-540.47784423828}
map4[1][3] = {198.90878295898;48.46887969971;-517.16070556641}
map4[1][4] = {84.07421112061;558.27600097656;-55.4520111084}
map4[1][5] = {115.62945556641;502.25119018555;-38.70120239258}
map4[1][6] = {-396.41152954102;1163.42333984375;47.16595458984}
map4[1][7] = {67.96189880371;1053.02795410156;-28.98570251465}
map4[1][8] = {40.33958816528;185.05342102051;73.34194946289}
map4[1][9] = {-15.27802371979;174.11576843262;-269.24426269531}
map4[1][10] = {-26.86660766602;150.21412658691;-164.30195617676}
map4[1][11] = {195.60102844238;630.80944824219;-421.51663208008}

--暮土
local map5 = {}
local gdCount5 = 0
--暮土光翼坐标
map5[1] = {}
map5[1][1] = {97.71636962891;45.43786621094;367.83847045898}
map5[1][2] = {28.56142425537;0.46644225717;342.9616394043}
map5[1][3] = {83.6520690918;92.54627990723;185.87461853027}
map5[1][4] = {67.59731292725;98.88622283936;120.99040222168}
map5[1][5] = {91.61358642578;77.99578094482;-55.83699417114}
map5[1][6] = {-12.41992855072;64.98532104492;-91.22381591797}
map5[1][7] = {15.34145832062;83.91411590576;-139.27084350586}
map5[1][8] = {28.08928108215;71.11177062988;-222.40245056152}
map5[1][9] = {-22.72827911377;32.4552230835;527.53137207031}
map5[1][10] = {-165.06657409668;1.70548176765;369.33148193359}
map5[1][11] = {-293.2229309082;3.22860455513;335.40350341797}
map5[1][12] = {-205.31097412109;130.31030273438;-160.40197753906}
map5[1][13] = {-238.10581970215;86.01084136963;-394.50183105469}
map5[1][14] = {4.47481489182;202.44841003418;32.13433074951}
map5[1][15] = {112.59884643555;141.60664367676;385.39486694336}
map5[1][16] = {305.02200317383;121.83631896973;559.58319091797}
--暮土蜡烛
map5[2] = {}
--暮土新图蘑菇[地下]  318.0;98.0;330.5:9
map5[2][1] = {317.73278808594,97.43845367432,330.6784362793}
--暮土新图蘑菇[天上]
map5[2][2] = {403.5309753418,143.61166381836,431.58117675781}

--禁阁
local map6 = {}
local gdCount6 = 0
--禁阁光翼坐标
map6[1] = {}
map6[1][1] = {20.43115615845;46.78216171265;-67.82855987549}
map6[1][2] = {55.50157928467;540.70965576172;-33.98306274414}
map6[1][3] = {78.94891357422;554.41192626953;-41.106590271}
map6[1][4] = {33.94861221313;160.77113342285;-41.95145797729}
map6[1][5] = {48.09609985352;228.29138183594;8.88393878937}
map6[1][6] = {-39.25553512573;140.63380432129;9.49728012085}
map6[1][7] = {-0.35613438487;303.56619262695;58.07741546631}

--伊甸
local map7 = {}
map7[1] = {17.47722816467;84.40920257568;53.04370117188}
map7[2] = {11.57853412628;84.40986633301;50.03913879395}
map7[3] = {14.22674560547;84.41098022461;44.50893783569}
map7[4] = {9.37716960907;84.41114044189;40.08240127563}
map7[5] = {10.35514259338;84.64693450928;35.56671524048}
map7[6] = {0.02939226851;84.40908813477;31.76880645752}
map7[7] = {-4.90946245193;84.40901184082;37.90031051636}
map7[8] = {-10.17144775391;84.39978790283;24.05815696716}
map7[9] = {-0.93241721392;84.41564178467;28.0644493103}
map7[10] = {1.25366163254;84.69709014893;24.01716804504}
map7[11] = {3.21035528183;84.4252243042;20.39665603638}
map7[12] = {3.96351885796;84.41110992432;17.2168006897}
map7[13] = {12.97935581207;84.84692382812;21.35214614868}
map7[14] = {16.84648323059;87.61931610107;20.07873916626}
map7[15] = {-17.98000717163;84.39649200439;10.90452861786}
map7[16] = {-6.16879796982;84.55124664307;7.2030749321}
map7[17] = {7.0953669548;85.68338012695;5.2389588356}
map7[18] = {-6.1073923111;84.55041503906;7.21422481537}
map7[19] = {-18.68507194519;84.41075897217;0.88019108772}
map7[20] = {-18.79967689514;84.41102600098;-14.84161758423}
map7[21] = {11.22110652924;84.69986724854;-14.70520019531} --21/22
map7[22] = {5.12035131454;84.41073608398;-24.96887779236} --23
map7[23] = {-1.0535929203;84.53310394287;-24.63909912109} --24
map7[24] = {-4.54042053223;84.5344543457;-39.81888198853} --25
map7[25] = {-23.44972419739;84.41054534912;-37.3302230835} --26
map7[26] = {-11.13687324524;84.41089630127;-58.69815826416} --27/28
map7[27] = {5.60161495209;84.62409210205;-50.61780929565} --29/30/31
map7[28] = {15.19728565216;84.41095733643;-53.21044540405} --32/33
map7[29] = {-12.55942440033;84.41078186035;-74.78955078125} --34/35
map7[30] = {-2.24200773239;84.4107131958;-81.82543182373} --36
map7[31] = {8.11030101776;84.41075897217;-91.22216796875} --37
map7[32] = {18.90334701538;84.803855896;-91.00427246094} --38/39
map7[33] = {0.68279963732;84.41007995605;-98.69891357422} --40
map7[34] = {0.58642220497;84.53990936279;-103.48983001709} --41
map7[35] = {3.32940912247;84.46800231934;-119.61359405518} --42/43
map7[36] = {-5.17984676361;84.41087341309;-123.36358642578} --44
map7[37] = {3.15082359314;84.49433898926;-129.69897460938} --45
map7[38] = {-0.97932183743;84.54180145264;-139.57426452637} --46
map7[39] = {16.32238388062;84.7544631958;-139.42512512207} --47
map7[40] = {-2.05016970634;84.50484466553;-148.01948547363} --48
map7[41] = {15.9657201767;84.41068267822;-153.97187805176} --49
map7[42] = {10.58512973785;84.58918762207;-156.13168334961} --50/51
map7[43] = {-4.30059909821;84.41063690186;-163.17515563965} --52
map7[44] = {0.1790844053;84.55098724365;-174.20867919922} --53
map7[45] = {8.68859958649;84.50891113281;-175.93884277344} --54
map7[46] = {-3.25369668007;84.41101837158;-181.52870178223} --55
map7[47] = {2.40995311737;84.42552947998;-185.79586791992} --56
map7[48] = {-0.09431309253;84.47621917725;-190.13664245605} --57
map7[49] = {7.70384645462;84.4935836792;-191.10147094727} --58
map7[50] = {0.1339070648;84.4103012085;-207.03192138672} --59
map7[51] = {-2.2868347168;84.77942657471;-211.03533935547} --60
map7[52] = {8.61554431915;83.96537017822;-245.39093017578} --61
map7[53] = {0.634745121;83.96576690674;-251.7315826416} --62
map7[54] = {8.61939811707;83.82987213135;-271.44711303711} --63

function Main()
  menu = gg.choice({
  "1. 晨岛 - 瞬移",
  "2. 云野 - 瞬移",
  "3. 雨林 - 瞬移",
  "4. 霞谷 - 瞬移",
  "5. 暮土 - 瞬移",
  "6. 禁阁 - 瞬移",
  "7. 暴风 - 瞬移",
  "8. 彩蛋 - 瞬移",
  "9. 其他 - 功能",
  "0. 退出   脚本"
 }, nil, "YiFang Sky Teleport Script --- Ver1.9.5")
  if menu == 1 then A() end
  if menu == 2 then B() end
  if menu == 3 then C() end
  if menu == 4 then D() end
  if menu == 5 then E() end
  if menu == 6 then F() end
  if menu == 7 then G() end
  if menu == 8 then H() end
  if menu == 9 then I() end
  if menu == 10 then Exit() end
end

--晨岛
function A()
  G1 = 1
  menu1 = gg.multiChoice({
    "1. 光翼[上一个]",
    "2. 光翼[下一个]",
    "0. 返回主页"
  }, nil, "晨岛 - 瞬移")
  if menu1 == nil then else
  if menu1[1] == true then a1() end
  if menu1[2] == true then a2() end
  if menu1[3] == true then HOME() end end
end

--晨岛光翼[上一个]
function a1()
	if gdCount1 == 0 then
		gg.toast("没有上一个瞬移坐标了")
	else
		gdCount1 = gdCount1 - 1
		xyz = map1[1][gdCount1]
		Teleport(xyz)
		gg.toast("瞬移晨岛光翼 [" .. gdCount1 .. "] 完成")
	end
end

--晨岛光翼[下一个]
function a2()
	if gdCount1 == 5 then
		gg.toast("没有下一个瞬移坐标了")
	else
		gdCount1 = gdCount1 + 1
		xyz = map1[1][gdCount1]
		Teleport(xyz)
		gg.toast("瞬移晨岛光翼 [" .. gdCount1 .. "] 完成")
	end
end

--云野
function B()
  G2 = 1
  menu2 = gg.multiChoice({
    "1. 光翼[上一个]",
    "2. 光翼[下一个]",
    "0. 返回主页"
  }, nil, "云野 - 瞬移")
  if menu2 == nil then else
  if menu2[1] == true then b1() end
  if menu2[2] == true then b2() end
  if menu2[3] == true then HOME() end end
end

--云野光翼[上一个]
function b1()
	if gdCount2 == 0 then
		gg.toast("没有上一个瞬移坐标了")
	else
		gdCount2 = gdCount2 - 1
		xyz = map2[1][gdCount2]
		Teleport(xyz)
		gg.toast("瞬移云野光翼 [" .. gdCount2 .. "] 完成")
	end
end

local map2_right_in = 0 --右侧隐藏图入口
local map2_right_out = 0 --右侧隐藏图出口
local map2_eight_in = 0 --八人图入口
local map2_eight_out = 0 --八人图出口
local map2_left_in = 0 --左侧隐藏图入口
--云野光翼[下一个]
function b2()
	if gdCount2 == 13 then
		gg.toast("没有下一个瞬移坐标了")
	else
		gdCount2 = gdCount2 + 1
		if gdCount2 == 4 and map2_right_in ~= 1 then
			Teleport({-9.7918510437;165.37245178223;-5.74012947083})
			gg.toast("已瞬移至 [云野右侧隐藏图入口] ，请手动进入")
			gdCount2 = gdCount2 - 1
			map2_right_in = 1
			return 0
		end
		if gdCount2 == 6 and map2_right_out ~= 1 then
			Teleport({-104.2032699585;184.77220153809;172.62110900879})
			gg.toast("已瞬移至 [云野右侧隐藏图出口] ，请手动进入")
			gdCount2 = gdCount2 - 1
			map2_right_out = 1
			return 0
		end
		if gdCount2 == 9 and map2_eight_in ~= 1 then
			Teleport({-48.94686126709;181.93348693848;322.91494750977})
			gg.toast("已瞬移至 [云野八人图入口] ，请手动进入")
			gdCount2 = gdCount2 - 1
			map2_eight_in = 1
			return 0
		end
		if gdCount2 == 10 and map2_eight_out ~= 1 then
			Teleport({31.82697105408;42.34567260742;0.20620749891})
			gg.toast("已瞬移至 [云野八人图出口] ，请手动进入")
			gdCount2 = gdCount2 - 1
			map2_eight_out = 1
			return 0
		end
		if gdCount2 == 12 and map2_left_in ~= 1 then
			Teleport({157.29043579102;200.01664733887;226.44515991211})
			gg.toast("已瞬移至 [云野左侧隐藏图入口] ，请手动进入")
			gdCount2 = gdCount2 - 1
			map2_left_in = 1
			return 0
		end
		xyz = map2[1][gdCount2]
		Teleport(xyz)
		gg.toast("瞬移云野光翼 [" .. gdCount2 .. "] 完成")
	end
end

local map3_main1 = 0 --主地图入口1
local map3_right1 = 0 --右侧隐藏图入口
local map3_right2 = 0 --管道入口
local map3_right3 = 0 --管道出口
local map3_right4 = 0 --右侧隐藏图出口
local map3_main2 = 0 --主地图入口2
--雨林
function C()
  G3 = 1
  menu3 = gg.multiChoice({
    "1. 光翼[上一个]",
    "2. 光翼[下一个]",
    "0. 返回主页"
  }, nil, "雨林 - 瞬移")
  if menu3 == nil then else
  if menu3[1] == true then c1() end
  if menu3[2] == true then c2() end
  if menu3[3] == true then HOME() end end
end

--雨林光翼[上一个]
function c1()
	if gdCount3 == 0 then
		gg.toast("没有上一个瞬移坐标了")
	else
		gdCount3 = gdCount3 - 1
		xyz = map3[1][gdCount3]
		Teleport(xyz)
		gg.toast("瞬移雨林光翼 [" .. gdCount3 .. "] 完成")
	end
end

--雨林光翼[下一个]
function c2()
	if gdCount3 == 16 then
		gg.toast("没有下一个瞬移坐标了")
	else
		gdCount3 = gdCount3 + 1
		if gdCount3 == 3 and map3_main1 ~=1 then
			Teleport({28.37304496765;98.56972503662;-113.70115661621})
			gg.toast("已瞬移至 [雨林主地图入口1] ，请手动进入")
			gdCount3 = gdCount3 - 1
			map3_main1 = 1
			return 0
		end
		if gdCount3 == 7 and map3_right1 ~=1 then
			Teleport({6.97025537491;111.52809143066;-61.51174545288})
			gg.toast("已瞬移至 [雨林右侧隐藏图入口] ，请手动进入")
			gdCount3 = gdCount3 - 1
			map3_right1 = 1
			return 0
		end
		if gdCount3 == 9 and map3_right2 ~=1 then
			Teleport({54.73643493652;72.44387817383;43.95704650879})
			gg.toast("已瞬移至 [雨林隐藏图管道入口] ，请手动进入")
			gdCount3 = gdCount3 - 1
			map3_right2 = 1
			return 0
		end
		if gdCount3 == 13 then
			if map3_right3 ~=1 then
				Teleport({-64.44444274902;210.3430480957;-285.0309753418})
				gg.toast("已瞬移至 [雨林隐藏图管道出口] ，请手动进入")
				gdCount3 = gdCount3 - 1
				map3_right3 = 1
				return 0
			end
			if map3_right4 ~=1 then
				Teleport({16.11902427673;88.39250183105;122.1976776123})
				gg.toast("已瞬移至 [雨林右侧隐藏图出口] ，请手动进入")
				gdCount3 = gdCount3 - 1
				map3_right4 = 1
				return 0
			end
		end
		if gdCount3 == 16 and map3_main2 ~=1 then
			Teleport({-18.18656158447;182.64154052734;402.62902832031})
			gg.toast("已瞬移至 [雨林主地图入口2] ，请手动进入")
			gdCount3 = gdCount3 - 1
			map3_main2 = 1
			return 0
		end
		xyz = map3[1][gdCount3]
		Teleport(xyz)
		gg.toast("瞬移雨林光翼 [" .. gdCount3 .. "] 完成")
	end
end

--霞谷
function D()
  G4 = 1
  menu4 = gg.multiChoice({
    "1. 光翼[上一个]",
    "2. 光翼[下一个]",
    "0. 返回主页"
  }, nil, "霞谷 - 瞬移")
  if menu4 == nil then else
  if menu4[1] == true then d1() end
  if menu4[2] == true then d2() end
  if menu4[3] == true then HOME() end end
end

--霞谷光翼[上一个]
function d1()
	if gdCount4 == 0 then
		gg.toast("没有上一个瞬移坐标了")
	else
		gdCount4 = gdCount4 - 1
		xyz = map4[1][gdCount4]
		Teleport(xyz)
		gg.toast("瞬移霞谷光翼 [" .. gdCount4 .. "] 完成")
	end
end

local map4_sky1_in = 0 --天空赛道一图入口
local map4_sky1_out = 0 --天空赛道一图出口
local map4_sky2_in = 0 --天空赛道二图入口
local map4_sky2_out = 0 --天空赛道二图出口
local map4_gd11 = 0
--霞谷光翼[下一个]
function d2()
	if gdCount4 == 11 then
		gg.toast("没有下一个瞬移坐标了")
	else
		gdCount4 = gdCount4 + 1
		if gdCount4 == 4 and map4_sky1_in ~=1 then
			Teleport({205.1636505127;56.70009994507;-601.97637939453})
			gg.toast("已瞬移至 [霞谷天空赛道一图入口] ，请手动进入")
			gdCount4 = gdCount4 - 1
			map4_sky1_in = 1
			return 0
		end
		if gdCount4 == 6 and map4_sky1_out ~=1 then
			Teleport({206.68609619141;491.52456665039;-205.85830688477})
			gg.toast("已瞬移至 [霞谷天空赛道一图出口] ，请手动进入")
			gdCount4 = gdCount4 - 1
			map4_sky1_out = 1
			return 0
		end
		if gdCount4 == 8 and map4_sky2_in ~=1 then
			Teleport({149.81336975098;1008.25744628906;-100.43368530273})
			gg.toast("已瞬移至 [霞谷天空赛道二图入口] ，请手动进入")
			gdCount4 = gdCount4 - 1
			map4_sky2_in = 1
			return 0
		end
		if gdCount4 == 10 and map4_sky2_out ~=1 then
			Teleport({60.94206619263;137.83598327637;-292.20584106445})
			gg.toast("已瞬移至 [霞谷天空赛道二图出口] ，请手动进入")
			gdCount4 = gdCount4 - 1
			map4_sky2_out = 1
			return 0
		end
		if gdCount4 == 11 then
			Teleport({290.24816894531;39.45797729492;-527.30267333984})
			gg.toast("已瞬移至 [霞谷地面赛道入口] ，五秒后继续")
			gg.sleep(5000)
			Teleport(map4[1][11])
			gg.toast("瞬移霞谷光翼 [" .. gdCount4 .. "] 完成")
			return 0
		end
		xyz = map4[1][gdCount4]
		Teleport(xyz)
		if gdCount4 == 10 then
			gg.toast("瞬移霞谷光翼 [" .. gdCount4 .. "] 完成，请重新进入霞谷")
		else
			gg.toast("瞬移霞谷光翼 [" .. gdCount4 .. "] 完成")
		end
	end
end

--暮土
function E()
  G5 = 1
  menu5 = gg.multiChoice({
    "1. 光翼[上一个]",
    "2. 光翼[下一个]",
    "3. 新图光翼 - 1",
    "4. 新图光翼 - 2",
    "5. 采蘑菇[地下]",
    "6. 采蘑菇[空中]",
    "0. 返回主页"
  }, nil, "暮土 - 瞬移")
  if menu5 == nil then else
  if menu5[1] == true then e1() end
  if menu5[2] == true then e2() end
  if menu5[3] == true then e3() end
  if menu5[4] == true then e4() end
  if menu5[5] == true then e5() end
  if menu5[6] == true then e6() end
  if menu5[7] == true then HOME() end end
end

--暮土光翼[上一个]
function e1()
	if gdCount5 == 0 then
		gg.toast("没有上一个瞬移坐标了")
	else
		gdCount5 = gdCount5 - 1
		xyz = map5[1][gdCount5]
		Teleport(xyz)
		gg.toast("瞬移暮土光翼 [" .. gdCount5 .. "] 完成")
	end
end

local map5_main1_out = 0 --一图出口
local map5_sunkenship_in = 0 --沉船入口
local map5_sunkenship_out = 0 --沉船出口
local map5_yilong_out = 0 --一龙图出口
--暮土光翼[下一个]
function e2()
	if gdCount5 == 14 then
		gg.toast("没有下一个瞬移坐标了")
	else
		gdCount5 = gdCount5 + 1
		if gdCount5 == 3 and map5_main1_out ~=1 then
			Teleport({-91.85065460205;11.72455883026;158.18051147461})
			gg.toast("已瞬移至 [暮土一图出口] ，请手动进入")
			gdCount5 = gdCount5 - 1
			map5_main1_out = 1
			return 0
		end
		if gdCount5 == 9 and map5_sunkenship_in ~=1 then
			Teleport({189.26557922363;69.34118652344;-73.92557525635})
			gg.toast("已瞬移至 [暮土沉船入口] ，请手动进入")
			gdCount5 = gdCount5 - 1
			map5_sunkenship_in = 1
			return 0
		end
		if gdCount5 == 12 and map5_sunkenship_out ~=1 then
			Teleport({-343.83453369141;35.31271362305;386.27169799805})
			gg.toast("已瞬移至 [暮土沉船出口] ，请手动进入")
			gdCount5 = gdCount5 - 1
			map5_sunkenship_out = 1
			return 0
		end
		if gdCount5 == 14 and map5_yilong_out ~=1 then
			Teleport({-285.36907958984;92.04296112061;-400.69836425781})
			gg.toast("已瞬移至 [暮土一龙图出口] ，请手动进入")
			gdCount5 = gdCount5 - 1
			map5_yilong_out = 1
			return 0
		end
		xyz = map5[1][gdCount5]
		Teleport(xyz)
		if gdCount5 == 14 then
			gg.toast("瞬移暮土光翼 [" .. gdCount5 .. "] 完成，请手动进入暮土新图")
		else
			gg.toast("瞬移暮土光翼 [" .. gdCount5 .. "] 完成")
		end
	end
end

--暮土新图光翼1
function e3()
	xyz = map5[1][15]
	Teleport(xyz)
	gg.toast("瞬移暮土 [新图光翼 - 1] 完成")
end

--暮土新图光翼2
function e4()
	xyz = map5[1][16]
	Teleport(xyz)
	gg.toast("瞬移暮土 [新图光翼 - 2] 完成")
end

--暮土蘑菇[地下]
function e5()
	if mFreeze2 == false then
		xyz = map5[2][1]
		tmp = {}
		if mFreeze1 == true then
			mFreeze1 = false
		else
			mFreeze1 = true
		end
		for i=1, 3 do
			tmp[#tmp+1] = {}
			tmp[#tmp].address = zero.address + i * 4
			tmp[#tmp].flags = gg.TYPE_FLOAT
			tmp[#tmp].value = xyz[i]
			--if i == 2 then
			tmp[#tmp].freeze = mFreeze1
			--end
		end
		gg.setValues(tmp)
		if mFreeze1 == true then
			gg.addListItems(tmp)
			gg.toast("瞬移暮土蘑菇 [地下] 完成，坐标已冻结，解冻请再次执行")
		else
			gg.removeListItems(tmp)
			gg.toast("瞬移暮土蘑菇 [地下] 完成，坐标已解冻")
		end
	else
		gg.toast("请解除 暮土蘑菇[空中] 的坐标冻结后，再执行次功能")
	end
end

--暮土蘑菇[天上]
function e6()
	if mFreeze1 == false then
		xyz = map5[2][2]
		tmp = {}
		if mFreeze2 == true then
			mFreeze2 = false
		else
			mFreeze2 = true
		end
		for i=1, 3 do
			tmp[#tmp+1] = {}
			tmp[#tmp].address = zero.address + i * 4
			tmp[#tmp].flags = gg.TYPE_FLOAT
			tmp[#tmp].value = xyz[i]
			--if i == 2 then
			tmp[#tmp].freeze = mFreeze2
			--end
		end
		gg.setValues(tmp)
		if mFreeze2 == true then
			gg.addListItems(tmp)
			gg.toast("瞬移暮土蘑菇 [天上] 完成，坐标已冻结，解冻请再次执行")
		else
			gg.removeListItems(tmp)
			gg.toast("瞬移暮土蘑菇 [天上] 完成，坐标已解冻")
		end
	else
		gg.toast("请解除 暮土蘑菇[地下] 的坐标冻结后，再执行次功能")
	end
end

--禁阁
function F()
  G6 = 1
  menu6 = gg.multiChoice({
    "1. 光翼[上一个]",
    "2. 光翼[下一个]",
    "0. 返回主页"
  }, nil, "禁阁 - 瞬移")
  if menu6 == nil then else
  if menu6[1] == true then f1() end
  if menu6[2] == true then f2() end
  if menu6[3] == true then HOME() end end
end

--禁阁光翼[上一个]
function f1()
	if gdCount6 == 0 then
		gg.toast("没有上一个瞬移坐标了")
	else
		gdCount6 = gdCount6 - 1
		xyz = map6[1][gdCount6]
		Teleport(xyz)
		gg.toast("瞬移禁阁光翼 [" .. gdCount6 .. "] 完成")
	end
end

local map6_double_in = 0 --双人图入口
local map6_double_out = 0 --双人图入口
--禁阁光翼[下一个]
function f2()
	if gdCount6 == 7 then
		gg.toast("没有下一个瞬移坐标了")
	else
		gdCount6 = gdCount6 + 1
		if gdCount6 == 2 and map6_double_in ~=1 then
			Teleport({-40.40454483032;36.9967956543;-97.50639343262})
			gg.toast("已瞬移至 [禁阁双人图入口] ，请手动进入")
			gdCount6 = gdCount6 - 1
			map6_double_in = 1
			return 0
		end
		if gdCount6 == 4 and map6_double_out ~=1 then
			Teleport({39.8631439209;541.568359375;-15.89660263062})
			gg.toast("已瞬移至 [禁阁双人图出口] ，请手动进入")
			gdCount6 = gdCount6 - 1
			map6_double_out = 1
			return 0
		end
		xyz = map6[1][gdCount6]
		Teleport(xyz)
		gg.toast("瞬移禁阁光翼 [" .. gdCount6 .. "] 完成")
	end
end

--暴风
function G()
  G7 = 1
  menu7 = gg.multiChoice({
    "1. 一图终点",
    "2. 二图终点",
    "3. 自动伊甸",
    "0. 返回主页"
  }, nil, "暴风 - 瞬移")
  if menu7 == nil then else
  if menu7[1] == true then g1() end
  if menu7[2] == true then g2() end
  if menu7[3] == true then g3() end
  if menu7[4] == true then HOME() end end
end

--暴风眼一图终点
function g1()
	Teleport({-3.08880496025;196.74859619141;-21.45963668823})
	gg.toast("瞬移 [暴风眼 - 一图终点] 完成")
end

--暴风眼二图终点   
function g2()
	Teleport({6.62452173233;265.95574951172;-244.71562194824})
	gg.toast("瞬移 [暴风眼 - 二图终点] 完成")
end

--自动伊甸
function g3()
	freeze_time = gg.prompt({
		'请输入瞬移间隔时间，默认 [5000] 豪秒 (1000毫秒 = 1秒)'
	}, {
 		[1] = ""
 	}, {
 		[1] = 'number'
 	})
	if freeze_time == nil then
		freeze_time = 5000
	else
		freeze_time = freeze_time[1]
	end
	gg.toast("3秒后开始执行自动伊甸，瞬移时间间隔：[" .. freeze_time .. "] 豪秒")
	gg.sleep(3000)
	for i = 1, 54 do
		Teleport(map7[i])
		gg.toast("瞬移伊甸 [" .. i .. "] 完成")
		gg.sleep(freeze_time)
	end
end


--彩蛋
function H()
  G8 = 1
  menu8 = gg.multiChoice({
    "1. 晨岛 - 彩虹桥",
    "2. 云野 - 大草原",
    "3. 雨林 - 梅花桩",
    "4. 霞谷 - 千鸟图",
    "5. 禁阁 - 蜡像馆",
    "6. 禁阁 - 闪电岛",
    "0. 返回主页"
  }, nil, "彩蛋 - 瞬移")
  if menu8 == nil then else
  if menu8[1] == true then h1() end
  if menu8[2] == true then h2() end
  if menu8[3] == true then h3() end
  if menu8[4] == true then h4() end
  if menu8[5] == true then h5() end
  if menu8[6] == true then h6() end
  if menu8[7] == true then HOME() end end
end

--晨岛彩虹桥
function h1()
	Teleport({299.99719238281;413.04522705078;-297.63458251953})
	gg.toast("瞬移 [晨岛 - 彩虹桥] 完成")
end

--云野大草原
function h2()
	Teleport({366.3053894043;208.29864501953;233.16668701172})
	gg.toast("瞬移 [云野 - 大草原] 完成")
end

--雨林梅花桩
function h3()
	Teleport({-31.72092056274;207.00308227539;-1.27488076687})
	gg.toast("瞬移 [雨林 - 梅花桩] 完成")
end

--霞谷千鸟图
function h4()
	Teleport({314.90731811523;173.38836669922;-783.63726806641})
	gg.toast("瞬移 [霞谷 - 千鸟图] 完成")
end

--禁阁蜡像馆
function h5()
	Teleport({0.36330926418;195.0870513916;8.39365291595})
	gg.toast("瞬移 [禁阁 - 蜡像馆] 完成")
end

--禁阁闪电岛
function h6()
	Teleport({-0.96439945698;336.14559936523;64.37212371826})
	gg.toast("瞬移 [禁阁 - 闪电岛] 完成")
end

--其他功能
function I()
  G9 = 1
  menu9 = gg.multiChoice({
    "1. 锁定能量[开关]",
    "2. 锁定光翼[开关](暂无)",
    "3. 御虾飞行[死循环]",
    "4. 随行虾宠[死循环]",
    "0. 返回主页"
  }, nil, "其他 - 功能")
  if menu9 == nil then else
  if menu9[1] == true then setEnergy() end
  if menu9[2] == true then i2() end
  if menu9[3] == true then i3() end
  if menu9[4] == true then i4() end
  if menu9[5] == true then HOME() end end
end

--锁定光翼
function i2()
	gg.toast("锁定光翼[开关](暂无)")
end

function i3()

end

function i4()

end



--返回上层
function HOME()
  G1 = -1
  G2 = -1
  G3 = -1
  G4 = -1
  G5 = -1
  G6 = -1
  G7 = -1
  G8 = -1
  G9 = -1
  Main()
end

cs = "Email：Skaberen@outlook.com"

--退出
function Exit()
  print("\r\n光遇瞬移脚本结束，如需购买，请联系：\r\nBy：一方\r\n" .. cs)
  os.exit()
end

while true do
	repeat
	if gg.isVisible(true) then
		gg.setVisible(false)
		if G1 == 1 then A() break end
		if G2 == 1 then B() break end
		if G3 == 1 then C() break end
		if G4 == 1 then D() break end
		if G5 == 1 then E() break end
		if G6 == 1 then F() break end
		if G7 == 1 then G() break end
		if G8 == 1 then H() break end
		if G9 == 1 then I() break end
		Main()
	end
	until true
end
