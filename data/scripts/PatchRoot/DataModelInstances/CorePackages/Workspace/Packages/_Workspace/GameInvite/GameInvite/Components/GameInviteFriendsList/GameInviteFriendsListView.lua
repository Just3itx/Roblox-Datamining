-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInvite = script:FindFirstAncestor("GameInvite")
local GameInviteParent = GameInvite.Parent
local React = require(GameInviteParent.React)
local ReactRoblox = require(GameInviteParent.ReactRoblox)
local Foundation = require(GameInviteParent.Foundation)
local FriendsMenu = require(GameInviteParent.FriendsMenu)
local UserList = require(GameInviteParent.UserList)
local FFlagGameInviteInExpJoinCta = require(GameInvite.Flags.FFlagGameInviteInExpJoinCta)
local FFlagUserListFixedRowHeightConfig = require(GameInviteParent.SharedFlags).FFlagUserListFixedRowHeightConfig

local _useGameInviteJoinCard = require(script.Parent.useGameInviteJoinCard)

local VerticalUserList = UserList.VerticalUserList.VerticalUserList
local FriendsMenuShareGameInviteLink = FriendsMenu.FriendsMenuShareGameInviteLink

local configs = {
    disableRowActivation = true,
    showTrustedFriendIndicator = false,
    disableVirtualization = true,
    fixedRowHeight = if FFlagUserListFixedRowHeightConfig then true else nil
}

local function GameInviteJoinCardPortal(tbl2)
    local var1 = Foundation.Hooks.useOverlay()
    local joinCard = tbl2.joinCard
    local cardComponent = joinCard.cardComponent
    if var1 == nil or cardComponent == nil then
        return nil
    end
    return ReactRoblox.createPortal({
        GameInviteJoinCard = React.createElement(cardComponent, { userId = joinCard.userId, onJoin = joinCard.join, onClose = joinCard.close })
    }, var1)
end

local function GameInviteFriendsListView(tbl2)
    local createElement = React.createElement
    local view = Foundation.View
    local tbl3 = {
        tag = "col",
        testId = "GameInviteFriendsListView",
        Size = tbl2.size,
        LayoutOrder = tbl2.layoutOrder
    }
    local tbl4 = {
        ShareGameInviteLink = if tbl2.showShareGameInviteLink then React.createElement(FriendsMenuShareGameInviteLink, { layoutOrder = 1 }) else nil,
        Rows = 0,
        JoinCard = 0
    }

    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl5 = {
        tag = "col fill size-full-0 padding-x-xxlarge",
        testId = "GameInviteFriendsListRows",
        LayoutOrder = 2
    }

    local tbl6 = {
        List = React.createElement(VerticalUserList, {
            entities = tbl2.entities,
            isScrollEnabled = true,
            renderRow = tbl2.renderRow,
            onRowSelected = tbl2.onRowSelected,
            onEndReached = tbl2.onEndReached,
            configs = configs,
            ctaConfig = if FFlagGameInviteInExpJoinCta then tbl2.ctaConfig else nil
        })
    }
    tbl4.Rows = createElement2(view2, tbl5, tbl6)

    tbl4.JoinCard = if FFlagGameInviteInExpJoinCta and tbl2.joinCard and tbl2.joinCard.userId then React.createElement(GameInviteJoinCardPortal, { joinCard = tbl2.joinCard }) else nil
    return createElement(view, tbl3, tbl4)
end

return GameInviteFriendsListView
