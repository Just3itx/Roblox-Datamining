-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local React = require(ExpChatParent.React)
local EmojiList = require(ExpChatParent.EmojiList)
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local Constants = require(ExpChat.PresetChat.Constants)
local emojiUnicodeToId = require(ExpChat.PresetChat.emojiUnicodeToId)

local function useEmojiDropdownDismissAnalytics(bool1: boolean, tbl1, bool2: boolean)
    local var1 = React.useRef(nil)

    local var2 = React.useCallback(function()
        local current = var1.current
        if current == nil then
            return
        end

        local tbl2 = ({})
        for k, lastVisibleResult in current.lastVisibleResults do
            tbl2[lastVisibleResult] = k - 1
        end

        local current2 = if bool2 then bool2.current else nil
        local input = {}
        for _, value in current.seenOrder do
            table.insert(input, {
                emoji_id = emojiUnicodeToId(EmojiList[value].base),
                index = tbl2[value] or -1,
                click = if value == current2 then 1 else 0
            })
        end

        var1.current = nil
        if bool2 then
            bool2.current = nil
        end

        ExpChatShared.Analytics:TelemetryLogEvent(
            ExpChatShared.Analytics.ExpChatPresetActionConfig,
            {
                event_type = Constants.Analytics.EventTypes.Dismiss,
                component = Constants.Analytics.Components.EmojiDropdown,
                preset_items = HttpService:JSONEncode(input)
            },
            Constants.Analytics.ExtendedStandardizedFields
        )
    end, { bool2 })

    React.useEffect(function()
        if not bool1 then
            var2()
            return
        end

        local current = var1.current
        if current == nil then
            current = {
                seenOrder = {},
                seenSet = {},
                lastVisibleResults = {}
            }
            var1.current = current
            if bool2 then
                bool2.current = nil
            end
        end

        for _, value in tbl1 do
            if not current.seenSet[value] then
                current.seenSet[value] = true
                table.insert(current.seenOrder, value)
            end
        end

        current.lastVisibleResults = table.clone(tbl1)
    end, {
        bool1,
        tbl1,
        bool2,
        var2
    })
    React.useEffect(function()
        return var2
    end, { var2 })
end

return useEmojiDropdownDismissAnalytics
