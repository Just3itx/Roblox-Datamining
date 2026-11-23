-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuyParent = script:FindFirstAncestor("AvatarExperienceInspectAndBuy").Parent
local React = require(AvatarExperienceInspectAndBuyParent.React)
local Foundation = require(AvatarExperienceInspectAndBuyParent.Foundation)
local useTokens = Foundation.Hooks.useTokens

return function(tbl1)
    local var1 = useTokens()

    return React.createElement(Foundation.IconButton, {
        icon = "chevron-large-left",
        Size = tbl1.Size or UDim2.new(0, var1.Size.Size_1000, 1, 0),
        Position = tbl1.Position,
        LayoutOrder = 1,
        onActivated = tbl1.onBackButtonClick or function() end
    })
end
