--[[
By：一方
Email：Skaberen@outlook.com
]]--

local zero = {}
local result = {}
local NT = {}
local tmp = {}
local xyz = {0,0,0}
local x = 0
local y = 0
local z = 0

function readValue(address)
	local Orange = {}
	Orange[1] = {}
	Orange[1].address = address
	Orange[1].flags = 16
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

function TeleportNT(xyz)
	tmp = {}
	for i=1, 3 do
		tmp[#tmp+1] = {}
		tmp[#tmp].address = NT[1] + i * 4
		tmp[#tmp].flags = gg.TYPE_FLOAT
		tmp[#tmp].value = xyz[i]
	end
	gg.setValues(tmp)
end

function getNTAddress()
gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber("365", 4, false, gg.SING_EQUAL, 0, -1)
gg.refineNumber("365", 4, false, gg.SING_EQUAL, 0, -1)
resultCount = gg.getResultCount()
	if resultCount == 0 then
		gg.toast("皮皮虾坐标获取失败")
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
		if "" .. v.value ~= "256" then
			result[i].isMatch = false
		end
	end
	
	tmp = {}
	for i, v in ipairs(result) do
		tmp[#tmp+1] = {}
		tmp[#tmp].address = v.address - 16
		tmp[#tmp].flags = 4
	end
	tmp = gg.getValues(tmp)
	for i, v in ipairs(tmp) do
		if "" .. v.value ~= "256" then
			result[i].isMatch = false
		end
	end
	
	tmp = {}
	for i, v in ipairs(result) do
		tmp[#tmp+1] = {}
		tmp[#tmp].address = v.address + 84
		tmp[#tmp].flags = 4
	end
	tmp = gg.getValues(tmp)
	for i, v in ipairs(tmp) do
		if "" .. v.value ~= "123" then
			result[i].isMatch = false
		end
	end
	
	for i, v in ipairs(result) do
		if (v.isMatch) then
    		NT[#NT + 1] = v.address + 92
    	end
	end
end

gg.setVisible(false)
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
getNTAddress()

gg.toast("执行 [随行虾宠] 完毕")

while true do
	local Orange = {}
	Orange[1] = {}
	Orange[1].address = zero.address + 4
	Orange[1].flags = 16
	Orange[2] = {}
	Orange[2].address = zero.address + 4 + 4
	Orange[2].flags = 16
	Orange[3] = {}
	Orange[3].address = zero.address + 4 + 4 + 4
	Orange[3].flags = 16
	Orange = gg.getValues(Orange)
	TeleportNT({Orange[1].value,Orange[2].value + 10,Orange[3].value})
end