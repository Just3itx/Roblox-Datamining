-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactView = script:FindFirstAncestor("PeopleReactView")
local PeopleReactViewParent = PeopleReactView.Parent

local React = require(PeopleReactViewParent.React)

local useTokens = require(PeopleReactViewParent.Foundation).Hooks.useTokens

local calculateCardLayout = require(PeopleReactView.Utils.calculateCardLayout)

local function useCardLayoutValues()
    local var1 = useTokens()

    local var2, var3 = React.useBinding(0)
    local var4, var5 = React.useBinding(0)
    local var6, var7 = React.useBinding(0)

    return var2, var4, var6, (React.useCallback(function(num1: number, num2: number, num3: number)
        local var8, var9 = calculateCardLayout(num1, num2, num3)
        var7(var9)
        var3(var8)
        var5(var8 + var1.Size.Size_1400)
        return var8
    end, { var1.Size.Size_1400 }))
end

return useCardLayoutValues
