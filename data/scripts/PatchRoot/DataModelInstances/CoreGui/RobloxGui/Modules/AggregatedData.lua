-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module
function module.new()
    local result = {}
    setmetatable(result, module)
    return result
end

local function isRbxAssetId(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return str1:find("rbxassetid://")
end

function module.addPlay(tbl1, str1: string, playtime: number, loopcount: number)
    if not isRbxAssetId(str1) then
        return
    end

    str1 = str1:sub(14)

    if tbl1[str1] == nil then
        tbl1[str1] = { playtime = playtime, loopcount = loopcount }
        return
    end
    local var1 = tbl1[str1]
    var1.playtime += playtime
    local var2 = tbl1[str1]
    var2.loopcount += loopcount
end

return module
