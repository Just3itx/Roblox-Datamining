-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent

local React = require(UserListParent.React)
local Cryo = require(UserListParent.Cryo)
local View = require(UserListParent.Foundation).View
local FlatList = require(UserListParent.VirtualizedList).FlatList
local _Types = require(UserList.Common.Types)
local Enums = require(UserList.Common.Enums)

local useEntities = require(UserList.Hooks.useEntities)
local useEntitySelectionHandler = require(UserList.Hooks.useEntitySelectionHandler)
local useRenderEntity = require(UserList.Hooks.useRenderEntity)
local useFixedRowLayout = require(UserList.Hooks.useFixedRowLayout)

local FFlagUserListCtaIntegrationEnabled = require(UserListParent.SharedFlags).FFlagUserListCtaIntegrationEnabled
local FFlagUserListSurfaceExtensions = require(UserListParent.SharedFlags).FFlagUserListSurfaceExtensions
local FFlagUserListRowSelectionOriginSource = require(UserList.Flags.FFlagUserListRowSelectionOriginSource)
local FFlagUserListDisableVirtualizationConfig = require(UserList.Flags.FFlagUserListDisableVirtualizationConfig)
local FFlagUserListFixedRowHeightConfig = require(UserListParent.SharedFlags).FFlagUserListFixedRowHeightConfig
local Cta = if FFlagUserListCtaIntegrationEnabled then require(UserList.Cta) else nil
local tbl1 = { BackgroundTransparency = 1, ScrollBarThickness = 0, BorderSizePixel = 0 }

local var1 = Cryo.Dictionary.join(tbl1, { Selectable = false })

local contentContainerStyle = { BackgroundTransparency = 1 }

local function keyExtractor<T>(arg1: T, _): T
    return arg1
end

local function VerticalUserList(tbl3)
    local var2 = useEntities(tbl3.entities)
    local onActivated = useEntitySelectionHandler(
        tbl3.onRowSelected,
        if FFlagUserListRowSelectionOriginSource then tbl3.rowSelectionConfig else nil
    )

    local var4 = React.useMemo(function()
        if not (tbl3.initialRowCount and tbl3.initialRowCount < #tbl3.entities) then
            return tbl3.entities
        end

        local result = {}
        for i = 1, tbl3.initialRowCount do
            table.insert(result, tbl3.entities[i])
        end
        return result
    end, { tbl3.entities, tbl3.initialRowCount })

    local var5 = React.useMemo(function()
        local result = {}
        for _, value in var4 do
            table.insert(result, value.id)
        end
        return result
    end, { var4 })

    local var6 = useRenderEntity({
        entitiesMap = var2.entitiesMap,
        onActivated = onActivated,
        renderRow = tbl3.renderRow,
        configs = tbl3.configs,
        layoutMode = Enums.LayoutMode.Vertical,
        firstRowRef = if FFlagUserListSurfaceExtensions then tbl3.firstRowRef else nil
    })
    local var7 = if FFlagUserListFixedRowHeightConfig then useFixedRowLayout(not (tbl3.configs == nil) and tbl3.configs.fixedRowHeight == true, not not tbl3.ListHeaderComponent) else nil
    local useCallback = React.useCallback

    local function func1(arg1)
        return var6(arg1.item, arg1.index, if FFlagUserListFixedRowHeightConfig and var7 then var7.itemSize else nil)
    end

    local var8 = if FFlagUserListFixedRowHeightConfig then var7 else nil
    local renderItem = useCallback(func1, { var6, var8 })

    if #tbl3.entities == 0 then
        return nil
    end

    if tbl3.isScrollEnabled then
        local createElement = React.createElement
        local var10 = View
        local tbl4 = {
            tag = "size-full-0 fill",
            LayoutOrder = tbl3.layoutOrder
        }
        local tbl5 = {
            List = React.createElement(FlatList, {
                data = var5,
                renderItem = renderItem,
                keyExtractor = keyExtractor,
                windowSize = 3,
                initialNumToRender = 10,
                onEndReachedThreshold = 2,
                disableVirtualization = if FFlagUserListDisableVirtualizationConfig and tbl3.configs and tbl3.configs.disableVirtualization then true else nil,
                getItemLayout = if FFlagUserListFixedRowHeightConfig and var7 then var7.getItemLayout else nil,
                onEndReached = if FFlagUserListSurfaceExtensions then tbl3.onEndReached else nil,
                style = if FFlagUserListSurfaceExtensions and tbl3.configs and tbl3.configs.disableRowActivation then var1 else tbl1,
                contentContainerStyle = contentContainerStyle,
                ListHeaderComponent = if FFlagUserListFixedRowHeightConfig and var7 and tbl3.ListHeaderComponent then React.createElement(
                    View,
                    {
                        tag = "size-full-0 auto-y",
                        onAbsoluteSizeChanged = var7.onHeaderSizeChanged
                    },
                    {
                        Header = tbl3.ListHeaderComponent
                    }
                ) else tbl3.ListHeaderComponent,
                ListFooterComponent = tbl3.ListFooterComponent
            })
        }
        return createElement(var10, tbl4, tbl5)
    end

    local createElement = React.createElement
    local var10 = View
    local tbl4 = {
        tag = "size-full-0 auto-y col gap-xxsmall",
        LayoutOrder = tbl3.layoutOrder
    }
    local tbl5 = { EntityRows = 0 }
    local createElement2 = React.createElement
    local fragment = React.Fragment

    local useMemo = React.useMemo

    tbl5.EntityRows = createElement2(fragment, {}, unpack(useMemo(function()
        local result = ({})
        for layoutOrder, key in ipairs(var5) do
            local createElement3 = React.createElement
            local var11 = View

            local tbl6 = {
                Content = var6(key, layoutOrder)
            }
            result[layoutOrder] = createElement3(var11, { key = key, tag = "size-full-0 auto-y", LayoutOrder = layoutOrder }, tbl6)
        end

        return result
    end, { var5, var6 })))

    return createElement(var10, tbl4, tbl5)
end

return if FFlagUserListCtaIntegrationEnabled then function(tbl3) -- name: VerticalUserListWithCta
    if Cta == nil or tbl3.ctaConfig == nil then
        return React.createElement(VerticalUserList, tbl3)
    end

    return React.createElement(Cta.CtaRenderRowBridge, {
        ctaConfig = tbl3.ctaConfig,
        renderRow = tbl3.renderRow,
        render = function(renderRow)
            local var2 = table.clone(tbl3)
            var2.renderRow = renderRow
            return React.createElement(VerticalUserList, var2)
        end
    })
end else VerticalUserList
