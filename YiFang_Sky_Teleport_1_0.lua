--[[
By：一方
Email：Skaberen@outlook.com
]]--
function readValue(address)
	local Orange = {}
	Orange[1] = {}
	Orange[1].address = address
	Orange[1].flags = gg.TYPE_FLOAT
	Orange = gg.getValues(Orange)
	return Orange[1].value
end

function split(szFullString, szSeparator) 
	local nFindStartIndex = 1 
	local nSplitIndex = 1 
	local nSplitArray = {} 
	while true do 
		local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex) 
		if not nFindLastIndex then 
			nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString)) 
			break 
		end 
		nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1) 
		nFindStartIndex = nFindLastIndex + string.len(szSeparator) 
		nSplitIndex = nSplitIndex + 1 
	end 
	return nSplitArray 
end 

local resultCount = 0
local data = {}
local result = {}
gg.setVisible(false)
gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.toast("开始获取人物坐标")
gg.searchNumber("56;3434::9", 4, false, gg.SING_EQUAL, 0, -1)
resultCount = gg.getResultCount()--搜索结果数量
if resultCount ~= 0 then
	gg.refineNumber("56", 4, false, gg.SING_EQUAL, 0, -1)
	result = gg.getResults(resultCount)--搜索结果数据
else
	gg.toast("获取人物坐标失败，搜索结果为[0]")
end

gg.clearResults()

local gdCount = 0
local xyz = {0,0,0}

--晨岛
local map1 = {}
--晨岛小金人坐标
map1[1] = {}
map1[1][1] = {117.49571990967,2.14908671379,310.85702514648}
map1[1][2] = {52.27350234985,34.10396575928,369.94454956055}
map1[1][3] = {281.88159179688,2.22269964218,188.94566345215}
map1[1][4] = {107.01401519775,24.28181648254,48.49942779541}
map1[1][5] = {414.75527954102,94.82239532471,-6.64422082901}

function Main()
  menu = gg.multiChoice({
  "1.晨岛金人[上一个]",
  "2.晨岛金人[下一个]",
  "0.退出脚本"
 }, nil, "YiFang Sky Telepotr --- Ver1.0")
  if menu == nil then else
  if menu[1] == true then A() end
  if menu[2] == true then B() end
  if menu[3] == true then Exit() end
  end
  XGCK = -1
end

--晨岛金人[上一个]
function A()
	if gdCount == 0 then
		gg.toast("没有上一个瞬移坐标了")
	else
		gdCount = gdCount - 1
		xyz = map1[1][gdCount]
		tmp = {}
		for i=1, 3 do
			tmp[#tmp+1] = {}
			tmp[#tmp].address = result[1].address + 28 + i * 4
			tmp[#tmp].flags = gg.TYPE_FLOAT
			tmp[#tmp].value = xyz[i]
		end
		gg.setValues(tmp)
		gg.toast("瞬移完成")
	end
end

--晨岛金人[下一个]
function B()
	if gdCount == 5 then
		gg.toast("没有下一个瞬移坐标了")
	else
		gdCount = gdCount + 1
		xyz = map1[1][gdCount]
		tmp = {}
		for i=1, 3 do
			tmp[#tmp+1] = {}
			tmp[#tmp].address = result[1].address + 28 + i * 4
			tmp[#tmp].flags = gg.TYPE_FLOAT
			tmp[#tmp].value = xyz[i]
		end
		gg.setValues(tmp)
		gg.toast("瞬移完成")
	end
end


--返回上层
function Home()
  kele0=1
  Main()
end
--退出
function Exit()
  print("\r\nThanks for using")
  os.exit()
end
cs = "QQ：534119219"
while true do
  if gg.isVisible(true) then
    XGCK = 1
    gg.setVisible(false)
 end
  gg.clearResults()
  if XGCK == 1 then
    Main()
  end
end

