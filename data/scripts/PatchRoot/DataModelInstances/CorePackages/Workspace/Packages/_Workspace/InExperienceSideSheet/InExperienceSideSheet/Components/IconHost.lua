-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")

local InExperienceSideSheetParent = InExperienceSideSheet.Parent

local _Chrome = require(InExperienceSideSheetParent.Chrome)
local React = require(InExperienceSideSheetParent.React)

local Foundation = require(InExperienceSideSheetParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local StatusIndicatorVariant = Foundation.Enums.StatusIndicatorVariant
local StatusIndicator = Foundation.StatusIndicator
local View = Foundation.View

local useNotificationCount = require(InExperienceSideSheet.Hooks.useNotificationCount)

local function IconHost(tbl1)
    local var1 = useTokens()

    local var2, value = useNotificationCount(tbl1.notification)

    return React.createElement(
        View,
        {
            tag = {
                ["size-1000"] = true,
                ["position-center-center anchor-center-center"] = tbl1.centerPosition
            }
        },
        {
            IconContainer = React.createElement(
                View,
                { tag = "size-full align-x-center align-y-center", ZIndex = 1 },
                {
                    Icon = React.createElement(tbl1.icon)
                }
            ),
            NotificationBadge = if var2 then React.createElement(StatusIndicator, {
                value = value,
                variant = StatusIndicatorVariant.Emphasis,
                AnchorPoint = Vector2.new(0, 0),
                Position = UDim2.new(0, var1.Gap.XXLarge, 0, var1.Gap.Small),
                ZIndex = 2
            }) else nil
        }
    )
end

return IconHost
