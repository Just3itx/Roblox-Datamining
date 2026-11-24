-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiObjectUtilsParent = script:FindFirstAncestor("GuiObjectUtils").Parent

local React = require(GuiObjectUtilsParent.React)

local function getRefValue(str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    return if typeof(str1) == "table" then str1.current else str1
end

local function useProperty(str1: string, str2: string)
    local refValue = getRefValue(str1)

    local var1, var2 = React.useState(function()
        return if refValue then refValue[str2] else nil
    end)

    local var3 = React.useCallback(function()
        local refValue2 = getRefValue(str1)

        if refValue2 then
            local var3 = refValue2[str2]
            var2(var3)
        end
    end, { str1, str2 })

    React.useEffect(function()
        local connection = nil
        local refValue2 = getRefValue(str1)

        if refValue2 then
            connection = refValue2:GetPropertyChangedSignal(str2):Connect(var3)

            var3()
        end

        return function()
            if connection then
                connection:Disconnect()
            end
        end
    end, { refValue, str2, var3 })

    return var1
end

return useProperty
