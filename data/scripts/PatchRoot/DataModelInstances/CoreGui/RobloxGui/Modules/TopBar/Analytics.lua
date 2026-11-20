-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:51:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local CorePackages = game:GetService("CorePackages")
local _GuiService = game:GetService("GuiService")
local _RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local _UserInputService = game:GetService("UserInputService")
local _Players = game:GetService("Players")

local engineFeature = game:GetEngineFeature("RbxAnalyticsServiceExposePlaySessionId")

local Cryo = require(CorePackages.Packages.Cryo)

local scriptParent = script.Parent
local Constants = require(scriptParent.Constants)
require(scriptParent.Flags.GetFFlagEnableTopBarAnalytics)()

local module = ({})
module.__index = module

function module.new()
    local self = setmetatable({
        _target = "client",
        _context = "topbar",
        _defaultProps = {
            universeid = tostring(game.GameId),
            placeid = tostring(game.PlaceId),
            sessionid = RbxAnalyticsService:GetSessionId()
        }
    }, module)

    if engineFeature then
        self._defaultProps.playsessionid = RbxAnalyticsService:GetPlaySessionId()
    end

    function self._sendEvent(eventName: string, arg1)
        local additionalArgs = Cryo.Dictionary.join(self._defaultProps, arg1 or {})
        RbxAnalyticsService:SendEventDeferred(self._target, self._context, eventName, additionalArgs)
        return nil
    end

    function self._onButtonActivated(button: string, bool1: boolean)
        return self._sendEvent(
            Constants.Analytics.EventNameTopBarButtonActivated,
            {
                button = button,
                status = if bool1 then Constants.Analytics.StatusActive else Constants.Analytics.StatusInactive
            }
        )
    end
    return self
end

function module:onChatButtonActivated(bool1: boolean)
    return self._onButtonActivated(Constants.Analytics.ChatButtonName, bool1)
end

function module:onMoreMenuActivated()
    return self._onButtonActivated(Constants.Analytics.MoreMenuButtonName, true)
end

function module:onInventoryActivated(bool1: boolean)
    return self._onButtonActivated(Constants.Analytics.InventoryButtonName, bool1)
end

function module:onLeaderboardActivated(bool1: boolean)
    return self._onButtonActivated(Constants.Analytics.LeaderboardButtonName, bool1)
end

function module:onEmotesActivated(bool1: boolean)
    return self._onButtonActivated(Constants.Analytics.EmotesButtonName, bool1)
end

function module:onShowGamepadNavigationDialog()
    return self._sendEvent(Constants.Analytics.ShowGamepadNavigationDialog)
end

function module:onDismissGamepadNavigationDialog()
    return self._sendEvent(Constants.Analytics.DismissGamepadNavigationDialog)
end

module.default = module.new()
return module
