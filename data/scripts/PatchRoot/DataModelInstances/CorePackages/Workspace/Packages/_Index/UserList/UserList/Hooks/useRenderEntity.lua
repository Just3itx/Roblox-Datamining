-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent

local React = require(UserListParent.React)
local View = require(UserListParent.Foundation).View
local _Types = require(UserList.Common.Types)
local EntityRow = require(UserList.Components.UserRow).EntityRow

local FFlagUserListCtaIntegrationEnabled = require(UserListParent.SharedFlags).FFlagUserListCtaIntegrationEnabled
local FFlagUserListSurfaceExtensions = require(UserListParent.SharedFlags).FFlagUserListSurfaceExtensions

local function useRenderEntity(tbl1)
    local onActivated = tbl1.onActivated
    local renderRow = tbl1.renderRow
    local entitiesMap = tbl1.entitiesMap
    local configs = tbl1.configs
    local layoutMode = tbl1.layoutMode
    local firstRowRef = if FFlagUserListSurfaceExtensions then tbl1.firstRowRef else nil
    local useCallback = React.useCallback
    local function func1(str1: string, layoutOrder: number, uDim2: UDim2?)
        local entity = entitiesMap[str1]

        if not entity then
            return nil
        end

        if not renderRow then
            return (React.createElement(View, {
                tag = "size-full-full",
                Size = uDim2,
                LayoutOrder = layoutOrder,
                ref = if FFlagUserListSurfaceExtensions and layoutOrder == 1 then firstRowRef else nil
            }, { React.createElement(
                    EntityRow,
                    {
                        entity = entity,
                        onActivated = onActivated,
                        configs = configs,
                        layoutMode = layoutMode
                    }
                ) }))
        end

        return (renderRow(function(arg1)
            local var1 = arg1.onRowActivated and function()
                arg1.onRowActivated(entity.id, entity.type, layoutOrder)
            end or onActivated

            return React.createElement(View, {
                tag = "size-full-full",
                Size = uDim2,
                LayoutOrder = layoutOrder,
                ref = if FFlagUserListSurfaceExtensions and layoutOrder == 1 then firstRowRef else nil
            }, { React.createElement(EntityRow, {
                    entity = entity,
                    onActivated = var1,
                    primaryCta = arg1.primaryCta,
                    secondaryCta = arg1.secondaryCta,
                    ctaLoading = if FFlagUserListCtaIntegrationEnabled then arg1.ctaLoading else nil,
                    contextualInfo = arg1.contextualInfo,
                    loadingState = arg1.loadingState,
                    presence = arg1.presence,
                    shouldShowNewIndicator = arg1.shouldShowNewIndicator,
                    trailingContent = arg1.trailingContent,
                    configs = configs,
                    layoutMode = layoutMode
                }) })
        end, entity, layoutOrder))
    end

    local var1 = if FFlagUserListSurfaceExtensions then firstRowRef else nil
    return (useCallback(func1, { onActivated, renderRow, entitiesMap, configs, layoutMode, var1 }))
end

return useRenderEntity
