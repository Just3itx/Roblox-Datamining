-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)

local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiParseHelpers = SduiCoreSystem.SduiParseHelpers

local function SduiActionSequenceAction(arg1, _, arg2, arg3)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.ActionSequence,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    local actions = actionParams.actions
    if typeof(actions) ~= "table" then
        arg2.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = SduiActionType.ActionSequence,
            message = `Invalid actionParam: actions is {typeof(actions)}`,
            propName = "actions"
        }, arg2.appPage)
        return
    end

    local num1 = 0
    for k in actions do
        if typeof(k) == "number" and num1 < k then
            num1 = k
        end
    end

    for i = 1, num1 do
        local action = actions[i]
        if action == nil then
            continue
        end

        if typeof(action) ~= "function" then
            arg2.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
                name = SduiActionType.ActionSequence,
                message = `Child action at index {i} is not callable: {typeof(action)}`,
                propName = "actions"
            }, arg2.appPage)
        else
            local success, result = pcall(action, nil, arg3)
            if not success then
                arg2.dependencies.logger.reportError(SduiErrorType.FailedToExecuteAction, {
                    name = SduiActionType.ActionSequence,
                    message = `Child action at index {i} failed: ` .. SduiParseHelpers.stringifyValue(result)
                }, arg2.appPage)
            end
        end
    end
end
return SduiActionSequenceAction
