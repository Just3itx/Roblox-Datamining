-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheetParent = script:FindFirstAncestor("ShareSheet").Parent

local Foundation = require(ShareSheetParent.Foundation)
local FriendsCommon = require(ShareSheetParent.FriendsCommon)
local React = require(ShareSheetParent.React)
local SocialCommon = require(ShareSheetParent.SocialCommon)

local _PeoplePickerListView = require(script.Parent.PeoplePickerListView)

local Icon = Foundation.Icon
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local useTokens = Foundation.Hooks.useTokens
local useGetPresenceByUserId = FriendsCommon.Hooks.useGetPresenceByUserId
local convertToFoundationPresenceEnum = SocialCommon.Utils.convertToFoundationPresenceEnum

local function usePeoplePickerListItemViewModel(tbl1)
    local var1 = useTokens()
    local primaryUserId = if tbl1.primaryUserId == "" or tbl1.secondUserId ~= nil then nil else tbl1.primaryUserId
    local var2 = useGetPresenceByUserId(primaryUserId)
    local userPresence = if var2 and var2.userPresenceType then convertToFoundationPresenceEnum(var2.userPresenceType) else Foundation.Enums.UserPresence.None
    local isLoading = tbl1.isLoading == true

    local testId = tbl1.testId or "people-picker-list-item"
    local isSelected = tbl1.isSelected

    local trailing = React.useMemo(function()
        if not isSelected then
            return nil
        end

        return React.createElement(Icon, {
            name = IconName.Check,
            size = IconSize.Large,
            style = var1.Color.Content.Emphasis,
            testId = `{testId}--selected-check`
        })
    end, { isSelected, testId, var1 })

    return {
        leading = {
            type = "Avatar",
            userId = tbl1.primaryUserId,
            secondUserId = tbl1.secondUserId,
            userPresence = userPresence
        },
        trailing = trailing,
        title = tbl1.title,
        description = tbl1.description,
        isLoading = isLoading,
        onActivated = tbl1.onActivated,
        testId = testId
    }
end

return usePeoplePickerListItemViewModel
