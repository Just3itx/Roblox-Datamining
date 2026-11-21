-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCard = script:FindFirstAncestor("GameJoinCard")
local GameJoinCardParent = GameJoinCard.Parent

local Foundation = require(GameJoinCardParent.Foundation)
local UserCtaAction = require(GameJoinCardParent.UserCtaCommon).Enums.UserCtaAction

local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize

local GameJoinCardButtonAction = require(GameJoinCard.Analytics.AnalyticsConstants).GameJoinCardButtonAction
local useGameJoinCardAnalytics = require(GameJoinCard.Analytics.useGameJoinCardAnalytics)
local _Types = require(script.Parent.Types)
local getTelemetryFields = require(script.Parent.getTelemetryFields)
local logGamePlayIntent = require(script.Parent.logGamePlayIntent)

local module = {}
module[UserCtaAction.PlayExperience] = function(arg1)
    local experience = arg1.experience
    return {
        id = UserCtaAction.PlayExperience,
        variant = ButtonVariant.Emphasis,
        inputSize = InputSize.Medium,
        width = UDim.new(1, 0),
        isLoading = experience.isLoading,
        text = arg1.localized[UserCtaAction.PlayExperience],
        onActivated = function()
            if arg1.userId ~= "" then
                useGameJoinCardAnalytics.logGameJoinCardButtonEvent(GameJoinCardButtonAction.PlayExperience, getTelemetryFields(arg1))
            end

            logGamePlayIntent(arg1)
            experience.playExperience()
        end
    }
end

return module
