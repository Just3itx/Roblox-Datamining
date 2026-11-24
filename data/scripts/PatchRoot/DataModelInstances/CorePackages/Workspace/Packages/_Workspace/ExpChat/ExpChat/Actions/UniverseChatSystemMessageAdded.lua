-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local Rodux = require(ExpChatParent.Rodux)
local FFlagExpChatDictation = require(ExpChatParent.SharedFlags).FFlagExpChatDictation

return Rodux.makeActionCreator(script.Name, function(text: string, channelNameOverride: string, metadata: string?, isError: boolean?, postProcessMessage: ((...any) -> (...any))?)
    local tbl1 = {
        text = text,
        channelNameOverride = channelNameOverride,
        metadata = metadata,
        isError = 0,
        postProcessMessage = 0
    }

    if not FFlagExpChatDictation then
        isError = nil
    end

    tbl1.isError = isError
    tbl1.postProcessMessage = postProcessMessage
    return tbl1
end)
