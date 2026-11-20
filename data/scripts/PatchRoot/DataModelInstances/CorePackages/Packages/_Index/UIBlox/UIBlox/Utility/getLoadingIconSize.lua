-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local IconSize = require(scriptParentParentParent.Foundation).Enums.IconSize

local function getLoadingIconSize(uDim2: UDim2?, arg1)
    if uDim2 == nil then
        return nil
    end

    local offset = uDim2.Y.Offset

    if uDim2.Y.Scale > 0 and offset <= 0 then
        return IconSize.Large
    end

    local tbl1 = {
        { IconSize.XSmall, arg1.Size.Size_200 },
        { IconSize.Small, arg1.Size.Size_400 },
        { IconSize.Medium, arg1.Size.Size_900 },
        { IconSize.Large, arg1.Size.Size_1200 }
    }

    local var1 = tbl1[1][1]
    local num1 = math.abs(offset - tbl1[1][2])

    for i = 2, #tbl1 do
        local num2 = math.abs(offset - tbl1[i][2])
        if num2 < num1 then
            var1 = tbl1[i][1]
            num1 = num2
        end
    end

    return var1
end

return getLoadingIconSize
