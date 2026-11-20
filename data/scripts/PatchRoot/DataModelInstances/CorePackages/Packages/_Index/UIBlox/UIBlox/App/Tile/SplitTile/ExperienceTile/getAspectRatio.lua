-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local AspectRatioMode = require(scriptParent.Enum.AspectRatioMode)

local tbl1 = {
    [AspectRatioMode.Wide] = 0.5625,
    [AspectRatioMode.Square] = 1
}

local function getAspectRatio(arg1)
    local var1 = tbl1[arg1]
    if not var1 then
        error("Unkown aspect ratio " .. tostring(arg1))
    end
    return var1
end

return getAspectRatio
