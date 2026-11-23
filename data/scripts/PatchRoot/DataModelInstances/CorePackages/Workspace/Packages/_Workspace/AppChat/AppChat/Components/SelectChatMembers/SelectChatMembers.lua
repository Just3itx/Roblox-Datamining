-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Foundation = require(AppChatParent.Foundation)
local UIBlox = require(AppChatParent.UIBlox)
local useStyle = UIBlox.Core.Style.useStyle
local useTextSizeOffset = UIBlox.Core.Style.useTextSizeOffset

local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization

local useDebouncedUserSearch = require(script.Parent.Utils.useDebouncedUserSearch)
local UserCellWithCheckbox = require(script.Parent.UserCellWithCheckbox)
local PaginatedChatMembers = require(script.Parent.PaginatedChatMembers)
local SelectedMembersBar = require(script.Parent.SelectedMembersBar)
local FFlagDebugAppChatEnableDomLocators = require(AppChat.Flags.FFlagDebugAppChatEnableDomLocators)
local DomLocators = require(AppChat.Utils.DomLocators)

local function renderUserEntry(userId: string, bool1: boolean, tbl1, style, _)
    local key = if bool1 then "search_" .. userId else userId
    return React.createElement(Foundation.View, { tag = "size-full-0 auto-y", key = key }, {
        cellContent = React.createElement(UserCellWithCheckbox, { style = style, userId = userId }),
        debugId = tbl1.isDebugEnabled
            and React.createElement(Foundation.Text, { tag = "auto-xy position-bottom-right anchor-bottom-right", Text = userId })
            or nil
    })
end

return React.memo(function(tbl1) -- name: SelectChatMembers
    local var1 = useLocalization({ suggested = "Feature.Friends.Label.Suggested" })

    local var2 = useStyle()
    local var3 = useTextSizeOffset()
    local var4, onChanged, text = useDebouncedUserSearch(tbl1.conversation)
    local textBoxRef = React.useRef(nil)
    local onActivated = React.useCallback(function()
        onChanged("")

        if textBoxRef and textBoxRef.current then
            textBoxRef.current.focus()
        end
    end, { onChanged })
    local bool1 = text ~= ""

    local renderItem = React.useCallback(function(tbl2)
        local item = tbl2.item
        return renderUserEntry(item, bool1, { isDebugEnabled = tbl1.isDebugEnabled }, var2, var3)
    end, {
        tbl1.isDebugEnabled,
        bool1,
        var2,
        var3
    })

    local shouldShowSelectChatMembersBar = tbl1.shouldShowSelectChatMembersBar
    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = { tag = "size-full col gap-small bg-surface-0" }

    local tbl3 = { TopSection = 0, friendsList = 0 }
    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl4 = { tag = "col size-full-0 auto-y gap-small padding-x-medium", LayoutOrder = 1 }

    local tbl5 = {
        selectedMembersBar = shouldShowSelectChatMembersBar and React.createElement(SelectedMembersBar, { LayoutOrder = 1 }) or nil,
        searchBar = React.createElement(Foundation.TextInput, {
            tag = "size-full-0 auto-y",
            LayoutOrder = 2,
            label = "",
            text = text,
            width = UDim.new(1, 0),
            placeholder = tbl1.searchFriendsText,
            leadingIcon = "icons/actions/friend_sort/search_people",
            onChanged = onChanged,
            iconTrailing = bool1 and {
                name = Foundation.Enums.IconName.CircleX,
                onActivated = onActivated
            } or nil,
            textBoxRef = textBoxRef,
            testId = if FFlagDebugAppChatEnableDomLocators then DomLocators.selectChatMembersSearchInput(text) else nil
        })
    }
    tbl3.TopSection = createElement2(view2, tbl4, tbl5)

    local createElement3 = React.createElement
    local view3 = Foundation.View
    local tbl6 = { LayoutOrder = 3, tag = "size-full-0 fill" }

    local tbl7 = { paginatedFriendsList = 0 }
    local createElement4 = React.createElement
    local var10 = PaginatedChatMembers
    local tbl8 = { userIds = 0, renderItem = 0, fetchMoreFriends = 0, headerText = 0 }
    if not bool1 then
        var4 = tbl1.friendIds
    end

    tbl8.userIds = var4
    tbl8.renderItem = renderItem
    tbl8.fetchMoreFriends = if bool1 then nil else tbl1.fetchMoreFriends
    tbl8.headerText = if bool1 then nil else var1.suggested
    tbl7.paginatedFriendsList = createElement4(var10, tbl8)
    tbl3.friendsList = createElement3(view3, tbl6, tbl7)
    return createElement(view, tbl2, tbl3)
end)
