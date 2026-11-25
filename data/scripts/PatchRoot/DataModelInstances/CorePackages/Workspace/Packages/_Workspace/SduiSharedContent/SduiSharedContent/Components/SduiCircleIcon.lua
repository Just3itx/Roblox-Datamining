-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local useTokens = require(SduiSharedContentParent.Foundation).Hooks.useTokens
local _SduiCompat = require(SduiSharedContentParent.SduiCompat)

local SduiView = require(script.Parent.SduiView)
local SduiIcon = require(script.Parent.SduiIcon)

return React.memo(function(tbl1) -- name: SduiCircleIcon
    local var1 = useTokens()

    local createElement = React.createElement
    local var2 = SduiView
    local tbl2 = {
        tag = "radius-circle align-x-center align-y-center aspect-1-1",
        size = tbl1.size or UDim2.fromScale(1, 1),
        backgroundStyle = tbl1.backgroundStyle or var1.Color.Surface.Surface_100,
        layoutOrder = tbl1.layoutOrder,
        testId = tbl1.testId
    }
    local tbl3 = {
        Icon = if tbl1.iconName then React.createElement(
            SduiIcon,
            {
                name = tbl1.iconName,
                size = tbl1.iconSize,
                testId = if tbl1.testId then tbl1.testId .. "-icon" else nil
            }
        ) else nil
    }
    return createElement(var2, tbl2, tbl3)
end)
