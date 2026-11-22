-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PromptsServerDrivenUi = script:FindFirstAncestor("PromptsServerDrivenUi")
local PromptsServerDrivenUiParent = PromptsServerDrivenUi.Parent

local SduiCoreSystem = require(PromptsServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local getSduiActionHandlerRegistry = SduiCoreSystem.getSduiActionHandlerRegistry

local FFlagSduiDismissPromptAction = require(PromptsServerDrivenUiParent.SharedFlags).FFlagSduiDismissPromptAction
local FFlagLuaAppSduiMovePromptsActions = require(PromptsServerDrivenUiParent.SharedFlags).FFlagLuaAppSduiMovePromptsActions

local FFlagSduiRequestPushNotificationPermissionActionHandler = require(PromptsServerDrivenUiParent.SharedFlags).FFlagSduiRequestPushNotificationPermissionActionHandler
local FFlagSduiMilestoneCountActions = require(PromptsServerDrivenUiParent.SharedFlags).FFlagSduiMilestoneCountActions

local function registerPromptsActions()
    local tbl1 = {
        [SduiActionType.DismissPrompt] = FFlagLuaAppSduiMovePromptsActions and FFlagSduiDismissPromptAction and {
            lazyHandler = function()
                return require(PromptsServerDrivenUi.Actions.SduiDismissPromptAction)
            end,
            skipUnifiedLogging = false
        } or nil,
        [SduiActionType.RequestPushNotificationPermission] = FFlagSduiRequestPushNotificationPermissionActionHandler and {
            lazyHandler = function()
                return require(PromptsServerDrivenUi.Actions.SduiRequestPushNotificationPermissionAction)
            end,
            skipUnifiedLogging = false
        } or nil,
        [SduiActionType.IncrementMilestoneCount] = FFlagSduiMilestoneCountActions and {
            lazyHandler = function()
                return require(PromptsServerDrivenUi.Actions.SduiIncrementMilestoneCountAction)
            end,
            skipUnifiedLogging = false
        } or nil,
        [SduiActionType.SetMilestoneCount] = FFlagSduiMilestoneCountActions and {
            lazyHandler = function()
                return require(PromptsServerDrivenUi.Actions.SduiSetMilestoneCountAction)
            end,
            skipUnifiedLogging = false
        } or nil
    }

    getSduiActionHandlerRegistry().registerActionHandlerConfigs(tbl1)
end

return registerPromptsActions
