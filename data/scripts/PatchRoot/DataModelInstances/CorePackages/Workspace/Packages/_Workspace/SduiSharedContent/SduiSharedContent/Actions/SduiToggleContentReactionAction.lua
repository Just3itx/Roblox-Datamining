-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContent = script:FindFirstAncestor("SduiSharedContent")
local SduiSharedContentParent = SduiSharedContent.Parent

local Promise = require(SduiSharedContentParent.Promise)
local SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)

local getSduiContentReactionVerticalRegistry = require(SduiSharedContent.Actions.getSduiContentReactionVerticalRegistry)

local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local getStringParam = SduiCoreSystem.SduiActionParams.getStringParam

local tbl1 = { "entityId", "vertical", "emoteId" }

local function rejectInvalidParams(arg1, message: string, propName: string?)
    arg1.dependencies.logger.reportError(
        SduiErrorType.InvalidActionParams,
        {
            name = SduiActionType.ToggleContentReaction,
            message = message,
            propName = propName
        },
        arg1.appPage
    )
    return Promise.reject(message)
end

local function SduiToggleContentReactionAction(arg1, _, arg2, _)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        return rejectInvalidParams(arg2, "Missing actionParams", nil)
    end

    for _, value in tbl1 do
        local stringParam = getStringParam(actionParams, value)
        if stringParam == nil or stringParam == "" then
            return rejectInvalidParams(arg2, `Missing actionParam: {value}`, value)
        end
    end

    local shouldAdd = actionParams.shouldAdd
    if typeof(shouldAdd) ~= "boolean" then
        return rejectInvalidParams(arg2, "actionParam shouldAdd must be a boolean", "shouldAdd")
    end

    local vertical = actionParams.vertical
    local var1 = getSduiContentReactionVerticalRegistry().getVertical(vertical)
    if var1 == nil then
        return rejectInvalidParams(arg2, `No content reaction adapter for vertical: {vertical}`, "vertical")
    end

    return Promise.try(
        var1.toggle,
        {
            entityId = actionParams.entityId,
            vertical = vertical,
            emoteId = actionParams.emoteId,
            shouldAdd = shouldAdd
        }
    ):catch(
        function(arg3)
            arg2.dependencies.logger.reportError(
                SduiErrorType.FailedToExecuteAction,
                {
                    name = SduiActionType.ToggleContentReaction,
                    message = tostring(arg3)
                },
                arg2.appPage
            )
            return Promise.reject(arg3)
        end
    )
end
return SduiToggleContentReactionAction
