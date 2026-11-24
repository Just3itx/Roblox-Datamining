-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")

local perUserAppStorage = require(ExpChat.Utils.perUserAppStorage)
local DictationMode = require(ExpChat.ChatInput.UI.ChatInputBar.Dictation.DictationMode)

local module = {}

function module.read()
    local entry = perUserAppStorage.getEntry("ExpChatDictationModeSetting")
    return if entry.mode == DictationMode.Standard or entry.mode == DictationMode.Continuous then entry.mode else nil
end

function module.write(mode)
    perUserAppStorage.updateEntry("ExpChatDictationModeSetting", function(tbl1): {[any]: any}?
        if tbl1.mode == mode then
            return nil
        end
        tbl1.mode = mode
        return tbl1
    end)
end

return module
