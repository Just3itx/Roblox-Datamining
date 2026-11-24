-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:51:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local React = require(GenericAbuseReportingParent.React)
local Foundation = require(GenericAbuseReportingParent.Foundation)
local UIBlox = require(GenericAbuseReportingParent.UIBlox)
local useLocalization = require(GenericAbuseReportingParent.Localization).Hooks.useLocalization
local useLocalizedStrings = require(GenericAbuseReporting.LocalizationKeys.useLocalizedStrings)
local useLayerCollector = UIBlox.Core.Layout.LayerCollector.useLayerCollector
local View = Foundation.View
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens
local createNextOrder = require(GenericAbuseReportingParent.ReactUtils).createNextOrder

local ButtonList = require(GenericAbuseReporting.Common.ButtonList)
local CommentTextField = require(GenericAbuseReporting.Common.CommentTextField)
local _ReasonDropdown = require(GenericAbuseReporting.Common.ReasonDropdown)
local ScrollViewGradient = require(GenericAbuseReporting.Common.ScrollViewGradient)
local SideModal = require(GenericAbuseReporting.Common.SideModal)
local SideModalDropdownButton = require(GenericAbuseReporting.Common.SideModalDropdownButton)

local function getContentRightPadding(vector2: Vector2, vector2_2: Vector2): number -- Luacid: Inlined by compiler; 1 call site recovered
    return if vector2.Y > vector2_2.Y then 16 else 1
end

local function DualDropdownSubmitDialog(tbl1)
    local var1 = useTokens()
    local absoluteSize = useLayerCollector().absoluteSize
    local isDropdownError, setDropdownError = React.useState(false)
    local var2, var3 = React.useState(false)
    local var6, var7 = React.useState("")
    local var8, var9 = React.useState("")
    local var10, var11 = React.useState("")
    local var12, var13 = React.useState("")
    local var14, var15 = React.useState("")
    local var16, var17 = React.useState(false)
    local var18, var19 = React.useState(false)
    local closeWithAnimation, var21 = React.useState(false)
    local text, onUpdate = React.useState("")

    local ref = React.useRef(nil)
    local var25, var26 = React.useState(Vector2.zero)
    local var27, var28 = React.useState(Vector2.zero)

    local var29 = useLocalizedStrings()
    local var30 = useLocalization({
        submitDialogProblemSubheading = "Feature.ReportAbuse.Label.WhatWasWrong",
        submitDialogSurfaceSubheading = "Feature.ReportAbuse.Label.WhereDidItHappen",
        selectOnePrompt = "Feature.ReportAbuse.Label.PleaseSelectOne",
        submitDialogCommentSubheading = "Feature.ReportAbuse.Label.TellUsWhatHappenedNoOptional",
        submitDialogTextBoxPlaceholder = "Feature.SettingsHub.Label.ReportComment",
        submitDialogOptional = "Feature.ReportAbuse.Label.Optional",
        chooseOne = "Feature.ReportAbuse.Label.ChooseOne"
    })

    local nextOrder = createNextOrder()

    React.useLayoutEffect(function()
        if ref.current then
            local scrollingFrame = ref.current:FindFirstChildWhichIsA("ScrollingFrame")
            if scrollingFrame then
                var26(scrollingFrame.AbsoluteCanvasSize)
                var28(scrollingFrame.AbsoluteWindowSize)

                local connection = scrollingFrame:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function()
                    var26(scrollingFrame.AbsoluteCanvasSize)
                end)

                local connection2 = scrollingFrame:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function()
                    var28(scrollingFrame.AbsoluteWindowSize)
                end)
                return function()
                    connection:Disconnect()
                    connection2:Disconnect()
                end
            end
        else
            var26(Vector2.zero)
            var28(Vector2.zero)
        end
        return function() end
    end, { ref.current, absoluteSize })

    local onActivated = React.useCallback(function()
        tbl1.onSubmit(var6, var12, text)
    end, {
        tbl1.onSubmit,
        var6,
        var12,
        text
    })
    local validateState = React.useCallback(function(): boolean
        if var6 ~= "" and var12 ~= "" then
            return true
        end
        if var6 == "" then
            setDropdownError(true)
        end
        if var12 == "" then
            var3(true)
        end
        return false
    end, {
        var6,
        var12,
        setDropdownError,
        var3
    })
    local onAbandon = React.useCallback(function()
        var17(false)
        var19(false)
    end, { var17, var19 })

    local createElement = React.createElement
    local var34 = View
    local tbl2 = { tag = "size-full auto-xy" }

    local tbl3 = { ReportFlowModal = 0, DropdownSideModalBackground = 0 }
    local createElement2 = React.createElement
    local var35 = SideModal
    local tbl4 = {
        screenSize = absoluteSize,
        buttonProps = {
            text = var29.formSubmit,
            onActivated = onActivated,
            validateState = validateState
        },
        footerContent = tbl1.footerContent,
        onAbandon = tbl1.onAbandon,
        title = var29.formTitle,
        width = math.min(400, absoluteSize.X - 50),
        height = math.min(500, absoluteSize.Y - 50)
    }
    local tbl5 = { SubmitReportFrame = 0 }
    local createElement3 = React.createElement
    local var36 = ScrollViewGradient
    local tbl6 = {
        Size = UDim2.new(1, 0, 1, 0),
        ref = ref,
        gradientHeight = 40
    }
    local tbl7 = {
        Layout = React.createElement("UIListLayout", {
            Padding = UDim.new(0, 30),
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        Padding = React.createElement("UIPadding", {
            PaddingBottom = UDim.new(0, 10),
            PaddingLeft = UDim.new(0, 1),
            PaddingRight = UDim.new(0, (getContentRightPadding(var25, var27)))
        }),
        ReportProblemFrame = 0,
        ReportSurfaceFrame = 0,
        ReportCommentFrame = 0
    }
    local createElement4 = React.createElement
    local var37 = View
    local tbl8 = {
        ZIndex = 3,
        tag = "size-full-0 auto-y col align-x-left",
        LayoutOrder = nextOrder()
    }
    local tbl9 = {
        ProblemHeading = React.createElement(FoundationText, {
            Text = "1. " .. var30.submitDialogProblemSubheading,
            fontStyle = var1.Typography.TitleLarge,
            textStyle = var1.Color.Content.Emphasis,
            tag = "auto-xy padding-bottom-medium",
            LayoutOrder = nextOrder()
        }),
        ProblemDropdownPosition = 0
    }
    local createElement5 = React.createElement
    local var38 = View
    local tbl10 = {
        Size = UDim2.new(1, 0, 0, 48),
        tag = "col align-x-left",
        LayoutOrder = nextOrder()
    }

    local tbl11 = {
        ProblemDropdown = React.createElement(SideModalDropdownButton, {
            setDropdownError = setDropdownError,
            onActivated = function()
                var17(true)
                var21(false)
            end,
            title = var30.submitDialogProblemSubheading,
            text = var8 ~= "" and var8 or var30.chooseOne,
            isDropdownError = isDropdownError
        }),
        ProblemSubtext = 0
    }
    local createElement6 = React.createElement
    local var39 = FoundationText
    local tbl12 = {
        Text = 0,
        TextWrapped = true,
        TextXAlignment = 0,
        fontStyle = 0,
        textStyle = 0,
        tag = "auto-xy padding-top-xxsmall",
        LayoutOrder = 0
    }

    if isDropdownError then
        var10 = var30.selectOnePrompt or var10
    end

    tbl12.Text = var10

    tbl12.TextXAlignment = Enum.TextXAlignment.Left
    tbl12.fontStyle = var1.Typography.BodySmall
    tbl12.textStyle = isDropdownError and var1.Color.System.Alert or var1.Color.Content.Muted

    tbl12.LayoutOrder = nextOrder()
    tbl11.ProblemSubtext = createElement6(var39, tbl12)
    tbl9.ProblemDropdownPosition = createElement5(var38, tbl10, tbl11)
    tbl7.ReportProblemFrame = createElement4(var37, tbl8, tbl9)

    tbl7.ReportSurfaceFrame = React.createElement(
        View,
        {
            tag = "size-full-0 auto-y col align-x-left",
            LayoutOrder = nextOrder()
        },
        {
            SurfaceHeading = React.createElement(FoundationText, {
                Text = "2. " .. var30.submitDialogSurfaceSubheading,
                fontStyle = var1.Typography.TitleLarge,
                textStyle = var1.Color.Content.Emphasis,
                tag = "auto-xy padding-bottom-medium",
                LayoutOrder = nextOrder()
            }),
            SurfaceDropdownPosition = React.createElement(
                View,
                {
                    Size = UDim2.new(1, 0, 0, 48),
                    tag = "col align-x-left",
                    LayoutOrder = nextOrder()
                },
                {
                    SurfaceDropdown = React.createElement(SideModalDropdownButton, {
                        setDropdownError = var3,
                        onActivated = function()
                            var19(true)
                            var21(false)
                        end,
                        title = var30.submitDialogSurfaceSubheading,
                        text = var12 ~= "" and var14 or var30.chooseOne,
                        isDropdownError = var2
                    }),
                    SurfaceSubtext = React.createElement(FoundationText, {
                        Text = var2 and var30.selectOnePrompt or "",
                        TextWrapped = true,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        fontStyle = var1.Typography.BodySmall,
                        textStyle = var1.Color.System.Alert,
                        tag = "auto-xy padding-top-xxsmall",
                        LayoutOrder = nextOrder()
                    })
                }
            )
        }
    )

    tbl7.ReportCommentFrame = React.createElement(
        View,
        {
            tag = "size-full-0 auto-y col align-x-left",
            LayoutOrder = nextOrder()
        },
        {
            CommentHeading = React.createElement(FoundationText, {
                Text = "3. " .. var30.submitDialogCommentSubheading,
                fontStyle = var1.Typography.TitleLarge,
                textStyle = var1.Color.Content.Emphasis,
                tag = "auto-xy padding-bottom-medium",
                LayoutOrder = nextOrder()
            }),
            CommentTextContainer = React.createElement(
                View,
                {
                    tag = "size-full-0 auto-y col align-x-left stroke-thick stroke-default radius-medium",
                    LayoutOrder = nextOrder()
                },
                {
                    CommentTextField = React.createElement(CommentTextField, {
                        text = text,
                        backgroundColor3 = var1.Color.Surface.Surface_100.Color3,
                        placeholderText = var30.submitDialogTextBoxPlaceholder,
                        onUpdate = onUpdate,
                        layoutOrder = nextOrder()
                    })
                }
            ),
            CommentSubtext = React.createElement(FoundationText, {
                Text = var30.submitDialogOptional,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                fontStyle = var1.Typography.CaptionSmall,
                tag = "auto-xy padding-top-xxsmall",
                LayoutOrder = nextOrder()
            })
        }
    )
    tbl5.SubmitReportFrame = createElement3(var36, tbl6, tbl7)
    tbl3.ReportFlowModal = createElement2(var35, tbl4, tbl5)
    local var40

    if var16 or var18 then
        local createElement7 = React.createElement
        local var41 = View
        local tbl13 = { tag = "size-full" }

        local tbl14 = { DropdownSideModalContainer = 0 }
        local createElement8 = React.createElement
        local var42 = View
        local tbl15 = { tag = "size-full" }

        local tbl16 = { DropdownSideModal = 0 }
        local createElement9 = React.createElement
        local var43 = SideModal
        local tbl17 = {
            screenSize = absoluteSize,
            title = if var16 then var30.submitDialogProblemSubheading else var30.submitDialogSurfaceSubheading,
            width = math.min(400, absoluteSize.X - 50) - 50,
            height = math.min(500, absoluteSize.Y - 50) - 50,
            onAbandon = onAbandon,
            closeWithAnimation = closeWithAnimation
        }
        local tbl18 = { ScrollView = 0 }
        local createElement10 = React.createElement
        local var44 = ScrollViewGradient
        local tbl19 = {
            Size = UDim2.new(1, 0, 1, 0),
            gradientHeight = 48
        }
        local tbl20 = {
            Padding = React.createElement("UIPadding", { PaddingRight = UDim.new(0, 16) }),
            ButtonList = 0
        }
        local createElement11 = React.createElement
        local var45 = ButtonList
        local tbl21 = {
            options = if var16 then tbl1.reportProblems else tbl1.reportSurfaces,
            onSelected = 0,
            setDescription = 0,
            defaultValue = 0
        }

        function tbl21.onSelected(str1: string, str2: string)
            if var16 then
                var7(str1)
                var9(str2)
                setDropdownError(false)
                var21(true)
                return
            end
            var13(str1)
            var15(str2)
            var3(false)
            var21(true)
        end

        if not var16 then
            var11 = nil
        end

        tbl21.setDescription = var11
        tbl21.defaultValue = if var16 then var6 else var12
        tbl20.ButtonList = createElement11(var45, tbl21)
        tbl18.ScrollView = createElement10(var44, tbl19, tbl20)
        tbl16.DropdownSideModal = createElement9(var43, tbl17, tbl18)
        tbl14.DropdownSideModalContainer = createElement8(var42, tbl15, tbl16)
        var40 = createElement7(var41, tbl13, tbl14)
    else
        var40 = nil
    end

    tbl3.DropdownSideModalBackground = var40
    return createElement(var34, tbl2, tbl3)
end

return DualDropdownSubmitDialog
