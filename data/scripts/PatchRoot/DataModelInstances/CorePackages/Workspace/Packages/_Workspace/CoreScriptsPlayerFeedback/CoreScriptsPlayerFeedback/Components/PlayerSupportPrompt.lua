-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreScriptsPlayerFeedback = script:FindFirstAncestor("CoreScriptsPlayerFeedback")
local CoreScriptsPlayerFeedbackParent = CoreScriptsPlayerFeedback.Parent

local React = require(CoreScriptsPlayerFeedbackParent.React)

local Foundation = require(CoreScriptsPlayerFeedbackParent.Foundation)
local Dialog = Foundation.Dialog
local Button = Foundation.Button
local Checkbox = Foundation.Checkbox
local Dropdown = Foundation.Dropdown
local Icon = Foundation.Icon
local TextArea = Foundation.TextArea
local FoundationText = Foundation.Text
local View = Foundation.View
local ButtonVariant = Foundation.Enums.ButtonVariant
local IconSize = Foundation.Enums.IconSize
local InputSize = Foundation.Enums.InputSize
local InputVariant = Foundation.Enums.InputVariant
local useTokens = Foundation.Hooks.useTokens

local BuilderIcons = require(CoreScriptsPlayerFeedbackParent.BuilderIcons)
local IconVariant = BuilderIcons.IconVariant

local useLocalization = require(CoreScriptsPlayerFeedbackParent.Localization).Hooks.useLocalization

local constants = require(CoreScriptsPlayerFeedback.constants)
local useEscapeDismiss = require(CoreScriptsPlayerFeedback.Hooks.useEscapeDismiss)
local FFlagPlayerSupportPromptEventIngest = require(CoreScriptsPlayerFeedback.Flags.FFlagPlayerSupportPromptEventIngest)
local PlayerSupportPromptTelemetry = require(CoreScriptsPlayerFeedback.Telemetry.PlayerSupportPromptTelemetry)
local FFlagEnablePlayerSupportCaptureAttachments = require(CoreScriptsPlayerFeedback.Flags.FFlagEnablePlayerSupportCaptureAttachments)
local FFlagEnablePlayerSupportSuggestionCategory = require(CoreScriptsPlayerFeedback.Flags.FFlagEnablePlayerSupportSuggestionCategory)
local _CaptureTypes = require(CoreScriptsPlayerFeedback.CaptureTypes)
local useCaptureUploads = require(CoreScriptsPlayerFeedback.Hooks.useCaptureUploads)
local useGalleryCaptures = require(CoreScriptsPlayerFeedback.Hooks.useGalleryCaptures)
local CapturePreviewTile = require(CoreScriptsPlayerFeedback.Components.CapturePreviewTile)
local CapturePickerGrid = require(CoreScriptsPlayerFeedback.Components.CapturePickerGrid)
local CapturePickerPreview = require(CoreScriptsPlayerFeedback.Components.CapturePickerPreview)
local getCaptureKey = require(CoreScriptsPlayerFeedback.Utils.getCaptureKey)

local var1 = React.memo(function(tbl1)
    local var1 = useTokens()

    local num1 = 0
    for _ in tbl1.uploadStatuses do
        num1 += 1
    end
    local bool1 = num1 > 0

    local var2 = useLocalization({
        CapturesHeading = {
            "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Captures.Heading",
            count = tostring(num1),
            max = tostring(tbl1.maxSelections)
        },
        CapturesAdd = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Captures.Add",
        CapturesHint = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Captures.Hint",
        CapturesEditSelection = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Captures.EditSelection",
        CapturesUploadError = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Captures.UploadError"
    })

    local tbl2 = {
        UIGridLayout = React.createElement("UIGridLayout", {
            CellPadding = UDim2.new(0, 6, 0, 6),
            CellSize = UDim2.new(0, 80, 0, 80),
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        UIPadding = React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, 2),
            PaddingBottom = UDim.new(0, 2),
            PaddingLeft = UDim.new(0, 2),
            PaddingRight = UDim.new(0, 2)
        })
    }

    local tbl3 = {}
    for key, captureStatus in tbl1.uploadStatuses do
        table.insert(tbl3, { key = key, captureStatus = captureStatus })
    end
    table.sort(tbl3, function(arg1, arg2): boolean
        return (arg1.captureStatus.order or 0) < (arg2.captureStatus.order or 0)
    end)
    local num2 = 0
    for _, value in tbl3 do
        num2 += 1
        local key = value.key
        local key2 = value.key
        local createElement = React.createElement
        local var3 = CapturePreviewTile
        local tbl4 = {
            capture = value.captureStatus.capture,
            status = value.captureStatus.status,
            failureReason = value.captureStatus.failureReason,
            layoutOrder = num2,
            onRemove = 0
        }

        function tbl4.onRemove()
            tbl1.onCaptureRemoved(key)
        end

        tbl2[key2] = createElement(var3, tbl4)
    end

    if bool1 then
        tbl2.EditSelectionButton = React.createElement("ImageButton", {
            BackgroundColor3 = var1.Color.Surface.Surface_300.Color3,
            BackgroundTransparency = 0,
            BorderSizePixel = 0,
            Image = "",
            LayoutOrder = num2 + 1,
            Size = UDim2.new(0, 80, 0, 80),
            [React.Event.Activated] = tbl1.onPickerOpen
        }, {
            Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 8) }),
            Layout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                Padding = UDim.new(0, 4),
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center
            }),
            ImageIcon = React.createElement(Icon, {
                name = BuilderIcons.Icon.Image,
                size = IconSize.Medium,
                variant = IconVariant.Filled,
                style = {
                    Color3 = var1.Color.Content.Muted.Color3
                },
                LayoutOrder = 1
            }),
            Label = React.createElement(
                FoundationText,
                {
                    Text = var2.CapturesEditSelection,
                    tag = "auto-xy text-caption-small text-wrap content-muted",
                    LayoutOrder = 2
                }
            )
        })
    end

    local bool2 = false
    for _, value in tbl1.uploadStatuses do
        if value.status == "failed" and value.failureReason ~= Enum.UploadCaptureResult.CaptureModerated then
            bool2 = true
        end
    end

    local createElement = React.createElement
    local var3 = View
    local tbl4 = {
        tag = "col gap-small size-full-0 auto-y",
        GroupTransparency = if tbl1.category == "" then 0.75 else 0,
        LayoutOrder = 3,
        padding = {
            top = UDim.new(0, 4),
            bottom = UDim.new(0, 4)
        }
    }
    local tbl5 = {
        Heading = if bool1 then React.createElement(FoundationText, {
            Text = var2.CapturesHeading,
            tag = "size-0 auto-xy text-title-medium text-wrap text-align-x-left text-align-y-top",
            textStyle = var1.Color.Content.Emphasis,
            LayoutOrder = 1
        }) else nil,
        PreviewGrid = if bool1 then React.createElement(
            "Frame",
            {
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                LayoutOrder = 2,
                Size = UDim2.new(1, 0, 0, 0)
            },
            tbl2
        ) else nil,
        ErrorHint = if bool2 then React.createElement(FoundationText, {
            Text = var2.CapturesUploadError,
            tag = "size-full-0 auto-y text-caption-small text-wrap text-align-x-left content-alert",
            LayoutOrder = 3
        }) else nil,
        EmptyRow = 0
    }
    local element

    if bool1 then
        element = nil
    else
        element = React.createElement(View, {
            tag = "row align-y-center gap-medium size-full-0 auto-y",
            LayoutOrder = 2
        }, {
            AddButton = React.createElement(Button, {
                text = var2.CapturesAdd,
                variant = ButtonVariant.Standard,
                size = InputSize.Medium,
                onActivated = tbl1.onPickerOpen,
                isDisabled = tbl1.category == "",
                LayoutOrder = 1
            }),
            Hint = React.createElement(FoundationText, {
                Text = var2.CapturesHint,
                tag = "fill size-full-0 text-body-medium text-wrap text-align-x-left content-muted",
                LayoutOrder = 2
            })
        })
    end

    tbl5.EmptyRow = element
    return createElement(var3, tbl4, tbl5)
end)

local PLAYER_SUPPORT_CATEGORIES_REQUIRING_USER_ID = constants.PLAYER_SUPPORT_CATEGORIES_REQUIRING_USER_ID

return (React.memo(function(tbl1)
    local var2 = useTokens()
    local description = tbl1.description
    local setDescription = tbl1.setDescription
    local category = tbl1.category
    local setCategory = tbl1.setCategory
    local shareUserId = tbl1.shareUserId
    local setShareUserId = tbl1.setShareUserId

    local var3 = nil
    local var4 = nil
    local var5 = nil
    local var6 = nil
    local var7 = nil
    local var8 = nil
    local var9 = nil
    local var10 = nil
    if FFlagEnablePlayerSupportCaptureAttachments then
        var3 = useCaptureUploads()
        var4 = useGalleryCaptures()
        var5, var6 = React.useState(false)
        var7, var8 = React.useState({})
        var9, var10 = React.useState(nil)
    end

    local minFeedbackLength = constants.MIN_FEEDBACK_LENGTH
    local maxPlayerSupportLength = constants.MAX_PLAYER_SUPPORT_LENGTH

    local var11 = useLocalization({
        Title = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Title",
        ReportAbuseLead = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.ReportAbuse.Lead",
        ReportAbuseLink = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.ReportAbuse.Link",
        CategoryLabel = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Category.Label",
        CategoryPlaceholder = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Category.Placeholder",
        CategoryItemBugReport = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Category.BugReport",
        CategoryItemDataRestoreRequest = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Category.DataRestoreRequest",
        CategoryItemPurchasingIssue = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Category.PurchasingIssue",
        CategoryItemSuggestion = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Category.Suggestion",
        CategoryItemOther = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Category.Other",
        DescriptionLabel = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Description.Label",
        DescriptionPlaceholderBugReport = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Placeholder.BugReport",
        DescriptionPlaceholderDataRestoreRequest = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Placeholder.DataRestoreRequest",
        DescriptionPlaceholderPurchasingIssue = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Placeholder.PurchasingIssue",
        DescriptionPlaceholderSuggestion = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Placeholder.Suggestion",
        DescriptionPlaceholderOther = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Placeholder.Other",
        DescriptionHint = {
            "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Description.CharacterLimitHint",
            MAX = tostring(maxPlayerSupportLength)
        },
        ShareUserIdLabel = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.ShareUserId.Label",
        ShareUserIdLabelRequired = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.ShareUserId.LabelRequired",
        ShareUserIdHint = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.ShareUserId.Hint",
        Send = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Send",
        Add = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Add",
        Cancel = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Cancel",
        Select = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Select",
        Deselect = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Deselect",
        CapturesAdd = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Captures.Add"
    })

    local items = {
        {
            id = "TICKET_CATEGORY_BUG_REPORT",
            text = var11.CategoryItemBugReport
        },
        {
            id = "TICKET_CATEGORY_DATA_RESTORE_REQUEST",
            text = var11.CategoryItemDataRestoreRequest
        },
        {
            id = "TICKET_CATEGORY_PURCHASING_ISSUE",
            text = var11.CategoryItemPurchasingIssue
        }
    }

    if FFlagEnablePlayerSupportSuggestionCategory then
        table.insert(items, { id = "TICKET_CATEGORY_SUGGESTION", text = var11.CategoryItemSuggestion })
    end

    table.insert(items, { id = "TICKET_CATEGORY_OTHER", text = var11.CategoryItemOther })

    local tbl3 = {
        TICKET_CATEGORY_BUG_REPORT = var11.DescriptionPlaceholderBugReport,
        TICKET_CATEGORY_DATA_RESTORE_REQUEST = var11.DescriptionPlaceholderDataRestoreRequest,
        TICKET_CATEGORY_PURCHASING_ISSUE = var11.DescriptionPlaceholderPurchasingIssue,
        TICKET_CATEGORY_OTHER = var11.DescriptionPlaceholderOther
    }

    if FFlagEnablePlayerSupportSuggestionCategory then
        tbl3.TICKET_CATEGORY_SUGGESTION = var11.DescriptionPlaceholderSuggestion
    end

    local bool1 = PLAYER_SUPPORT_CATEGORIES_REQUIRING_USER_ID[category] == true
    local var12 = bool1 or shareUserId

    local tbl4 = {}
    local num1 = 0
    local bool2 = false
    local var13 = nil
    local var14 = nil
    local func1

    if FFlagEnablePlayerSupportCaptureAttachments then
        var13 = React.useCallback(function()
            if category == "" then
                return
            end
            var6(true)
        end, { category })

        React.useEffect(function()
            if not var5 then
                var8({})
                var10(nil)
                return
            end

            local tbl5 = ({})
            for value in var3.uploadStatuses do
                tbl5[value] = true
            end
            var8(tbl5)
            var10(nil)
            var4.load()
        end, { var5 })

        tbl4 = React.useMemo(function()
            local result = {}
            for _, value in var4.captures do
                if var7[getCaptureKey(value)] then
                    table.insert(result, value)
                end
            end
            return result
        end, { var4.captures, var7 })

        num1 = #tbl4
        bool2 = num1 >= 5

        var14 = React.useCallback(function(arg1)
            local captureKey = getCaptureKey(arg1)
            var8(function(arg2)
                local bool3 = arg2[captureKey] == true
                if not bool3 and bool2 then
                    return arg2
                end
                local var15 = table.clone(arg2)
                if bool3 then
                    var15[captureKey] = nil
                else
                    var15[captureKey] = true
                end
                return var15
            end)
        end, { bool2 })

        local bool3 = next(var3.uploadStatuses) ~= nil
        func1 = function()
            if num1 == 0 and not bool3 then
                return
            end
            var3.onCapturesAdded(tbl4)
            var6(false)
        end
    else
        func1 = nil
    end

    local var15

    if FFlagEnablePlayerSupportCaptureAttachments then
        local captureTime = if var9 then var9.CaptureTime else nil
        local robloxLocaleId = game:GetService("LocalizationService").RobloxLocaleId
        var15 = useLocalization({
            dateTime = {
                "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Captures.Picker.DateTime",
                date = if captureTime then captureTime:FormatLocalTime("L", robloxLocaleId) else "",
                time = if captureTime then captureTime:FormatLocalTime("LT", robloxLocaleId) else ""
            }
        })
    else
        var15 = nil
    end

    local bool3 = minFeedbackLength <= #description
        and #description <= maxPlayerSupportLength
        and category ~= ""
        and not (var3 and var3.anyUploading or var3 and var3.hasNonModerationFailure)

    if FFlagPlayerSupportPromptEventIngest then
        React.useEffect(function()
            PlayerSupportPromptTelemetry.log({
                action = PlayerSupportPromptTelemetry.Action.Opened,
                category = category,
                shareUserId = var12,
                descriptionLength = #description
            })
        end, {})
    end

    local onActivated = React.useCallback(function()
        if not bool3 then
            return
        end
        if FFlagPlayerSupportPromptEventIngest then
            PlayerSupportPromptTelemetry.log({
                action = PlayerSupportPromptTelemetry.Action.Submitted,
                category = category,
                shareUserId = var12,
                shareUserIdRequired = bool1,
                descriptionLength = #description
            })
        end
        pcall(function()
            local SocialService = game:GetService("SocialService")
            if not SocialService.SignalFeedbackSubmissionCompleted then
                return
            end

            local options = {
                Description = description,
                Category = category,
                ShareUserIdPreference = if var12 then "SHARE_USER_ID_PREFERENCE_SHARE" else "SHARE_USER_ID_PREFERENCE_DO_NOT_SHARE"
            }

            if FFlagEnablePlayerSupportCaptureAttachments then
                local assetIds = {}
                for _, value in var3.uploadStatuses do
                    if value.status == "succeeded" and value.assetId ~= nil then
                        table.insert(assetIds, value.assetId)
                    end
                end
                if #assetIds > 0 then
                    options.AssetIds = assetIds
                end
            end
            SocialService:SignalFeedbackSubmissionCompleted("", options)
        end)

        tbl1.closePrompt()
    end, FFlagPlayerSupportPromptEventIngest and {
        description,
        category,
        var12,
        bool1,
        bool3,
        var3 or false,
        tbl1.closePrompt
    }
        or {
            description,
            category,
            var12,
            bool3,
            var3 or false,
            tbl1.closePrompt
        })

    local var17 = React.useCallback(function()
        pcall(function()
            local SocialService = game:GetService("SocialService")
            if SocialService.SignalFeedbackSubmissionPermissionDenied then
                SocialService:SignalFeedbackSubmissionPermissionDenied()
            end
        end)
        tbl1.onFormAbandoned()
        tbl1.closePrompt()
    end, { tbl1.closePrompt, tbl1.onFormAbandoned })

    local onClose = if FFlagPlayerSupportPromptEventIngest then React.useCallback(function()
        PlayerSupportPromptTelemetry.log({
            action = PlayerSupportPromptTelemetry.Action.Dismissed,
            dismissMethod = PlayerSupportPromptTelemetry.DismissMethod.DialogClose,
            category = category,
            shareUserId = var12,
            descriptionLength = #description
        })
        var17()
    end, {
        var17,
        category,
        var12,
        description
    }) else var17

    local var19 = if FFlagPlayerSupportPromptEventIngest then React.useCallback(function()
        PlayerSupportPromptTelemetry.log({
            action = PlayerSupportPromptTelemetry.Action.Dismissed,
            dismissMethod = PlayerSupportPromptTelemetry.DismissMethod.Escape,
            category = category,
            shareUserId = var12,
            descriptionLength = #description
        })
        var17()
    end, {
        var17,
        category,
        var12,
        description
    }) else var17

    local var16 = React.useCallback(function()
        if FFlagPlayerSupportPromptEventIngest then
            PlayerSupportPromptTelemetry.log({
                action = PlayerSupportPromptTelemetry.Action.ReportAbuseClicked,
                category = category,
                shareUserId = var12,
                descriptionLength = #description
            })
        end
        pcall(function()
            local SocialService = game:GetService("SocialService")
            if SocialService.SignalFeedbackSubmissionPermissionDenied then
                SocialService:SignalFeedbackSubmissionPermissionDenied()
            end
        end)
        tbl1.onFormAbandoned()
        tbl1.closePrompt()
        pcall(function()
            local robloxGui = game:GetService("CoreGui"):FindFirstChild("RobloxGui")
            local modules = robloxGui and robloxGui:FindFirstChild("Modules") or nil
            local settings = modules and modules:FindFirstChild("Settings") or nil
            local settingsHub = settings and settings:FindFirstChild("SettingsHub") or nil
            if not settingsHub then
                return
            end
            local var20 = require(settingsHub)
            var20:SetVisibility(true, false, var20.Instance.ReportAbusePage)
        end)
    end, FFlagPlayerSupportPromptEventIngest and {
        category,
        var12,
        description,
        tbl1.closePrompt,
        tbl1.onFormAbandoned
    }
        or { tbl1.closePrompt, tbl1.onFormAbandoned })

    local var21 = if FFlagEnablePlayerSupportCaptureAttachments then React.useCallback(function()
        if var9 then
            var10(nil)
        elseif var5 then
            var6(false)
        else
            var19()
        end
    end, { var9, var5, var19 }) else var19

    useEscapeDismiss("PlayerSupportPromptCancel", var21)

    local createElement = React.createElement
    local root = Dialog.Root
    local tbl5 = { onClose = onClose, hasBackdrop = true }

    local tbl6 = {
        Title = React.createElement(Dialog.Title, {
            text = if FFlagEnablePlayerSupportCaptureAttachments and var5 and var9 ~= nil then if var9.CaptureTime ~= nil then var15.dateTime else var11.CapturesAdd elseif FFlagEnablePlayerSupportCaptureAttachments and var5 then var11.CapturesAdd else var11.Title
        }),
        Content = 0,
        Actions = 0
    }
    local var22

    if FFlagEnablePlayerSupportCaptureAttachments and var5 then
        local createElement2 = React.createElement
        local content = Dialog.Content
        local tbl7 = { LayoutOrder = 1 }

        local tbl8 = {
            PickerBody = if var9 ~= nil then React.createElement(CapturePickerPreview, { capture = var9 }) else React.createElement(
                CapturePickerGrid,
                {
                    captures = var4.captures,
                    isLoading = var4.isLoading,
                    hasMore = var4.hasMore,
                    selectedKeys = var7,
                    maxSelections = 5,
                    onToggle = var14,
                    onPreview = function(arg1)
                        var10(arg1)
                    end,
                    onLoadMore = var4.loadMore
                }
            )
        }

        var22 = createElement2(content, tbl7, tbl8)
    else
        local createElement2 = React.createElement
        local content = Dialog.Content
        local tbl7 = { LayoutOrder = 1 }

        local tbl8 = { Body = 0 }
        local createElement3 = React.createElement
        local var23 = View
        local tbl9 = {
            tag = "col gap-medium size-full-0 auto-y",
            padding = {
                top = UDim.new(0, -(var2.Gap.XLarge - var2.Gap.Large))
            }
        }
        local tbl10 = {
            ReportAbuseRow = React.createElement(View, {
                tag = "row gap-small auto-y",
                LayoutOrder = 0
            }, {
                Lead = React.createElement(FoundationText, { Text = var11.ReportAbuseLead, tag = "auto-xy", LayoutOrder = 1 }),
                Link = React.createElement(FoundationText, {
                    Text = var11.ReportAbuseLink,
                    RichText = true,
                    onActivated = var16,
                    selection = { Selectable = true },
                    tag = "auto-xy",
                    LayoutOrder = 2
                })
            }),
            CategorySection = 0,
            Description = 0,
            CapturesSection = 0,
            ShareCheckboxRow = 0
        }

        local createElement4 = React.createElement
        local var24 = View
        local tbl11 = { tag = "col gap-small size-full-0 auto-y", LayoutOrder = 1 }

        local tbl12 = {
            Label = React.createElement(FoundationText, {
                Text = var11.CategoryLabel,
                tag = "size-0 auto-xy text-title-medium text-wrap text-align-x-left text-align-y-top",
                textStyle = var2.Color.Content.Emphasis,
                LayoutOrder = 1
            }),
            DropdownBorder = 0
        }

        local createElement5 = React.createElement
        local var25 = View
        local tbl13 = {
            Size = UDim2.new(1, -var2.Stroke.Standard * 2, 0, 0),
            Position = UDim2.new(0, var2.Stroke.Standard, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            tag = "radius-medium",
            stroke = {
                Color = var2.Color.Stroke.Default.Color3,
                Thickness = var2.Stroke.Standard,
                Transparency = var2.Color.Stroke.Default.Transparency
            },
            cornerRadius = UDim.new(0, var2.Radius.Medium),
            LayoutOrder = 2
        }
        local tbl14 = { Dropdown = 0 }
        local createElement6 = React.createElement
        local root2 = Dropdown.Root
        local tbl15 = {
            label = "",
            value = if category == "" then nil else category,
            placeholder = var11.CategoryPlaceholder,
            items = items,
            size = InputSize.Medium,
            variant = InputVariant.Utility,
            width = UDim.new(1, 0),
            onItemChanged = 0
        }

        function tbl15.onItemChanged(arg1)
            setCategory(tostring(arg1))
        end

        tbl14.Dropdown = createElement6(root2, tbl15)
        tbl12.DropdownBorder = createElement5(var25, tbl13, tbl14)
        tbl10.CategorySection = createElement4(var24, tbl11, tbl12)

        tbl10.Description = React.createElement(
            View,
            {
                tag = "col gap-small size-full-0 auto-y",
                GroupTransparency = if category == "" then 0.75 else 0,
                LayoutOrder = 2
            },
            {
                Label = React.createElement(FoundationText, {
                    Text = var11.DescriptionLabel,
                    tag = "size-0 auto-xy text-title-medium text-wrap text-align-x-left text-align-y-top",
                    textStyle = var2.Color.Content.Emphasis,
                    LayoutOrder = 1
                }),
                InputBorderSlot = React.createElement(View, {
                    tag = "size-full-0 auto-y",
                    LayoutOrder = 2
                }, {
                    InputBorder = React.createElement(View, {
                        Size = UDim2.new(1, -var2.Stroke.Standard * 2, 0, 0),
                        Position = UDim2.new(0, var2.Stroke.Standard, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        tag = "radius-medium",
                        stroke = {
                            Color = var2.Color.Stroke.Default.Color3,
                            Thickness = var2.Stroke.Standard,
                            Transparency = var2.Color.Stroke.Default.Transparency
                        },
                        cornerRadius = UDim.new(0, var2.Radius.Medium)
                    }, {
                        Input = React.createElement(TextArea, {
                            text = description,
                            onChanged = setDescription,
                            placeholder = tbl3[category] or "",
                            label = "",
                            hint = "",
                            width = UDim.new(1, 0),
                            variant = InputVariant.Utility,
                            numLines = 4,
                            size = InputSize.Medium,
                            isDisabled = category == ""
                        })
                    })
                }),
                Hint = React.createElement(FoundationText, {
                    Text = var11.DescriptionHint,
                    tag = "size-full-0 auto-y text-caption-small text-wrap text-align-x-left text-align-y-top",
                    textStyle = var2.Color.Content.Emphasis,
                    LayoutOrder = 3
                })
            }
        )

        tbl10.CapturesSection = if FFlagEnablePlayerSupportCaptureAttachments then React.createElement(var1, {
            uploadStatuses = var3.uploadStatuses,
            category = category,
            maxSelections = 5,
            onCaptureRemoved = var3.onCaptureRemoved,
            onPickerOpen = var13
        }) else nil

        local createElement7 = React.createElement
        local var26 = View
        local tbl16 = {
            tag = "col gap-xsmall size-full-0 auto-y",
            LayoutOrder = if FFlagEnablePlayerSupportCaptureAttachments then 4 else 3
        }
        local tbl17 = { Checkbox = 0, HintRow = 0 }
        local createElement8 = React.createElement
        local var27 = Checkbox
        local tbl18 = {
            label = if bool1 then var11.ShareUserIdLabelRequired else var11.ShareUserIdLabel,
            isChecked = var12,
            isDisabled = bool1,
            onActivated = 0,
            size = 0,
            LayoutOrder = 1
        }

        function tbl18.onActivated(bool4: boolean)
            setShareUserId(bool4)
        end
        tbl18.size = InputSize.Medium
        tbl17.Checkbox = createElement8(var27, tbl18)

        tbl17.HintRow = React.createElement(
            View,
            {
                tag = "size-full-0 auto-y",
                padding = {
                    left = UDim.new(0, var2.Size.Size_600 + var2.Gap.Medium)
                },
                LayoutOrder = 2
            },
            {
                Hint = React.createElement(
                    FoundationText,
                    {
                        Text = var11.ShareUserIdHint,
                        tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-muted"
                    }
                )
            }
        )
        tbl10.ShareCheckboxRow = createElement7(var26, tbl16, tbl17)
        tbl8.Body = createElement3(var23, tbl9, tbl10)
        var22 = createElement2(content, tbl7, tbl8)
    end

    tbl6.Content = var22
    local var23

    if FFlagEnablePlayerSupportCaptureAttachments and var5 then
        local createElement2 = React.createElement
        local actions = Dialog.Actions
        local tbl7 = { LayoutOrder = 2, actions = 0 }
        local tbl8

        if var9 ~= nil then
            local captureKey = getCaptureKey(var9)
            local bool4 = var7[captureKey] == true
            local bool5 = bool4 or not bool2
            tbl8 = { nil, nil }
            local tbl9 = {
                text = if bool4 then var11.Deselect else var11.Select,
                variant = if bool4 then ButtonVariant.SoftEmphasis elseif bool5 then ButtonVariant.Emphasis else ButtonVariant.Standard,
                isDisabled = not (bool5 or bool4),
                onActivated = 0
            }

            function tbl9.onActivated()
                var14(var9)
                var10(nil)
            end

            tbl8[1], tbl8[2] = tbl9, {
                text = var11.Cancel,
                variant = ButtonVariant.Standard,
                onActivated = function()
                    var10(nil)
                end
            }
        else
            tbl8 = {
                {
                    text = var11.Add,
                    variant = if num1 > 0 then ButtonVariant.Emphasis else ButtonVariant.Standard,
                    isDisabled = num1 == 0 and not next(var3.uploadStatuses),
                    onActivated = func1
                },
                {
                    text = var11.Cancel,
                    variant = ButtonVariant.Standard,
                    onActivated = function()
                        var6(false)
                    end
                }
            }
        end

        tbl7.actions = tbl8
        var23 = createElement2(actions, tbl7)
    else
        local createElement2 = React.createElement
        local actions = Dialog.Actions
        local tbl7 = {
            LayoutOrder = 2,
            actions = {{
                text = var11.Send,
                variant = if bool3 then ButtonVariant.Emphasis else ButtonVariant.Standard,
                onActivated = onActivated,
                isDisabled = not bool3
            }}
        }
        var23 = createElement2(actions, tbl7)
    end

    tbl6.Actions = var23
    return createElement(root, tbl5, tbl6)
end))
