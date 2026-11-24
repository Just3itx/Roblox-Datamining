-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent

local Signals = require(ExpChatParent.Signals)
local createSignal = Signals.createSignal
local createComputed = Signals.createComputed

local GetChatStatusStore = require(script.Parent.Parent.GetChatStatusStore)

return function(tbl1)
    local var1, var2 = createSignal(false)
    local var3, var4 = createSignal(false)
    local requiresChatEnabled = not (tbl1.requiresChatEnabled == nil) and tbl1.requiresChatEnabled
    local chatStatusStore = GetChatStatusStore(false)

    local getIsSettingVisible = createComputed(function(arg1)
        if requiresChatEnabled then
            return var1(arg1) and chatStatusStore.getChatStatus(arg1) == "Enabled"
        end
        return var1(arg1)
    end)

    local getIsSettingEnabled = createComputed(function(arg1)
        if requiresChatEnabled then
            return var3(arg1) and chatStatusStore.getChatStatus(arg1) == "Enabled"
        end
        return var3(arg1)
    end)

    local setIsSettingVisible = not tbl1.buildFeatureValueHandler and function(_: string, _: string) end or tbl1.buildFeatureValueHandler(var2, var4)

    local cleanup = tbl1.setupListener(var2, var4)

    return {
        getIsSettingVisible = getIsSettingVisible,
        getIsSettingEnabled = getIsSettingEnabled,
        setIsSettingVisible = setIsSettingVisible,
        setIsSettingEnabled = function(bool1: boolean)
            tbl1.onSetEnabled(bool1, var4)
        end,
        initialize = tbl1.onInitialize or function() end,
        cleanup = cleanup
    }
end
