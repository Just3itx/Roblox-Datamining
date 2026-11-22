-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PromptsServerDrivenUi = script:FindFirstAncestor("PromptsServerDrivenUi")
local PromptsServerDrivenUiParent = PromptsServerDrivenUi.Parent

local React = require(PromptsServerDrivenUiParent.React)

local SharedFlags = require(PromptsServerDrivenUiParent.SharedFlags)
local FFlagLuaAppSduiMovePromptsActions = SharedFlags.FFlagLuaAppSduiMovePromptsActions

local FFlagSduiRequestPushNotificationPermissionActionHandler = SharedFlags.FFlagSduiRequestPushNotificationPermissionActionHandler
local FFlagSduiMilestoneCountActions = SharedFlags.FFlagSduiMilestoneCountActions
local registerPromptsActions = require(PromptsServerDrivenUi.Actions.registerPromptsActions)
local registerPromptsImpressions = require(PromptsServerDrivenUi.Impressions.registerPromptsImpressions)

return React.memo(function() -- name: SduiPromptsRegister
    React.useEffect(function()
        if FFlagLuaAppSduiMovePromptsActions
            or FFlagSduiRequestPushNotificationPermissionActionHandler
            or FFlagSduiMilestoneCountActions
        then
            registerPromptsActions()
        end
        registerPromptsImpressions()
    end, {})
    return nil
end)
