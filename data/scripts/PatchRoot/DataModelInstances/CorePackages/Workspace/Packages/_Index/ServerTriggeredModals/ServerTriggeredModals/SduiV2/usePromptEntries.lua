-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerTriggeredModalsParent = script:FindFirstAncestor("ServerTriggeredModals").Parent

local React = require(ServerTriggeredModalsParent.React)
local SignalsReact = require(ServerTriggeredModalsParent.SignalsReact)
local SduiSharedUtilities = require(ServerTriggeredModalsParent.SduiSharedUtilities)

local _PromptStyle = require(script.Parent.PromptStyle)
local _PromptEntry = require(script.Parent.Types.PromptEntry)
local getSduiApiStore = SduiSharedUtilities.getSduiApiStore

local function usePromptEntries(str1: string, arg1)
    local var1 = SignalsReact.useSignalState(getSduiApiStore().getData(str1).data)

    return React.useMemo(function()
        local result = {}
        if not var1 then
            return result
        end

        for _, value in var1 do
            local category = value.category

            if arg1 ~= nil and category ~= arg1 then
                continue
            end

            table.insert(result, {
                identifier = value.identifier,
                robloxComponentType = value.robloxComponentType,
                title = value.title,
                promptStyle = category,
                config = value.config
            })
        end

        return result
    end, { var1, arg1 })
end

return usePromptEntries
