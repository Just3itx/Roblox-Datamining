-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCard = script:FindFirstAncestor("GameJoinCard")
local GameJoinCardParent = GameJoinCard.Parent

local Foundation = require(GameJoinCardParent.Foundation)
local React = require(GameJoinCardParent.React)
local RobloxAppEnums = require(GameJoinCardParent.RobloxAppEnums)
local SharedFlags = require(GameJoinCardParent.SharedFlags)
local UserCtaAction = require(GameJoinCardParent.UserCtaCommon).Enums.UserCtaAction

local FoundationText = Foundation.Text
local View = Foundation.View
local ControlState = Foundation.Enums.ControlState
local InputSize = Foundation.Enums.InputSize
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance
local useTokens = Foundation.Hooks.useTokens
local AppPage = RobloxAppEnums.AppPage
local FFlagEnableSplitPane = SharedFlags.FFlagEnableSplitPane
local FFlagSocialCarouselBuildPresence = SharedFlags.FFlagSocialCarouselBuildPresence

local AnalyticsConstants = require(GameJoinCard.Analytics.AnalyticsConstants)
local GameJoinCardButtonAction = AnalyticsConstants.GameJoinCardButtonAction
local viewProfileSourceValues = AnalyticsConstants.viewProfileSourceValues
local useGameJoinCardAnalytics = require(GameJoinCard.Analytics.useGameJoinCardAnalytics)
local _Types = require(script.Parent.Types)
local getTelemetryFields = require(script.Parent.getTelemetryFields)
local ViewProfileLink = require(script.Parent.ViewProfileLink)

local function ViewProfileLink2(tbl1)
    local var1 = useTokens()
    local var2, var3 = React.useState(false)
    local onStateChanged = React.useCallback(function(hover)
        var3(hover == ControlState.Hover)
    end, {})

    local createElement = React.createElement
    local var5 = View
    local tbl2 = {
        Name = "ViewProfileButton",
        Size = UDim2.new(1, 0, 0, var1.Size.Size_600),
        tag = "row align-x-center align-y-center",
        onActivated = tbl1.onActivated,
        onStateChanged = onStateChanged,
        stateLayer = {
            affordance = StateLayerAffordance.None
        },
        LayoutOrder = tbl1.LayoutOrder
    }
    local tbl3 = {
        Label = React.createElement(FoundationText, {
            Text = if var2 then `<u>{tbl1.text}</u>` else tbl1.text,
            RichText = true,
            tag = "auto-xy text-title-medium text-align-x-center content-emphasis"
        })
    }
    return createElement(var5, tbl2, tbl3)
end

local module = {}
module[UserCtaAction.ViewProfile] = function(arg1)
    return {
        id = UserCtaAction.ViewProfile,
        inputSize = InputSize.Medium,
        width = UDim.new(1, 0),
        text = arg1.localized[UserCtaAction.ViewProfile],
        render = function(arg2, layoutOrder)
            local createElement = React.createElement
            local var1 = if FFlagSocialCarouselBuildPresence then ViewProfileLink else ViewProfileLink2

            return createElement(var1, {
                text = arg2.text,
                onActivated = function()
                    arg2.onActivated(viewProfileSourceValues.ViewProfileButton)
                end,
                LayoutOrder = layoutOrder
            })
        end,
        onActivated = function(arg2)
            local var1 = arg2 or viewProfileSourceValues.ViewProfileButton
            if arg1.userId ~= "" then
                local telemetryFields = getTelemetryFields(arg1)
                if var1 == viewProfileSourceValues.UserTile then
                    useGameJoinCardAnalytics.logGameJoinCardButtonEvent(GameJoinCardButtonAction.OpenProfileFromUserTile, telemetryFields)
                elseif var1 == viewProfileSourceValues.ViewProfileButton then
                    useGameJoinCardAnalytics.logGameJoinCardButtonEvent(
                        GameJoinCardButtonAction.OpenProfileFromViewProfile,
                        telemetryFields
                    )
                end
            end

            (if FFlagEnableSplitPane then arg1.navigation.push else arg1.navigation.navigate)(
                AppPage.ProfilePlatform,
                {
                    detail = arg1.userId
                }
            )
        end
    }
end

return module
