-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:10:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local TextService = require(Foundation.Utility.Wrappers).Services.TextService
local noYield = require(Foundation.Utility.noYield)

local function getTextSizeOffset()
    return noYield(function(arg1, arg2)
        local var1 = arg1 or 0
        local var2 = arg2 or Font.fromEnum(Enum.Font.BuilderSans)

        local success, result = pcall(function()
            return TextService:GetTextSizeOffsetAsync(var1, var2)
        end)
        return if success then result else nil
    end)
end

return getTextSizeOffset
