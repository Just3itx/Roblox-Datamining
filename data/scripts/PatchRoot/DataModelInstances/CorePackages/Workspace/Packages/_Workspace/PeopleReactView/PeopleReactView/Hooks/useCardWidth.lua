-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactView = script:FindFirstAncestor("PeopleReactView")
local PeopleReactViewParent = PeopleReactView.Parent

local React = require(PeopleReactViewParent.React)

local calculateCardLayout = require(PeopleReactView.Utils.calculateCardLayout)

local function useCardWidth()
    local var1, var2 = React.useBinding(0)

    return var1, (React.useCallback(function(num1: number, num2: number, num3: number)
        local cardLayout = calculateCardLayout(num1, num2, num3)
        var2(cardLayout)
        return cardLayout
    end, {}))
end

return useCardWidth
