-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCard = script:FindFirstAncestor("GameJoinCard")
local GameJoinCardParent = GameJoinCard.Parent

local Foundation = require(GameJoinCardParent.Foundation)
local React = require(GameJoinCardParent.React)
local UserCtaAction = require(GameJoinCardParent.UserCtaCommon).Enums.UserCtaAction

local InputSize = Foundation.Enums.InputSize

local AgeCheckUpsellCTA = require(GameJoinCard.Components.AgeCheckUpsellCTA)
local GameJoinCardButtonAction = require(GameJoinCard.Analytics.AnalyticsConstants).GameJoinCardButtonAction
local useGameJoinCardAnalytics = require(GameJoinCard.Analytics.useGameJoinCardAnalytics)
local _Types = require(script.Parent.Types)
local getTelemetryFields = require(script.Parent.getTelemetryFields)

local module = {}
module[UserCtaAction.UnlockExperience] = function(arg1)
    return {
        id = UserCtaAction.UnlockExperience,
        inputSize = InputSize.Medium,
        width = UDim.new(1, 0),
        text = arg1.localized[UserCtaAction.UnlockExperience],
        keepOpenOnActivate = true,
        render = function(arg2, layoutOrder)
            return React.createElement(
                AgeCheckUpsellCTA,
                {
                    onUnlockPressed = arg2.onActivated,
                    LayoutOrder = layoutOrder,
                    focusRef = arg2.focusRef
                }
            )
        end,
        onActivated = function()
            useGameJoinCardAnalytics.logGameJoinCardButtonEvent(GameJoinCardButtonAction.AgeCheckUnlock, getTelemetryFields(arg1))

            arg1.joinAgeCheckUpsellFlow()
        end
    }
end

return module
