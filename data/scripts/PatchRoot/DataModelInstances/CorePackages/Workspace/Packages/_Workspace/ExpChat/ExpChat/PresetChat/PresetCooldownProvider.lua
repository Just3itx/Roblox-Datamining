-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local React = require(ExpChatParent.React)
local SignalsReact = require(ExpChatParent.SignalsReact)

local GetPresetChatStore = require(ExpChat.Stores.GetPresetChatStore)
local PresetCooldownContext = require(script.Parent.PresetCooldownContext)

local function PresetCooldownProvider(tbl1)
    local presetChatStore = GetPresetChatStore(false)
    local endsAt = SignalsReact.useSignalState(presetChatStore.getPresetCooldownEndsAt)
    local isCooldownActive = not (endsAt == nil) and os.clock() < endsAt

    React.useEffect(function()
        if endsAt == nil then
            return
        end
        local var2 = endsAt - os.clock()
        if var2 <= 0 then
            presetChatStore.setPresetCooldownEndsAt(nil)
            return
        end
        local bool2 = false
        task.delay(var2, function()
            if bool2 then
                return
            end
            if presetChatStore.getPresetCooldownEndsAt(false) == endsAt then
                presetChatStore.setPresetCooldownEndsAt(nil)
            end
        end)
        return function()
            bool2 = true
        end
    end, { endsAt, presetChatStore.setPresetCooldownEndsAt, presetChatStore.getPresetCooldownEndsAt })

    local value = React.useMemo(function()
        return { endsAt = endsAt, isCooldownActive = isCooldownActive }
    end, { endsAt, isCooldownActive })

    return React.createElement(PresetCooldownContext.Provider, { value = value }, tbl1.children)
end

return PresetCooldownProvider
