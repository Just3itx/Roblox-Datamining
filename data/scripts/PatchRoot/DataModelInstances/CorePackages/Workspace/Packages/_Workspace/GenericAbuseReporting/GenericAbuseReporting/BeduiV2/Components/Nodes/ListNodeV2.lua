-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Dash = require(GenericAbuseReportingParent.Dash)
local FocusBehaviors = require(GenericAbuseReportingParent.FocusBehaviors)
local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)
local ReactFocusNavigation = require(GenericAbuseReportingParent.ReactFocusNavigation)

local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local Empty = Foundation.Empty
local FillBehavior = Foundation.Enums.FillBehavior
local IconName = Foundation.Enums.IconName
local List = Foundation.List
local ListItemInputType = Foundation.Enums.ListItemInputType
local Skeleton = Foundation.Skeleton
local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens
local View = Foundation.View

local AbuseReportAnalyticsContext = require(GenericAbuseReporting.BeduiV2.Analytics.AbuseReportAnalyticsContext)
local _AbuseSheetFlowTypes = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.AbuseSheetFlowTypes)
local analyticsService = require(GenericAbuseReporting.BeduiV2.Analytics.analyticsService)
local Eyebrow = require(GenericAbuseReporting.BeduiV2.Components.Eyebrow)
local Footer = require(GenericAbuseReporting.BeduiV2.Components.Footer)
local LayoutSlots = require(GenericAbuseReporting.BeduiV2.Components.LayoutSlots)
local scrollToItem = require(GenericAbuseReporting.BeduiV2.Utils.scrollToItem)
local TextWithTranslation = require(GenericAbuseReporting.BeduiV2.Utils.Translate.TextWithTranslation)
local _translate = require(GenericAbuseReporting.BeduiV2.Utils.Translate.translate)
local useArTranslation = require(GenericAbuseReporting.BeduiV2.Utils.Translate.arTranslation).useArTranslation
local useListLoader = require(GenericAbuseReporting.BeduiV2.Loaders.useLoader).useListLoader

local formatErrorDetailForAnalytics = analyticsService.formatErrorDetailForAnalytics
local TelemetryEventType = analyticsService.TelemetryEventType
local useAbuseReportAnalytics = AbuseReportAnalyticsContext.useAbuseReportAnalytics
local useLayoutSlots = LayoutSlots.useLayoutSlots

local FFlagAbuseReportInExpPlayerListV3 = require(GenericAbuseReportingParent.SharedFlags).FFlagAbuseReportInExpPlayerListV3
local FFlagAbuseReportListNodeFullBleed = require(GenericAbuseReporting.Flags.FFlagAbuseReportListNodeFullBleed)
local FFlagAbuseReportImproveErrorEvents = require(GenericAbuseReporting.Flags.FFlagAbuseReportImproveErrorEvents)

local tbl1 = {
    chevron = nil,
    radio = ListItemInputType.Radio,
    toggle = ListItemInputType.Toggle,
    checkbox = ListItemInputType.Checkbox
}

local function ListNodeLoading(tbl2)
    local title = tbl2.title
    local eyebrow = tbl2.eyebrow
    local tokens = tbl2.tokens
    return React.createElement(tbl2.layout, {
        body = React.createElement(React.Fragment, nil, {
            Eyebrow = eyebrow and React.createElement(Eyebrow, { eyebrow = eyebrow, layoutOrder = 0 }),
            Title = React.createElement(tbl2.titleSlot, { input = title, layoutOrder = 1 }),
            SkeletonContainer = React.createElement(View, {
                tag = "col gap-medium size-full-0 auto-y",
                LayoutOrder = 2
            }, {
                Skeleton1 = React.createElement(Skeleton, { radius = Radius.Medium, Size = UDim2.new(1, 0, 0, tokens.Size.Size_600) }),
                Skeleton2 = React.createElement(Skeleton, { radius = Radius.Medium, Size = UDim2.new(1, 0, 0, tokens.Size.Size_600) }),
                Skeleton3 = React.createElement(Skeleton, { radius = Radius.Medium, Size = UDim2.new(1, 0, 0, tokens.Size.Size_600) }),
                Skeleton4 = React.createElement(Skeleton, { radius = Radius.Medium, Size = UDim2.new(1, 0, 0, tokens.Size.Size_600) }),
                Skeleton5 = React.createElement(Skeleton, { radius = Radius.Medium, Size = UDim2.new(1, 0, 0, tokens.Size.Size_600) })
            })
        })
    })
end

local function ListNodeError(tbl2)
    local translateIntoString = useArTranslation().translateIntoString

    return React.createElement(tbl2.layout, {
        body = React.createElement(React.Fragment, nil, {
            Eyebrow = tbl2.eyebrow and React.createElement(Eyebrow, { eyebrow = tbl2.eyebrow, layoutOrder = 0 }),
            Title = React.createElement(tbl2.titleSlot, { input = tbl2.title, layoutOrder = 1 }),
            ErrorText = React.createElement(
                TextWithTranslation,
                {
                    input = translateIntoString(tbl2.errorText),
                    tag = "size-full-0 auto-y text-body-small",
                    layoutOrder = 2
                }
            ),
            RetryButton = React.createElement(Button, {
                text = translateIntoString(tbl2.retryButtonText),
                variant = ButtonVariant.Standard,
                fillBehavior = Foundation.Enums.FillBehavior.Fit,
                onActivated = tbl2.retry,
                LayoutOrder = 3
            })
        })
    })
end

return React.memo(function(tbl2) -- name: ListNode
    local tokens = useTokens()
    local var2, var3 = React.useState(tbl2.initialValue or nil)
    local translateIntoString = useArTranslation().translateIntoString
    local sendEvent = useAbuseReportAnalytics().sendEvent
    local ref = React.useRef(nil)
    local hasScroll, var6 = React.useState(false)
    local didScroll, var8 = React.useState(false)
    local var9 = React.useRef(false)
    local var10 = React.useRef(false)

    local var11 = useListLoader(tbl2.items)
    local loading = var11.loading
    local error = var11.error
    local retry = var11.retry
    local data = var11.data

    local var12 = useLayoutSlots()
    local layout = var12.Layout
    local contentInset = var12.ContentInset
    local bool1 = not (data == nil) and #data > 0
    local isContentFullBleed = FFlagAbuseReportListNodeFullBleed and bool1

    local var14 = React.useContext(ReactFocusNavigation.FocusNavigationContext)
    local var15 = React.useRef(nil)
    React.useEffect(function()
        local current = ref.current
        if not (current and var14) then
            return
        end
        if not data or #data == 0 then
            return
        end

        local var16 = FocusBehaviors.mostRecentOrDefault(var15.current)
        var14:registerFocusBehavior(current, var16)

        return function()
            var14:deregisterFocusBehavior(current, var16)
        end
    end, { var14, data, var15 })

    React.useEffect(function()
        local current = ref.current
        if not current then
            return
        end

        local var16 = current:FindFirstChildWhichIsA("ScrollingFrame", true)
        if not var16 then
            return
        end

        local function checkScrollbar() -- Luacid: Inlined by compiler; 1 call site recovered
            local bool2 = var16.AbsoluteCanvasSize.Y > var16.AbsoluteWindowSize.Y
            var6(bool2)
        end

        local function onScroll()
            if var16.CanvasPosition.Y > 0 then
                var8(true)
            end
        end

        checkScrollbar()
        local connection = var16:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(checkScrollbar)

        local connection2 = var16:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(checkScrollbar)
        local connection3 = var16:GetPropertyChangedSignal("CanvasPosition"):Connect(onScroll)

        return function()
            connection:Disconnect()
            connection2:Disconnect()
            connection3:Disconnect()
        end
    end, { loading })

    local var16 = React.useRef({})
    local var17 = React.useRef(nil)

    React.useEffect(function()
        if var2 then
            var17.current = var16.current[var2]
            scrollToItem(ref, var17)
            return
        end
        var17.current = nil
    end, { var2 })

    React.useEffect(function()
        if not error or var9.current then
            return
        end

        var9.current = true
        sendEvent({
            sub_event_type = TelemetryEventType.Error,
            error_detail = not FFlagAbuseReportImproveErrorEvents and {
                error_message = "list: async load failed: " .. error
            }
                or formatErrorDetailForAnalytics("list: async load failed", error)
        })
    end, { error, sendEvent })

    React.useEffect(function()
        if not loading and not error and (data == nil or #data == 0) and not var10.current then
            var10.current = true
            sendEvent({ sub_event_type = TelemetryEventType.EmptyState })
        end
    end, {
        loading,
        error,
        data,
        sendEvent
    })
    local variant = tbl2.variant or "radio"
    local bool2 = variant == "chevron"

    local var18 = React.useCallback(function(selectedIndex: number, selectedId: string)
        if not data then
            return
        end
        sendEvent({
            sub_event_type = TelemetryEventType.SelectItem,
            select_item_detail = {
                selected_index = selectedIndex,
                selected_id = selectedId,
                list_length = #data,
                has_scroll = hasScroll,
                did_scroll = didScroll
            }
        })
    end, {
        sendEvent,
        hasScroll,
        didScroll,
        data
    })
    local var19 = React.useCallback(function(id: string)
        if not data then
            return
        end

        var3(id)
        local num1 = 0
        Dash.forEach(data, function(arg1, arg2)
            if arg1.id == id then
                num1 = arg2
            end
        end)

        var18(num1, id)
    end, { var18, data })

    local onActivated = React.useCallback(function()
        if not data then
            return
        end

        local var20 = Dash.find(data, function(arg1): boolean
            return arg1.id == var2
        end)
        if tbl2.onNext then
            tbl2.onNext(var2, var20)
        end
    end, { data, tbl2.onNext, var2 })

    local title = var12.Title

    if loading then
        return React.createElement(
            ListNodeLoading,
            {
                layout = layout,
                titleSlot = title,
                title = tbl2.title,
                eyebrow = tbl2.eyebrow,
                tokens = tokens
            }
        )
    end
    if error then
        return React.createElement(ListNodeError, {
            layout = layout,
            titleSlot = title,
            title = tbl2.title,
            eyebrow = tbl2.eyebrow,
            errorText = tbl2.errorText,
            retryButtonText = tbl2.retryButtonText,
            tokens = tokens,
            retry = retry
        })
    end

    local createElement = React.createElement
    local fragment = React.Fragment
    local var21 = nil
    local tbl3

    if data == nil or #data == 0 then
        tbl3 = { Empty = 0 }
        local createElement2 = React.createElement
        local var22 = Empty
        local tbl4 = {
            text = if tbl2.emptyText then translateIntoString(tbl2.emptyText) else nil
        }
        tbl3.Empty = createElement2(var22, tbl4)
    else
        tbl3 = {
            Eyebrow = if FFlagAbuseReportListNodeFullBleed then nil else React.createElement(Eyebrow, { eyebrow = tbl2.eyebrow, layoutOrder = 0 }),
            Title = if FFlagAbuseReportListNodeFullBleed then nil else React.createElement(title, { input = tbl2.title, subtitle = tbl2.subtitle, layoutOrder = 1 }),
            Header = if FFlagAbuseReportListNodeFullBleed then React.createElement(contentInset, {
                layoutOrder = 0
            }, {
                Eyebrow = tbl2.eyebrow and React.createElement(Eyebrow, { eyebrow = tbl2.eyebrow, layoutOrder = 0 }),
                Title = React.createElement(title, { input = tbl2.title, subtitle = tbl2.subtitle, layoutOrder = 1 })
            }) else nil,
            ItemListContainer = React.createElement(View, {
                tag = "size-full-0 auto-y",
                LayoutOrder = 2
            }, {
                ItemList = React.createElement(
                    List.Root,
                    {
                        hasDivider = { hasDivider = true, isInset = false },
                        isContained = { isContained = false, hasMargin = true }
                    },
                    {
                        Dash.map(data, function(arg1, layoutOrder: number)
                            local trailing = if FFlagAbuseReportInExpPlayerListV3 and tbl2.renderTrailingAccessory then tbl2.renderTrailingAccessory(arg1) else nil
                            local createElement2 = React.createElement
                            local item = List.Item

                            local tbl4 = {
                                leading = if type(arg1.leading) == "string" then IconName[arg1.leading] else arg1.leading,
                                title = translateIntoString(arg1.label),
                                description = if arg1.description then translateIntoString(arg1.description) else nil,
                                trailing = trailing,
                                onActivated = {
                                    onActivated = bool2 and function()
                                        var18(layoutOrder, arg1.id)
                                        if tbl2.onNext then
                                            tbl2.onNext(arg1.id, arg1)
                                        end
                                    end or function()
                                        var19(arg1.id)
                                    end,
                                    inputType = tbl1[variant],
                                    isChecked = var2 == arg1.id
                                },
                                LayoutOrder = layoutOrder,
                                ref = 0
                            }

                            function tbl4.ref(current)
                                var16.current[arg1.id] = current
                                if layoutOrder == 1 then
                                    var15.current = current
                                end
                            end

                            return createElement2(item, tbl4)
                        end)
                    }
                )
            }),
            Footer = 0
        }

        local element

        if FFlagAbuseReportListNodeFullBleed then
            element = tbl2.footerItems
                and React.createElement(
                    contentInset,
                    { layoutOrder = 3 },
                    React.createElement(Footer, { footerItems = tbl2.footerItems, additionalTag = "padding-top-medium" })
                )
        else
            element = tbl2.footerItems
                and React.createElement(Footer, { footerItems = tbl2.footerItems, additionalTag = "padding-top-medium", layoutOrder = 3 })
        end

        tbl3.Footer = element
    end

    local body = createElement(fragment, var21, tbl3)
    local actions = if tbl2.onNext and not bool2 and var2 ~= nil then React.createElement(Button, {
        text = translateIntoString(tbl2.nextButtonText),
        variant = ButtonVariant.Emphasis,
        fillBehavior = FillBehavior.Fill,
        isLoading = tbl2.isSubmitting,
        isDisabled = tbl2.isSubmitting,
        onActivated = onActivated
    }) else nil
    return React.createElement(layout, { ref = ref, body = body, actions = actions, isContentFullBleed = isContentFullBleed })
end)
