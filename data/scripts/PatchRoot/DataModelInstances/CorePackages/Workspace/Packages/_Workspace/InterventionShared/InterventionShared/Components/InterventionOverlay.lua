-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InterventionSharedParent = script:FindFirstAncestor("InterventionShared").Parent

local React = require(InterventionSharedParent.React)
local useStyle = require(InterventionSharedParent.UIBlox).Core.Style.useStyle

local function InterventionOverlay(tbl1)
    local var1 = useStyle()
    return React.createElement("TextButton", {
        AutoButtonColor = false,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = var1.Tokens.Color.Common.Scrim.Color3,
        BackgroundTransparency = var1.Tokens.Color.Common.Scrim.Transparency,
        BorderSizePixel = 0,
        Text = "",
        [React.Event.Activated] = tbl1.onDismiss
    }, tbl1.children)
end

return InterventionOverlay
