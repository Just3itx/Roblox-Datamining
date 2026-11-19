-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:50:39Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local isScrollingFrameOverflowingY = require(Foundation.Utility.isScrollingFrameOverflowingY)
local useTokens = require(Foundation.Providers.Style.useTokens)

local function useScrollBarPadding()
    local var1, var2 = React.useState(false)
    local var3 = useTokens()
    local var4, var5 = React.useBinding(0)

    return var1, var4, (React.useCallback(function(arg1)
        local var6 = isScrollingFrameOverflowingY(arg1, 1)
        var2(var6)
        var5(if var6 then var3.Size.Size_150 else 0)
    end, { var3.Size.Size_150 }))
end

return useScrollBarPadding
