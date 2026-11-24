-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local getFFlagExpChatProtectedChatInternalAPIs = require(ExpChatParent.SharedFlags).getFFlagExpChatProtectedChatInternalAPIs

local getTextAndTranslation = require(ExpChat.getTextAndTranslation)
local isFullyFilteredText = require(script.Parent.isFullyFilteredText)

local function getMessageText(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return (if getFFlagExpChatProtectedChatInternalAPIs() then arg1.TextInternal else arg1.Text) or ""
end

local function getDisplayedText(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return getTextAndTranslation(arg1) or ""
end

local function trim(str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    return (string.gsub(str1, "^%s*(.-)%s*$", "%1"))
end

local function createDictationSafetyReminder(tbl1)
    local clock = tbl1.clock or os.clock
    local bool1 = false
    local tbl2 = {}
    local tbl3 = ({})

    local function prune(num1: number)
        for i = #tbl2, 1, -1 do
            if num1 - tbl2[i].at > 30 then
                table.remove(tbl2, i)
            end
        end
        for value, value2 in tbl3 do
            if num1 - value2.at > 30 then
                tbl3[value] = nil
            end
        end
    end

    return {
        trackContinuousSend = function(str1: string)
            if bool1 then
                return
            end
            local at = clock()
            prune(at)
            table.insert(tbl2, { text = trim(str1), at = at })
        end,
        onOutgoingMessage = function(arg1)
            if bool1 or #tbl2 == 0 then
                return
            end

            local var1 = trim((getMessageText(arg1)))

            for value, value2 in tbl2 do
                if value2.text == var1 then
                    table.remove(tbl2, value)
                    tbl3[arg1.MessageId] = value2
                    return
                end
            end
        end,
        onIncomingMessage = function(arg1)
            local var1 = tbl3[arg1.MessageId]
            if var1 == nil or arg1.Status == Enum.TextChatMessageStatus.Sending then
                return
            end

            tbl3[arg1.MessageId] = nil
            if bool1 or arg1.Status ~= Enum.TextChatMessageStatus.Success then
                return
            end

            if isFullyFilteredText(var1.text, (trim((getDisplayedText(arg1))))) then
                bool1 = true
                table.clear(tbl2)
                table.clear(tbl3)
                tbl1.onTriggered()
            end
        end
    }
end

return createDictationSafetyReminder
