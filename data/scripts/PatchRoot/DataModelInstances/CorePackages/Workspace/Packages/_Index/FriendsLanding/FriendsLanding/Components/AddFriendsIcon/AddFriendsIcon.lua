-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local dependencies = require(FriendsLanding.dependencies)
local React = dependencies.React
local UIBlox = dependencies.UIBlox
local TextKeys = require(FriendsLanding.Common.TextKeys)

local IconButton = UIBlox.App.Button.IconButton
local Images = UIBlox.App.ImageSet.Images
local Badge = UIBlox.App.Indicator.Badge
local Tooltip = UIBlox.App.Dialog.Tooltip

local Dash = dependencies.Dash
local useState = React.useState
local useLocalization = dependencies.Hooks.useLocalization
local getDeepValue = dependencies.SocialLibraries.Dictionary.getDeepValue

local tbl1 = {
    layoutOrder = 0,
    friendRequestCount = 0,
    onActivated = Dash.noop,
    showTooltip = false
}

return function(tbl2)
    local var1 = Dash.join(tbl1, tbl2)

    local var2, var3 = useState(240)
    local function func1(arg1)
        if arg1 and arg1:FindFirstChild("CallToActionTooltip", true) then
            var3(getDeepValue(arg1, "CallToActionTooltip.TooltipContainer.AbsoluteSize.X") or 240)
        end
    end

    local var4 = useLocalization({ tooltipMessage = TextKeys.NO_FRIENDS_TOOLTIP })

    local createElement = React.createElement
    local var5 = IconButton
    local tbl3 = {
        size = UDim2.fromOffset(0, 0),
        icon = Images["icons/actions/friends/friendAdd"],
        position = var1.position,
        anchorPoint = Vector2.new(1, 0.5),
        layoutOrder = var1.layoutOrder,
        onActivated = var1.onActivated
    }
    local tbl4 = {
        ImagesContainer = React.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                [React.Change.AbsoluteSize] = func1
            },
            {
                FriendRequestsBadge = var1.friendRequestCount > 0
                    and React.createElement(
                        Badge,
                        {
                            position = UDim2.new(0.5, 0, 0.5, 0),
                            anchorPoint = Vector2.new(0, 1),
                            value = var1.friendRequestCount
                        }
                    ),
                CallToActionTooltip = var1.showTooltip
                    and React.createElement(Tooltip, {
                        position = UDim2.new(0, 42.5 - var2, 0, 36),
                        triggerPosition = Vector2.new(0, 0),
                        triggerSize = Vector2.new(36, 0),
                        bodyText = var4.tooltipMessage,
                        forceClickTriggerPoint = true,
                        isDirectChild = true
                    })
            }
        )
    }
    return createElement(var5, tbl3, tbl4)
end
