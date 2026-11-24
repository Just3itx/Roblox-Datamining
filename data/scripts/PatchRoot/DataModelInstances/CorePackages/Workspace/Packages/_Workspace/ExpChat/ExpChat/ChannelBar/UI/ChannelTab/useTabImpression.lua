-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:41:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local React = require(ExpChatParent.React)
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local Cryo = require(ExpChatParent.Cryo)

local FFlagGlobalTextChatAddPlaySessionField = require(ExpChat.Flags.FFlagGlobalTextChatAddPlaySessionField)
local FFlagExpChatGlobalTabDefault = require(ExpChat.Flags.FFlagExpChatGlobalTabDefault)

local Analytics = ExpChatShared.Analytics

local var1 = Cryo.List.join(
    Analytics.DefaultStandardizedFields,
    { "addPlaceInstanceId" },
    FFlagGlobalTextChatAddPlaySessionField and { "addPlaySessionId" } or {}
)

local function useTabImpression(tbl1)
    local tabType = tbl1.tabType or "Unknown"
    local badgeCount = if tbl1.hasUnreadMessages then 1 else 0

    local useEffect = React.useEffect
    local function func1()
        if not tbl1.enabled then
            return
        end

        Analytics:TelemetryLogEvent(Analytics.ExpChatTabImpressionConfig, {
            name = tbl1.name,
            type = tabType,
            index = tbl1.index,
            in_overflow = tbl1.inOverflow,
            visible = tbl1.visible,
            badge_count = badgeCount,
            is_selected = if FFlagExpChatGlobalTabDefault then tbl1.isSelected == true else nil
        }, var1)
    end

    local enabled = tbl1.enabled
    local name = tbl1.name

    local index = tbl1.index
    local inOverflow = tbl1.inOverflow
    local visible = tbl1.visible
    local isSelected = if FFlagExpChatGlobalTabDefault then tbl1.isSelected else nil
    useEffect(func1, { enabled, name, tabType, index, inOverflow, visible, badgeCount, isSelected })
end

return useTabImpression
