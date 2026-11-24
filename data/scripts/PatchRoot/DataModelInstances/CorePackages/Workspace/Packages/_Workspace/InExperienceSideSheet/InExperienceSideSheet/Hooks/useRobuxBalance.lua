-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")
local InExperienceSideSheetParent = InExperienceSideSheet.Parent

local React = require(InExperienceSideSheetParent.React)
local SignalsReact = require(InExperienceSideSheetParent.SignalsReact)

local fetchRobuxBalance = require(InExperienceSideSheet.Utils.fetchRobuxBalance)
local getSideSheetVisibility = require(InExperienceSideSheet.Utils.getSideSheetVisibility)

local function useRobuxBalance()
    local var1, var2 = React.useState(nil)
    local var3 = React.useRef(true)
    local var4 = SignalsReact.useSignalState(getSideSheetVisibility)

    React.useEffect(function()
        var3.current = true
        return function()
            var3.current = false
        end
    end, {})

    local var5 = React.useCallback(function()
        fetchRobuxBalance(function(num1: number)
            if var3.current then
                var2(num1)
            end
        end)
    end, {})

    React.useEffect(function()
        if var4 then
            var5()
        end
    end, { var4, var5 })

    return var1
end

return useRobuxBalance
