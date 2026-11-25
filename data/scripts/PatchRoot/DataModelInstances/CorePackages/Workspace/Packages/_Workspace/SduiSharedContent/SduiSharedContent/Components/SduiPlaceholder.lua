-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local useTokens = require(SduiSharedContentParent.Foundation).Hooks.useTokens
local _SduiCompat = require(SduiSharedContentParent.SduiCompat)

return React.memo(function(tbl1) -- name: SduiPlaceholder
    local var1 = useTokens()

    local var2 = tbl1.backgroundStyle or var1.Color.Surface.Surface_200
    local cornerRadius = tbl1.cornerRadius or UDim.new(0, var1.Radius.Medium)
    local bool1 = cornerRadius.Offset > 0 or cornerRadius.Scale > 0

    return React.createElement(
        "Frame",
        {
            AnchorPoint = tbl1.anchorPoint,
            AutomaticSize = tbl1.automaticSize,
            BackgroundColor3 = var2.Color3,
            BackgroundTransparency = tbl1.transparencyBinding or 0,
            BorderSizePixel = 0,
            LayoutOrder = tbl1.layoutOrder,
            Position = tbl1.position,
            Size = tbl1.size or UDim2.fromScale(1, 0),
            ZIndex = tbl1.zIndex,
            [React.Tag] = if tbl1.testId then `data-testid={tbl1.testId}` else nil
        },
        {
            UICorner = if bool1 then React.createElement("UICorner", { CornerRadius = cornerRadius }) else nil
        }
    )
end)
