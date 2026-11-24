-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local List = require(ExpChatParent.llama).List

local isBorderlessBubbleChatMessage = require(script.Parent.isBorderlessBubbleChatMessage)
local getBubbleDurationInMillis = require(script.Parent.getBubbleDurationInMillis)
local getBubbleChatStartTimeMillis = require(script.Parent.getBubbleChatStartTimeMillis)

local function getDisplayedBubbleMessages(tbl1, num1: number, num2: number, num3: number)
    local num4 = 0
    for i = #tbl1, 1, -1 do
        if tbl1[i].isVisibleInBubbleChat and isBorderlessBubbleChatMessage(tbl1[i]) then
            num4 = i
            break
        end
    end

    if num4 ~= #tbl1 then
        num4 += 1
    end
    return List.filter(tbl1, function(arg1, arg2)
        return num4 <= arg2
            and #tbl1 - num2 < arg2
            and arg1.isVisibleInBubbleChat
            and num3 - getBubbleChatStartTimeMillis(arg1) < getBubbleDurationInMillis(arg1, num1)
    end)
end

return getDisplayedBubbleMessages
