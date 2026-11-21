-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionService = game:GetService("CollectionService")

local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local React = require(AvatarExperienceCatalogParent.React)
local Foundation = require(AvatarExperienceCatalogParent.Foundation)
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens
local GridMetrics = require(AvatarExperienceCatalogParent.UIBlox).App.Grid.GridMetrics

local useNetworking = require(AvatarExperienceCatalogParent.AvatarExperienceCommon).Hooks.useNetworking

local Constants = require(AvatarExperienceCatalogParent.Impressions).Constants

local useAvatarRoute = require(AvatarExperienceCatalogParent.AvatarExperienceNavigation).AvatarRoute.Hooks.useAvatarRoute

local _WidgetListInfoViewModel = require(AvatarExperienceCatalog.Components.ResultsList.WidgetListInfoViewModel)
local useWidgetListInfoViewModel = require(AvatarExperienceCatalog.Components.ResultsList.useWidgetListInfoViewModel)
local getOrderedWidgets = require(AvatarExperienceCatalog.Components.ResultsList.getOrderedWidgets)
local _WidgetListBreakPointEnum = require(AvatarExperienceCatalog.Components.ResultsList.WidgetListBreakPointEnum)
local getWidgetItemIdsFromWidgetInfo = require(AvatarExperienceCatalog.Utils.getWidgetItemIdsFromWidgetInfo)
local getBreakpointFromRowWidth = require(AvatarExperienceCatalog.Utils.getBreakpointFromRowWidth)
local getUIScaleFromTokens = require(AvatarExperienceCatalog.Utils.getUIScaleFromTokens)
local Constants2 = require(AvatarExperienceCatalog.Constants)
local WidgetConstants = require(AvatarExperienceCatalog.WidgetConstants)
local useOnRequestImpressionsSignal = require(AvatarExperienceCatalog.Components.Hooks.useOnRequestImpressionsSignal)

local useCatalogPageMonolithDependencies = require(AvatarExperienceCatalog.Providers.useCatalogPageMonolithDependencies)

local _WidgetPanelView = require(script.Parent.WidgetPanelView)

local function useWidgetPanelViewModel(tbl1)
    local context = tbl1.context

    local var1 = useTokens()
    local uIScaleFromTokens = getUIScaleFromTokens(var1)

    local var2, var3 = React.useState(0)
    local var4 = React.useRef(nil)
    React.useEffect(function()
        return function()
            if var4.current then
                task.cancel(var4.current)
                var4.current = nil
            end
        end
    end, {})

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        if not arg1 then
            return
        end
        local absoluteSizeX = arg1.AbsoluteSize.X
        if var4.current then
            task.cancel(var4.current)
        end
        var4.current = task.delay(0.2, function()
            var4.current = nil
            var3(absoluteSizeX)
        end)
    end, {})

    if tbl1.rowWidth ~= nil then
        var2 = tbl1.rowWidth
    end

    local var6 = if tbl1.breakpoint ~= nil then tbl1.breakpoint else getBreakpointFromRowWidth(if var2 > 0 then var2 else 0, uIScaleFromTokens)
    local var7 = useCatalogPageMonolithDependencies()
    local catalogGridWidget = var7.CatalogGridWidget
    local fetchWidgetInfo = var7.fetchWidgetInfo
    local catalogAnalytics = var7.catalogAnalytics

    local var8 = useNetworking()
    React.useEffect(function()
        fetchWidgetInfo(var8, nil, context)
    end, { context, var8, fetchWidgetInfo })

    local panelRef = React.useRef(nil)
    local onRequestImpressionsSignal = useOnRequestImpressionsSignal()

    local var11 = useAvatarRoute()
    local var12 = React.useRef(nil)
    if var12.current == nil then
        var12.current = var11.current.key
    end
    local pageFilter = React.useCallback(function(): boolean
        return var11.current.key == var12.current
    end, { var11 })

    local var14 = React.useRef({})
    local var15 = React.useRef({})
    local onImpressionsDetected = React.useCallback(function(tbl2)
        local current = var14.current
        local current2 = var15.current
        for _, value in tbl2 do
            if current[value.Name] then
                continue
            end

            local var16 = value:GetAttribute(Constants.ItemIndex)
            local var17 = if typeof(var16) == "number" then current2[var16] else nil

            if var17 ~= nil then
                catalogAnalytics.widgetInteractionV2(var17, WidgetConstants.ActionType.IMPRESSION)
                current[value.Name] = true
            end
        end
    end, { catalogAnalytics })

    local collectObjectsFunc = React.useCallback(function(arg1)
        local tagged = CollectionService:GetTagged(WidgetConstants.WidgetExposureMetadata.TagName)
        if arg1 == nil then
            return {}
        end
        local result = {}
        for _, value in tagged do
            if value:IsDescendantOf(arg1) then
                table.insert(result, value)
            end
        end
        return result
    end, {})

    local var18 = useWidgetListInfoViewModel(nil, context, var6)
    local var19 = not var18 and {} or not var18.widgets and {} or getOrderedWidgets(var18.widgets)

    if #var19 == 0 then
        return { status = "hidden" }
    end

    local smallMetrics = GridMetrics.getSmallMetrics(var2, Constants2.WIDGET_COLUMN_PADDING)

    local children = ({})
    local current = ({})

    for layoutOrder, value2 in var19 do
        local widget = value2.widget
        local position = value2.position

        local itemsPerRow = math.max(widget.template.previewColumns or 1, 1)

        local widgetAnalyticsInfo = {
            requestId = widget.requestId,
            widgetPosition = position,
            widgetId = widget.id,
            widgetType = widget.type,
            widgetAbsPosition = (position - 1) * itemsPerRow,
            widgetItemIds = getWidgetItemIdsFromWidgetInfo(widget, itemsPerRow)
        }
        current[position] = widgetAnalyticsInfo

        local id = widget.id
        local createElement = React.createElement
        local var20 = View
        local tbl5 = { tag = "size-full-0 auto-y", LayoutOrder = layoutOrder }
        local tbl6 = {
            Widget = React.createElement(catalogGridWidget, {
                widgetRow = position,
                widgetInfo = widget,
                itemsPerRow = itemsPerRow,
                rowCount = widget.template.previewRows,
                rowHeight = smallMetrics.itemWidth,
                itemSize = Vector2.new(smallMetrics.itemWidth, smallMetrics.itemWidth),
                widgetAnalyticsInfo = widgetAnalyticsInfo,
                itemDetailsPeekViewRefs = tbl1.itemDetailsPeekViewRefs,
                rowWidth = if var2 > 0 then var2 else nil
            })
        }
        children[id] = createElement(var20, tbl5, tbl6)
    end

    var15.current = current

    return {
        status = "visible",
        viewProps = {
            LayoutOrder = tbl1.LayoutOrder,
            panelRef = panelRef,
            onAbsoluteSizeChanged = onAbsoluteSizeChanged,
            onRequestImpressionsSignal = onRequestImpressionsSignal,
            pageFilter = pageFilter,
            onImpressionsDetected = onImpressionsDetected,
            collectObjectsFunc = collectObjectsFunc,
            children = children
        }
    }
end

return useWidgetPanelViewModel
