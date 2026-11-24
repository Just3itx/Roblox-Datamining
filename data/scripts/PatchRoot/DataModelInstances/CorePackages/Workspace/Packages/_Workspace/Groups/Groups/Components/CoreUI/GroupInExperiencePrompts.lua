-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local Cryo = require(scriptParentParentParentParent.Cryo)

local useState = React.useState

local PromptConnections = require(scriptParentParentParent.Components.CoreUI.PromptConnections)
local GroupJoinPrompt = require(scriptParentParentParent.Components.CoreUI.GroupJoinPrompt)

local FocusNavigationUtils = require(scriptParentParentParentParent.FocusNavigationUtils)
local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local _Types = require(scriptParentParentParent.Common.Types)

local tbl1 = { PromptJoinGroup = GroupJoinPrompt }

return function(tbl2)
    local var1, var2 = useState({ promptType = nil, promptData = nil, data = nil, callbacks = nil, promptQueue = {} })

    local promptData = var1.promptData
    local promptType = var1.promptType
    local data = var1.data
    local callbacks = var1.callbacks

    local closePrompt = React.useCallback(function()
        if not Cryo.isEmpty(var1.promptQueue) then
            var2(
                Cryo.Dictionary.join(var1, {
                    promptType = var1.promptQueue[1].promptType,
                    promptData = var1.promptQueue[1].promptData,
                    data = var1.promptQueue[1].data,
                    callbacks = var1.promptQueue[1].callbacks,
                    promptQueue = Cryo.List.removeIndex(var1.promptQueue, 1)
                })
            )
            return
        end

        var2({ promptType = nil, promptData = nil, data = nil, callbacks = nil, promptQueue = {} })
    end, { var1, var2 })

    local element = nil
    if promptType then
        local var4 = tbl1[promptType]
        if var4 then
            element = React.createElement(var4, {
                enableInputDelayed = tbl2.enableInputDelayed,
                groupId = if promptData then promptData.groupId else nil,
                data = data,
                onJoin = if callbacks then callbacks.onJoin else nil,
                onClose = if callbacks then callbacks.onClose else nil
            })
        else
            error(`Unexpected prompt type: {promptType}!`)
        end
    end

    local openGroupJoinPrompt = React.useCallback(function(groupId: number, arg1, callbacks2)
        if var1.promptType == nil then
            var2({
                promptType = "PromptJoinGroup",
                promptData = { groupId = groupId },
                data = arg1,
                callbacks = callbacks2,
                promptQueue = {}
            })

            return
        end

        var2(
            Cryo.Dictionary.join(var1, {
                promptQueue = Cryo.List.join(
                    var1.promptQueue,
                    {{
                        promptType = "PromptJoinGroup",
                        promptData = { groupId = groupId },
                        data = arg1,
                        callbacks = callbacks2
                    }}
                )
            })
        )
    end, { var1, var2 })

    return React.createElement(React.Fragment, {}, {
        PromptConnections = React.createElement(PromptConnections, { openGroupJoinPrompt = openGroupJoinPrompt, closePrompt = closePrompt }),
        FocusNavigationCoreScriptsWrapper = if element then React.createElement(
            FocusRoot,
            {
                surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay,
                isIsolated = true,
                isAutoFocusRoot = true
            },
            { Prompt = element }
        ) else nil
    })
end
