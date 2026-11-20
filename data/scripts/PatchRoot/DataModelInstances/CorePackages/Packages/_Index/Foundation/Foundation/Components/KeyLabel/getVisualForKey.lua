-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local UserInputService = require(Foundation.Utility.Wrappers).Services.UserInputService

local tbl1 = ({})

return function(arg1)
    if tbl1[arg1] then
        return tbl1[arg1]
    end

    local key = UserInputService:GetImageForKeyCode(arg1)
    if key and key ~= "" then
        return {
            keyVisualType = "Image",
            size = UDim2.fromScale(0.7, 0.7),
            key = key
        }
    end

    local stringForKeyCode = UserInputService:GetStringForKeyCode(arg1)
    local tbl2 = {
        keyVisualType = "String",
        size = UDim2.fromScale(0.8, 0.8),
        key = stringForKeyCode or ""
    }

    tbl1[arg1] = tbl2
    return tbl2
end
