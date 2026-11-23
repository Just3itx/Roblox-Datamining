-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent

local React = require(UserListParent.React)
local Enums = require(UserList.Common.Enums)
local _Types = require(UserList.Common.Types)

local UserRow = require(script.Parent.UserRow)
local ContactRow = require(script.Parent.ContactRow)

local FFlagUserListCtaIntegrationEnabled = require(UserListParent.SharedFlags).FFlagUserListCtaIntegrationEnabled

return React.memo(function(tbl1) -- name: EntityRow
    local entity = tbl1.entity

    local onActivated = React.useCallback(function()
        if tbl1.onActivated then
            tbl1.onActivated(entity.id, entity.type)
        end
    end, { tbl1.onActivated, entity.id, entity.type })

    local layoutMode = if tbl1.layoutMode == Enums.LayoutMode.Horizontal then Enums.RowLayoutMode.Compact else Enums.RowLayoutMode.Wide

    if entity.type == Enums.EntityType.Contact then
        return React.createElement(ContactRow, {
            entityId = entity.id,
            layoutMode = layoutMode,
            onActivated = onActivated,
            layoutOrder = tbl1.layoutOrder,
            primaryCta = tbl1.primaryCta,
            secondaryCta = tbl1.secondaryCta,
            contextualInfo = tbl1.contextualInfo,
            loadingState = tbl1.loadingState,
            trailingContent = tbl1.trailingContent,
            configs = tbl1.configs
        })
    end
    return React.createElement(UserRow, {
        entityId = entity.id,
        layoutMode = layoutMode,
        onActivated = onActivated,
        primaryCta = tbl1.primaryCta,
        secondaryCta = tbl1.secondaryCta,
        ctaLoading = if FFlagUserListCtaIntegrationEnabled then tbl1.ctaLoading else nil,
        contextualInfo = tbl1.contextualInfo,
        layoutOrder = tbl1.layoutOrder,
        loadingState = tbl1.loadingState,
        presence = tbl1.presence,
        shouldShowNewIndicator = tbl1.shouldShowNewIndicator,
        trailingContent = tbl1.trailingContent,
        configs = tbl1.configs
    })
end)
