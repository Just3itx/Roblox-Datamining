-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local DsaIllegalContentReporting = require(GenericAbuseReportingParent.DsaIllegalContentReporting)
local FocusNavigationUtils = require(GenericAbuseReportingParent.FocusNavigationUtils)
local React = require(GenericAbuseReportingParent.React)
local ReactFocusNavigation = require(GenericAbuseReportingParent.ReactFocusNavigation)
local SharedFlags = require(GenericAbuseReportingParent.SharedFlags)
local UIBlox = require(GenericAbuseReportingParent.UIBlox)
local Foundation = require(GenericAbuseReportingParent.Foundation)
local useLocalization = require(GenericAbuseReportingParent.Localization).Hooks.useLocalization
local useLocalizedStrings = require(GenericAbuseReporting.LocalizationKeys.useLocalizedStrings)
local CommentTextField = require(GenericAbuseReporting.Common.CommentTextField)
local Frame = require(GenericAbuseReporting.Common.Frame)
local UIListLayout = require(GenericAbuseReporting.Common.UIListLayout)
local ReasonDropdown = require(GenericAbuseReporting.Common.ReasonDropdown)
local MODAL_POSITION_OFFSET = require(GenericAbuseReporting.Common.MODAL_POSITION_OFFSET)

local PartialPageModal = UIBlox.App.Dialog.Modal.PartialPageModal
local CloseButtonIcon = UIBlox.App.Dialog.Enum.CloseButtonIcon
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local useLayerCollector = UIBlox.Core.Layout.LayerCollector.useLayerCollector
local useTokens = Foundation.Hooks.useTokens
local View = Foundation.View
local ScrollView = Foundation.ScrollView
local ScrollBarVisibility = Foundation.Enums.ScrollBarVisibility
local FoundationText = Foundation.Text

local GenericReportLink = DsaIllegalContentReporting.GenericReportLink
local var1 = DsaIllegalContentReporting.isShowGenericIllegalContentReportingLink()
local TakeItDownReportLink = DsaIllegalContentReporting.TakeItDownReportLink
local getTakeItDownReportLinkVisibility = DsaIllegalContentReporting.getTakeItDownReportLinkVisibility

local useAnalyticsDispatch = require(GenericAbuseReporting.Analytics.useAnalyticsDispatch)
local OnFormCommentUpdated = require(GenericAbuseReporting.Analytics.Actions.OnFormCommentUpdated)
local OnFormReasonSelected = require(GenericAbuseReporting.Analytics.Actions.OnFormReasonSelected)

local createNextOrder = require(GenericAbuseReportingParent.ReactUtils).createNextOrder
local FFlagAddAbuseReportOffsetForLandscape = SharedFlags.FFlagAddAbuseReportOffsetForLandscape
local FFlagAddTakeItDownReportLinkToSurfaces = SharedFlags.FFlagAddTakeItDownReportLinkToSurfaces

local function getScreenSizeOffset(vector2: Vector2): number -- Luacid: Inlined by compiler; 1 call site recovered
    if FFlagAddAbuseReportOffsetForLandscape then
        if vector2.X > vector2.Y then
            return 180
        end

        return 100
    end

    return 100
end

local function getContentRightPadding(vector2: Vector2, vector2_2: Vector2): number -- Luacid: Inlined by compiler; 1 call site recovered
    return if vector2.Y > vector2_2.Y then 16 else 1
end

local function SubmitDialog(tbl1)
    local var2 = useAnalyticsDispatch()
    local var3 = ReactFocusNavigation.useFocusGuiObject()
    local var4 = FocusNavigationUtils.useLastInputMode()
    local var5 = useTokens()
    local isDropdownError, setDropdownError = React.useState(false)
    local var8, var9 = React.useState("")
    local text, setDescription = React.useState("")
    local var6, var13 = React.useState("")
    local ref = React.useRef(nil)
    local var15, var16 = React.useState(Vector2.zero)
    local var17, var18 = React.useState(Vector2.zero)
    local var19, var20 = React.useState(0)
    local var21, var22 = React.useState(0)
    local var7 = React.useRef(nil)
    local var24, var25 = React.useState(0)
    local var10 = React.useRef(nil)
    local var27, var28 = React.useState(0)
    local maxHeight, var30 = React.useState(96)

    local var31 = useLayerCollector()
    local absoluteSize = var31.absoluteSize

    React.useEffect(function()
        var30(math.max(96, var15.Y - (var24 - var21) - var19 - 20))
    end, {
        var15.Y,
        var24,
        var21,
        var19
    })
    React.useEffect(function()
        if var7.current then
            var20(var7.current.AbsoluteSize.Y)
            var25(var7.current.AbsolutePosition.Y)
        end
    end, { var7.current, absoluteSize })

    React.useEffect(function()
        if not ref.current then
            var16(Vector2.zero)

            return
        end

        local scrollingFrame = ref.current:FindFirstChildWhichIsA("ScrollingFrame")
        if scrollingFrame then
            scrollingFrame:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function()
                var18(scrollingFrame.AbsoluteWindowSize)
                var16(scrollingFrame.AbsoluteCanvasSize)
            end)
            scrollingFrame.Selectable = false
        end
        var22(ref.current.AbsolutePosition.Y)
    end, { ref.current, absoluteSize })

    React.useEffect(function()
        if var10.current then
            var28(var10.current.AbsoluteContentSize.Y)
        end
    end, { var10.current })

    local onActivated = React.useCallback(function()
        if var8 ~= "" then
            tbl1.onSubmit(var8, var6)
        elseif tbl1.reportCategoryDefaultKey ~= nil then
            tbl1.onSubmit(tbl1.reportCategoryDefaultKey, var6)
        else
            setDropdownError(true)
        end
    end, {
        tbl1.onSubmit,
        var8,
        var6,
        setDropdownError
    })
    local onSelectedAbuseType = React.useCallback(function(reasonSelection)
        var9(reasonSelection)
        var2(OnFormReasonSelected({ reason_selection = reasonSelection }))

        if var4 ~= "Focus" or not var7.current then
            return
        end

        local spawnButton = var7.current:FindFirstChild("SpawnButton", true)
        if spawnButton and spawnButton:IsA("GuiObject") then
            var3(spawnButton)
        end
    end, { var2, var3, var4 })

    local onUpdate = React.useCallback(function(str1: string)
        var13(str1)
        var2(OnFormCommentUpdated({ comment_added = #str1 > 0 }))
    end, { var2 })

    local var35 = if tbl1.localizationKeys then useLocalization(tbl1.localizationKeys) else useLocalizedStrings()
    local var36 = useLocalization({
        submitDialogReasonSubheading = "Feature.ReportAbuse.Label.WhatWasWrong",
        selectOnePrompt = "Feature.ReportAbuse.Label.PleaseSelectOne",
        submitDialogCommentSubheading = "Feature.ReportAbuse.Label.TellUsWhatHappened",
        submitDialogTextBoxPlaceholder = "Feature.SettingsHub.Label.ReportComment",
        defaultKey = tbl1.reportCategories[1].localizationKey
    })

    local nextOrder = createNextOrder()

    local element = React.createElement(ReasonDropdown, {
        options = tbl1.reportCategories,
        screenSize = absoluteSize,
        maxHeight = maxHeight,
        menuItemHeight = 48,
        isDropdownError = isDropdownError,
        setDropdownError = setDropdownError,
        onSelectedAbuseType = onSelectedAbuseType,
        reportCategoryDefaultKey = tbl1.reportCategoryDefaultKey,
        setDescription = setDescription,
        isDisabled = tbl1.isDisabled
    })

    local element2 = React.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = nextOrder()
    }, {
        Layout = React.createElement(UIListLayout, {
            Padding = UDim.new(0, 7),
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left
        }),
        Padding = React.createElement("UIPadding", { PaddingBottom = UDim.new(0, 15) }),
        TextFrame = React.createElement(
            View,
            {
                Size = UDim2.new(1, 0, 0, 48),
                tag = "radius-medium stroke-standard stroke-system-neutral padding-left-small"
            },
            {
                Text = React.createElement(
                    FoundationText,
                    {
                        Text = var36.defaultKey,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        tag = "size-full content-muted"
                    }
                )
            }
        )
    })
    local var37 = React.useMemo(function()
        return function()
            return React.createElement(
                View,
                { tag = "size-full-0 auto-y col padding-x-xlarge padding-top-small" },
                {
                    GenericReportingLink = if var1 then React.createElement(GenericReportLink, { layoutOrder = 2 }) else nil
                }
            )
        end
    end, {})

    local var38 = if FFlagAddTakeItDownReportLinkToSurfaces then React.useMemo(function()
        return function()
            return React.createElement(View, {
                tag = "col gap-medium size-full-0 auto-y padding-x-xlarge padding-top-small"
            }, {
                GenericReportLink = if var1 then React.createElement(GenericReportLink) else nil,
                TakeItDownReportLink = if getTakeItDownReportLinkVisibility() then React.createElement(TakeItDownReportLink, { layoutOrder = 2 }) else nil
            })
        end
    end, {}) else nil

    local var39 = FFlagAddTakeItDownReportLinkToSurfaces and (var1 or getTakeItDownReportLinkVisibility())

    local createElement = React.createElement
    local var40 = PartialPageModal
    local tbl2 = {
        screenSize = Vector2.new(
            absoluteSize.X * (tbl1.scaleDialog and tbl1.scaleDialog.X or 1),
            (absoluteSize.Y - var31.insets.top) * (tbl1.scaleDialog and tbl1.scaleDialog.Y or 1)
        ),
        position = UDim2.new(0.5, 0, 0, var31.insets.top + MODAL_POSITION_OFFSET),
        anchorPoint = Vector2.new(0.5, 0),
        title = var35.formTitle,
        onCloseClicked = tbl1.onAbandon,
        buttonStackProps = {
            buttons = {{
                buttonType = ButtonType.PrimaryContextual,
                props = {
                    onActivated = onActivated,
                    text = var35.formSubmit
                }
            }}
        },
        footerContent = 0,
        closeButtonIcon = 0
    }
    local footerContent

    if FFlagAddTakeItDownReportLinkToSurfaces then
        footerContent = tbl1.footerContent

        if not footerContent then
            if var39 then
                footerContent = var38 or nil
            else
                footerContent = nil
            end
        end
    else
        footerContent = tbl1.footerContent

        if not footerContent then
            if var1 then
                footerContent = var37 or nil
            else
                footerContent = nil
            end
        end
    end

    tbl2.footerContent = footerContent

    tbl2.closeButtonIcon = if tbl1.useBackButton then CloseButtonIcon.Back else nil
    local tbl3 = { SubmitContainer = 0 }
    local createElement2 = React.createElement
    local str1 = "Frame"
    local tbl4 = {
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.fromScale(1, 0)
    }
    local tbl5 = { SubmitReportFrame = 0 }
    local createElement3 = React.createElement
    local var41 = ScrollView
    local tbl6 = {
        Size = UDim2.new(
            1,
            0,
            0,
            math.min(
                absoluteSize.Y - var31.insets.top - getScreenSizeOffset(absoluteSize) - (tbl1.footerContent == nil and var1 and 25 or 0),
                var27 + 50 + 50
            )
        ),
        scroll = {
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.fromOffset(0, 0),
            scrollBarVisibility = ScrollBarVisibility.Always,
            ScrollingDirection = Enum.ScrollingDirection.Y
        },
        ref = ref
    }
    local tbl7 = {
        Layout = React.createElement(UIListLayout, {
            Padding = UDim.new(0, 16),
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            Ref = var10
        }),
        Padding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, 16),
            PaddingBottom = UDim.new(0, 16),
            PaddingLeft = UDim.new(0, 1),
            PaddingRight = UDim.new(0, (getContentRightPadding(var15, var17)))
        }),
        TopCustomComponent = tbl1.topCustomComponent,
        ReportReasonFrame = 0,
        ReportCommentFrame = 0
    }
    local createElement4 = React.createElement
    local var42 = Frame
    local tbl8 = {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        ZIndex = 2,
        LayoutOrder = nextOrder()
    }
    local tbl9 = {
        Layout = React.createElement(UIListLayout, {
            Padding = UDim.new(0, 14),
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left
        }),
        ReportReasonSubheading = React.createElement(StyledTextLabel, {
            text = "1. " .. var36.submitDialogReasonSubheading,
            fontStyle = var5.Typography.TitleLarge,
            colorStyle = var5.Color.Content.Default,
            layoutOrder = nextOrder(),
            automaticSize = Enum.AutomaticSize.XY
        }),
        DropdownPosition = 0,
        ReportReasonSubtext = 0,
        Padding = 0
    }
    local createElement5 = React.createElement
    local var43 = Frame
    local tbl10 = {
        AutomaticSize = Enum.AutomaticSize.None,
        Size = UDim2.new(1, 0, 0, 48),
        ZIndex = 2,
        LayoutOrder = nextOrder(),
        ref = var7
    }
    local tbl11 = { ReportReasonPrompt = 0 }
    if tbl1.isReportCategoryReadonly then
        element = element2
    end

    tbl11.ReportReasonPrompt = element
    tbl9.DropdownPosition = createElement5(var43, tbl10, tbl11)
    local element3

    if isDropdownError then
        element3 = React.createElement(StyledTextLabel, {
            text = var36.selectOnePrompt,
            fontStyle = var5.Typography.BodySmall,
            colorStyle = var5.Color.System.Alert,
            layoutOrder = nextOrder(),
            automaticSize = Enum.AutomaticSize.XY
        })
    elseif text == "" then
        element3 = nil
    else
        element3 = React.createElement(StyledTextLabel, {
            text = text,
            fontStyle = var5.Typography.BodySmall,
            colorStyle = var5.Color.Content.Default,
            layoutOrder = nextOrder(),
            automaticSize = Enum.AutomaticSize.XY
        })
    end

    tbl9.ReportReasonSubtext = element3

    tbl9.Padding = if text == "" and not isDropdownError then nil else React.createElement("UIPadding", { PaddingBottom = UDim.new(0, 10) })
    tbl7.ReportReasonFrame = createElement4(var42, tbl8, tbl9)

    tbl7.ReportCommentFrame = React.createElement(
        Frame,
        {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = nextOrder()
        },
        {
            Layout = React.createElement(UIListLayout, {
                Padding = UDim.new(0, 14),
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Left
            }),
            Padding = React.createElement("UIPadding", { PaddingBottom = UDim.new(0, 15) }),
            ReportCommentSubheading = React.createElement(StyledTextLabel, {
                text = "2. " .. var36.submitDialogCommentSubheading,
                fontStyle = var5.Typography.TitleLarge,
                colorStyle = var5.Color.Content.Default,
                layoutOrder = nextOrder(),
                automaticSize = Enum.AutomaticSize.XY
            }),
            CommentTextField = React.createElement(
                CommentTextField,
                {
                    layoutOrder = nextOrder(),
                    text = var6,
                    placeholderText = var36.submitDialogTextBoxPlaceholder,
                    onUpdate = onUpdate
                }
            )
        }
    )
    tbl5.SubmitReportFrame = createElement3(var41, tbl6, tbl7)
    tbl3.SubmitContainer = createElement2(str1, tbl4, tbl5)
    return createElement(var40, tbl2, tbl3)
end

return SubmitDialog
