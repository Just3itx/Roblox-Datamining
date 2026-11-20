-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local GuiService = game:GetService("GuiService")

local success, result = pcall(GuiService.GetResolutionScale, GuiService)

local scriptParent = script.Parent
local GetImageSetData = require(scriptParent.Generated.GetImageSetData)

result = if success then result else 1

result = if GuiService:IsTenFootInterface() then 3 else result

local function getResolutionScale()
    local _, var1 = GetImageSetData(result)
    return var1
end

return getResolutionScale
