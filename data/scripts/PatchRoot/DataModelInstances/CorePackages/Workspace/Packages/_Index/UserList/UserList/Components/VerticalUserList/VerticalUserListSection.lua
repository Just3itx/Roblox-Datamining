-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent

local React = require(UserListParent.React)
local _Enums = require(UserList.Common.Enums)
local View = require(UserListParent.Foundation).View
local _Types = require(UserList.Common.Types)
local UserListHeader = require(UserList.Components.UserListHeader)

local UserListFooter = require(UserList.Components.UserListFooter)
local VerticalUserList = require(script.Parent.VerticalUserList)

local FFlagUserListCtaIntegrationEnabled = require(UserListParent.SharedFlags).FFlagUserListCtaIntegrationEnabled
local FFlagUserListSurfaceExtensions = require(UserListParent.SharedFlags).FFlagUserListSurfaceExtensions
local FFlagUserListRowSelectionOriginSource = require(UserList.Flags.FFlagUserListRowSelectionOriginSource)

local function VerticalUserListSection(tbl1)
    local element = if tbl1.header then React.createElement(
        View,
        {
            tag = "size-full-0 auto-y padding-bottom-small",
            LayoutOrder = if tbl1.isScrollEnabled then nil else 1
        },
        {
            HeaderContent = React.createElement(UserListHeader, tbl1.header)
        }
    ) else nil
    local element2 = if tbl1.hasMore and tbl1.onLoadMore then React.createElement(
        View,
        {
            tag = "size-full-0 auto-y padding-top-large",
            LayoutOrder = if tbl1.isScrollEnabled then nil else 3
        },
        {
            FooterContent = React.createElement(UserListFooter, { hasMore = tbl1.hasMore, onLoadMore = tbl1.onLoadMore })
        }
    ) else nil

    if #tbl1.entities == 0 then
        return nil
    end

    if tbl1.isScrollEnabled then
        return React.createElement(VerticalUserList, {
            entities = tbl1.entities,
            initialRowCount = tbl1.initialRowCount,
            onRowSelected = tbl1.onRowSelectedOverride,
            rowSelectionConfig = if FFlagUserListRowSelectionOriginSource then tbl1.rowSelectionConfig else nil,
            ListHeaderComponent = element,
            ListFooterComponent = element2,
            renderRow = tbl1.renderRow,
            ctaConfig = if FFlagUserListCtaIntegrationEnabled then tbl1.ctaConfig else nil,
            layoutOrder = tbl1.layoutOrder,
            configs = tbl1.configs,
            isScrollEnabled = true,
            onEndReached = if FFlagUserListSurfaceExtensions then tbl1.onEndReached else nil,
            firstRowRef = if FFlagUserListSurfaceExtensions then tbl1.firstRowRef else nil
        })
    end

    local createElement = React.createElement
    local var1 = View
    local tbl2 = {
        tag = "col size-full-0 auto-y",
        LayoutOrder = tbl1.layoutOrder
    }
    local tbl3 = {
        Header = element,
        List = React.createElement(VerticalUserList, {
            entities = tbl1.entities,
            initialRowCount = tbl1.initialRowCount,
            onRowSelected = tbl1.onRowSelectedOverride,
            rowSelectionConfig = if FFlagUserListRowSelectionOriginSource then tbl1.rowSelectionConfig else nil,
            renderRow = tbl1.renderRow,
            ctaConfig = if FFlagUserListCtaIntegrationEnabled then tbl1.ctaConfig else nil,
            layoutOrder = 2,
            configs = tbl1.configs,
            isScrollEnabled = false,
            firstRowRef = if FFlagUserListSurfaceExtensions then tbl1.firstRowRef else nil
        }),
        Footer = element2
    }
    return createElement(var1, tbl2, tbl3)
end

return VerticalUserListSection
