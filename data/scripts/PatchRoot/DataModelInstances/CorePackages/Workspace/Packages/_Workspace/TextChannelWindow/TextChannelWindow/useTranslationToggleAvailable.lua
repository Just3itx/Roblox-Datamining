-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:10:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChatService = game:GetService("TextChatService")

local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.React)
local useEventConnection = require(scriptParentParent.ReactUtils).useEventConnection

local function readAvailable(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return TextChatService.ChatTranslationEnabled and TextChatService.ChatTranslationToggleEnabled
end

local function useTranslationToggleAvailable()
    local var1, var2 = React.useState(readAvailable)

    useEventConnection(TextChatService.Changed, function(str1: string)
        if str1 == "ChatTranslationEnabled" or str1 == "ChatTranslationToggleEnabled" then
            var2((readAvailable()))
        end
    end)

    return var1
end

return useTranslationToggleAvailable
