-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local Signals = require(ExpChatParent.Signals)
local createSignal = Signals.createSignal
local createComputed = Signals.createComputed

local FFlagExpChatDictationContinuousByDefault = require(ExpChat.Flags.FFlagExpChatDictationContinuousByDefault)
local DictationMode = require(ExpChat.ChatInput.UI.ChatInputBar.Dictation.DictationMode)
local DictationModeSettingStorage = require(script.Parent.DictationModeSettingStorage)

local function getDefaultMode() -- Luacid: unused: defined but never referenced
    return if FFlagExpChatDictationContinuousByDefault then DictationMode.Continuous else DictationMode.Standard
end

return function(tbl1)
    local var1 = tbl1 or DictationModeSettingStorage

    local var2, var3 = createSignal((var1.read()))

    return {
        getMode = createComputed(function(arg1)
            local var4 = var2(arg1)

            if not var4 then
                if FFlagExpChatDictationContinuousByDefault then
                    return DictationMode.Continuous
                end

                var4 = DictationMode.Standard
            end

            return var4
        end),
        setMode = function(arg1)
            if var2(false) == arg1 then
                return
            end
            var3(arg1)
            var1.write(arg1)
        end
    }
end
