-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Dash = require(GenericAbuseReportingParent.Dash)
local FocusNavigationUtils = require(GenericAbuseReportingParent.FocusNavigationUtils)
local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)

local FFlagAbuseReportImproveErrorEvents = require(GenericAbuseReporting.Flags.FFlagAbuseReportImproveErrorEvents)

local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local DialogSize = Foundation.Enums.DialogSize
local FillBehavior = Foundation.Enums.FillBehavior
local Icon = Foundation.Icon
local IconName = Foundation.Enums.IconName
local IconVariant = Foundation.Enums.IconVariant
local List = Foundation.List
local ListItemInputType = Foundation.Enums.ListItemInputType
local Radius = Foundation.Enums.Radius
local Sheet = Foundation.Sheet
local Skeleton = Foundation.Skeleton
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens
local View = Foundation.View

local useInExpCustomSubmit = require(GenericAbuseReporting.BeduiV2.Hooks.useInExpCustomSubmit)
local useInExpFocusNavigationRefs = require(GenericAbuseReporting.BeduiV2.Hooks.FocusNavigation.useInExpFocusNavigationRefs)

local AbuseReportAnalyticsContext = require(GenericAbuseReporting.BeduiV2.Analytics.AbuseReportAnalyticsContext)
local _AbuseSheetFlowTypes = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.AbuseSheetFlowTypes)
local analyticsService = require(GenericAbuseReporting.BeduiV2.Analytics.analyticsService)
local Footer = require(GenericAbuseReporting.BeduiV2.Components.Footer)
local InExpDropdownWithPopover = require(GenericAbuseReporting.BeduiV2.Components.InExpDropdownWithPopover)
local LayoutSlots = require(GenericAbuseReporting.BeduiV2.Components.LayoutSlots)
local scrollToItem = require(GenericAbuseReporting.BeduiV2.Utils.scrollToItem)
local TextWithTranslation = require(GenericAbuseReporting.BeduiV2.Utils.Translate.TextWithTranslation)
local _translate = require(GenericAbuseReporting.BeduiV2.Utils.Translate.translate)
local useArTranslation = require(GenericAbuseReporting.BeduiV2.Utils.Translate.arTranslation).useArTranslation
local useGroupedListLoader = require(GenericAbuseReporting.BeduiV2.Loaders.useLoader).useGroupedListLoader

local formatErrorDetailForAnalytics = analyticsService.formatErrorDetailForAnalytics
local TelemetryEventType = analyticsService.TelemetryEventType
local useAbuseReportAnalytics = AbuseReportAnalyticsContext.useAbuseReportAnalytics
local useLayoutSlots = LayoutSlots.useLayoutSlots

local bool1 = game:DefineFastFlag("FixChatSelectorDropdownPadding", false)

local function useScrollToSelected(str1: string?, tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    React.useEffect(function()
        if not str1 then
            return
        end

        local current = tbl1.current[str1]
        if not current then
            return
        end

        local scrollingFrame = current:FindFirstAncestorWhichIsA("ScrollingFrame")
        if not scrollingFrame then
            return
        end

        local bool2 = false

        local tbl2 = {
            current = scrollingFrame.Parent
        }
        local tbl3 = { current = current }

        local function performScroll() -- Luacid: Inlined by compiler; 2 call sites recovered
            if bool2 then
                return
            end
            scrollToItem(tbl2, tbl3)
        end

        if current.AbsoluteSize.Y > 0 then
            performScroll()
        else
            local connection = nil
            connection = current:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                if current.AbsoluteSize.Y > 0 then
                    connection:Disconnect()
                    performScroll()
                end
            end)

            task.delay(2, function()
                if connection.Connected then
                    connection:Disconnect()
                end
            end)
        end

        return function()
            bool2 = true
        end
    end, { str1 })
end

local REPORT_MESSAGE_NOT_SHOWN_ITEM_ID = useInExpCustomSubmit.REPORT_MESSAGE_NOT_SHOWN_ITEM_ID

local function LoadingContent()
    local var1 = useTokens()

    return React.createElement(Sheet.Content, nil, {
        SkeletonContainer = React.createElement(View, { tag = "col gap-medium size-full-0 auto-y" }, Dash.map(table.create(5, true), function(_: boolean, num1: number)
            return React.createElement(
                Skeleton,
                {
                    key = tostring(num1),
                    radius = Radius.Medium,
                    Size = UDim2.new(1, 0, 0, var1.Size.Size_800)
                }
            )
        end))
    })
end

local function ErrorContent(tbl1)
    local translateIntoString = useArTranslation().translateIntoString

    return React.createElement(Sheet.Content, nil, {
        ErrorContainer = React.createElement(View, {
            tag = "align-x-center align-y-center gap-medium size-full"
        }, {
            ErrorText = React.createElement(FoundationText, {
                Text = translateIntoString(tbl1.errorText),
                RichText = true,
                tag = "auto-xy text-body-medium text-wrap text-align-x-left"
            }),
            RetryButton = React.createElement(Button, {
                text = translateIntoString(tbl1.retryButtonText),
                variant = ButtonVariant.Standard,
                fillBehavior = FillBehavior.Fit,
                onActivated = tbl1.retry or function() end
            })
        })
    })
end

return React.memo(function(tbl1) -- name: InExpChatSelectionNode
    local var1, var2 = React.useState(tbl1.initialValue or nil)
    local var3 = React.useRef(nil)
    local var4, var5 = React.useState(nil)
    local isOpen, var7 = React.useState(true)
    local translateIntoString = useArTranslation().translateIntoString
    local var8 = React.useRef({})
    local var9 = React.useRef(false)
    local sendEvent = useAbuseReportAnalytics().sendEvent
    local var10 = React.useRef(false)
    local var11 = React.useRef(false)
    local ref = React.useRef(nil)
    local var13 = React.useRef(false)
    local var14 = React.useRef(false)

    local layout = useLayoutSlots().Layout

    local var15 = useGroupedListLoader(tbl1.items)
    local data = var15.data or {}
    useScrollToSelected(var1, var8)

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
            var10.current = var16.AbsoluteCanvasSize.Y > var16.AbsoluteWindowSize.Y
        end

        local function onScroll()
            if var16.CanvasPosition.Y > 0 then
                var11.current = true
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
    end, { var15.loading })

    React.useEffect(function()
        if not var15.error or var13.current then
            return
        end

        var13.current = true
        sendEvent({
            sub_event_type = TelemetryEventType.Error,
            error_detail = not FFlagAbuseReportImproveErrorEvents and {
                error_message = "inExpChatSelection: load failed: " .. var15.error
            }
                or formatErrorDetailForAnalytics("inExpChatSelection: load failed", var15.error)
        })
    end, { var15.error, sendEvent })

    local bool2 = #data > 1
    local value = React.useMemo(function()
        if var4 then
            return var4
        end
        if var1 then
            for _, value in ipairs(data) do
                for _, item in ipairs(value.items) do
                    if item.id == var1 then
                        return value.id
                    end
                end
            end
        end
        return data[1] and data[1].id or nil
    end, { var4, var1, data })

    local var17 = React.useMemo(function()
        if #data == 0 then
            return {}
        end
        local var17 = Dash.find(data, function(arg1): boolean
            return arg1.id == value
        end)

        local var18 = tbl1.reportMessageNotShownText
            and tbl1.reportMessageNotShownText ~= ""
            and {{
                id = REPORT_MESSAGE_NOT_SHOWN_ITEM_ID,
                label = tbl1.reportMessageNotShownText
            }}
            or {}

        for _, value in ipairs(var17 and var17.items or {}) do
            table.insert(var18, value)
        end
        return var18
    end, { data, value, tbl1.reportMessageNotShownText })

    local id = if var17[#var17] then var17[#var17].id or nil else nil

    React.useEffect(function()
        if var1 or not id then
            return
        end

        local current = var8.current[id]
        if not current then
            return
        end

        local bool3 = false

        local function performScroll() -- Luacid: Inlined by compiler; 2 call sites recovered
            if bool3 then
                return
            end
            scrollToItem(ref, { current = current })
        end

        if current.AbsoluteSize.Y > 0 then
            performScroll()
        else
            local connection = nil
            connection = current:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                if current.AbsoluteSize.Y > 0 then
                    connection:Disconnect()
                    performScroll()
                end
            end)

            task.delay(2, function()
                if connection.Connected then
                    connection:Disconnect()
                end
            end)
        end

        return function()
            bool3 = true
        end
    end, { id, var1 })

    React.useEffect(function()
        if not var15.loading and not var15.error and #var17 == 0 and not var14.current then
            var14.current = true
            sendEvent({ sub_event_type = TelemetryEventType.EmptyState })
        end
    end, {
        var15.loading,
        var15.error,
        var17,
        sendEvent
    })
    local onActivated = React.useCallback(function()
        var9.current = true
        var7(false)
    end, {})

    local var19 = React.useCallback(function()
        var7(false)
    end, {})

    local var20, onOpenChange = React.useState(false)

    local var6 = useInExpFocusNavigationRefs(FocusNavigableSurfaceIdentifierEnum.CentralOverlay, var19, not var20)

    local items = React.useMemo(function()
        return Dash.map(data, function(tbl2)
            return {
                id = tbl2.id,
                text = tbl2.label
            }
        end)
    end, { data })

    local var12 = React.useCallback(function()
        var2(REPORT_MESSAGE_NOT_SHOWN_ITEM_ID)
        var3.current = {
            id = REPORT_MESSAGE_NOT_SHOWN_ITEM_ID,
            label = tbl1.reportMessageNotShownText
        }
        onActivated()
    end, { onActivated })

    local element

    if var15.loading then
        element = React.createElement(LoadingContent)
    elseif var15.error then
        element = React.createElement(
            ErrorContent,
            {
                retry = var15.retry,
                errorText = tbl1.errorText,
                retryButtonText = tbl1.retryButtonText
            }
        )
    elseif #var17 == 0 then
        element = React.createElement(Sheet.Content, nil, {
            Empty = React.createElement(View, {
                tag = "col align-x-center align-y-center gap-medium size-full"
            }, {
                Empty = React.createElement(TextWithTranslation, { input = tbl1.emptyText, tag = "auto-xy", LayoutOrder = 1 }),
                ReportAMessageNotShown = React.createElement(FoundationText, {
                    Text = `<u>{translateIntoString(tbl1.reportMessageNotShownText)}</u>`,
                    RichText = true,
                    tag = "auto-xy padding-small text-wrap text-align-x-center radius-medium",
                    onActivated = var12,
                    LayoutOrder = 2
                })
            })
        })
    else
        local createElement = React.createElement
        local content = Sheet.Content
        local tbl2 = { isContentFullBleed = true, ref = ref }
        local tbl3 = {
            ChannelDropdown = if bool1 and bool2 then React.createElement(
                View,
                { tag = "auto-xy padding-x-xlarge padding-top-xsmall", LayoutOrder = 1 },
                React.createElement(InExpDropdownWithPopover, {
                    value = value,
                    items = items,
                    LayoutOrder = 1,
                    onOpenChange = onOpenChange,
                    onItemChanged = function(arg1)
                        local previousChannelName = value or ""
                        local newChannelName = tostring(arg1)
                        var2(nil)
                        var5(newChannelName)
                        sendEvent({
                            sub_event_type = TelemetryEventType.TextChannelSwitch,
                            text_channel_switch_detail = {
                                previous_channel_name = previousChannelName,
                                new_channel_name = newChannelName,
                                channel_count = #data
                            }
                        })
                    end
                })
            ) elseif bool2 then React.createElement(InExpDropdownWithPopover, {
                value = value,
                items = items,
                LayoutOrder = 1,
                onOpenChange = onOpenChange,
                onItemChanged = function(arg1)
                    local previousChannelName = value or ""
                    local newChannelName = tostring(arg1)
                    var2(nil)
                    var5(newChannelName)
                    sendEvent({
                        sub_event_type = TelemetryEventType.TextChannelSwitch,
                        text_channel_switch_detail = {
                            previous_channel_name = previousChannelName,
                            new_channel_name = newChannelName,
                            channel_count = #data
                        }
                    })
                end
            }) else nil,
            ItemList = React.createElement(List.Root, {
                hasDivider = { hasDivider = true, isInset = false },
                isContained = { isContained = false, hasMargin = true },
                LayoutOrder = 2
            }, {
                Dash.map(var17, function(current, num1: number)
                    local trailing = if current.meta and current.meta.presetId and current.meta.presetId ~= "" then React.createElement(Icon, { name = IconName.LightningBolt, variant = IconVariant.Filled }) else nil

                    return React.createElement(List.Item, {
                        description = translateIntoString(current.label),
                        trailing = trailing,
                        onActivated = {
                            onActivated = function()
                                var2(current.id)
                                var3.current = current
                                sendEvent({
                                    sub_event_type = TelemetryEventType.SelectItem,
                                    select_item_detail = {
                                        selected_index = num1,
                                        selected_id = current.id,
                                        list_length = #var17,
                                        has_scroll = var10.current,
                                        did_scroll = var11.current
                                    }
                                })
                            end,
                            inputType = ListItemInputType.Radio,
                            isChecked = var1 == current.id
                        },
                        LayoutOrder = num1,
                        ref = function(arg1)
                            var8.current[current.id] = arg1
                        end,
                        key = current.id
                    })
                end)
            }),
            Footer = tbl1.footerItems
                and React.createElement(Footer, { footerItems = tbl1.footerItems, additionalTag = "padding-top-medium", layoutOrder = 3 })
        }

        element = createElement(content, tbl2, tbl3)
    end

    local createElement = React.createElement
    local fragment = React.Fragment
    local var25 = nil
    local tbl2 = {
        Content = React.createElement(layout, { body = nil, actions = nil }),
        ChatSelectionSheet = 0
    }
    local createElement2 = React.createElement
    local root = Sheet.Root

    local tbl3 = {
        ref = var6,
        isOpen = isOpen,
        centerSheetHeight = 1,
        size = DialogSize.Medium,
        preferCenterSheet = true,
        snapPoints = { 0.9 },
        onClose = function()
            if var9.current then
                var9.current = false
                if tbl1.onNext then
                    tbl1.onNext(var1, var3.current)
                end
            elseif tbl1.goBack then
                tbl1.goBack()
            end
        end
    }

    local tbl4 = {
        SheetHeader = React.createElement(Sheet.Header, nil, {
            Title = React.createElement(FoundationText, {
                tag = "align-x-left auto-xy text-title-large text-truncate-end content-emphasis",
                Text = translateIntoString(tbl1.title)
            })
        }),
        SheetContent = element,
        SheetActions = 0
    }
    local element2

    if var15.loading or var15.error or var1 == nil or var1 == REPORT_MESSAGE_NOT_SHOWN_ITEM_ID and not (#var17 > 0) then
        element2 = nil
    else
        element2 = React.createElement(Sheet.Actions, nil, {
            Button = React.createElement(Button, {
                variant = ButtonVariant.Emphasis,
                text = translateIntoString(tbl1.nextButtonText),
                isLoading = tbl1.isSubmitting,
                isDisabled = tbl1.isSubmitting,
                fillBehavior = FillBehavior.Fill,
                onActivated = onActivated
            })
        })
    end

    tbl4.SheetActions = element2
    tbl2.ChatSelectionSheet = createElement2(root, tbl3, tbl4)
    return createElement(fragment, var25, tbl2)
end)
