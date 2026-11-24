-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local Foundation = require(ExpChatParent.Foundation)
local InputType = require(ExpChatParent.InputType)
local React = require(ExpChatParent.React)
local RoactUtils = require(ExpChatParent.RoactUtils)
local SignalsReact = require(ExpChatParent.SignalsReact)

local EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint = require(ExpChatParent.SharedFlags).EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local FoundationText = Foundation.Text
local GetPresetChatStore = require(ExpChat.Stores.GetPresetChatStore)
local GetMessagesStore = require(ExpChat.Stores.GetMessagesStore)
local GetTransparencyStore = require(ExpChat.Stores.GetTransparencyStore)
local Localization = require(ExpChat.Localization)
local PresetBorderlessGridButton = require(script.Parent.PresetBorderlessGridButton)
local PresetCooldownProvider = require(script.Parent.PresetCooldownProvider)
local PresetMessageButton = require(script.Parent.PresetMessageButton)
local PresetTrayKeyboardSelected = require(ExpChat.Actions.PresetTrayKeyboardSelected)
local Constants = require(ExpChat.PresetChat.Constants)
local setIsPresetTrayOpen = require(script.Parent.Thunks.setIsPresetTrayOpen)
local useOnEmojiActivated = require(script.Parent.useOnEmojiActivated)
local useOnPresetActivated = require(script.Parent.useOnPresetActivated)
local FFlagExpChatPresetChatGamepadEnabled = require(ExpChat.Flags.FFlagExpChatPresetChatGamepadEnabled)
local FFlagExpChatPresetChatTabMemory = require(ExpChat.Flags.FFlagExpChatPresetChatTabMemory)
local FFlagExpChatPresetTrayDismissAnalytics = require(ExpChat.Flags.FFlagExpChatPresetTrayDismissAnalytics)

local FFlagExpChatPresetTrayPresetOnlyDisclaimer = require(ExpChat.Flags.FFlagExpChatPresetTrayPresetOnlyDisclaimer)

return React.memo(function(tbl1) -- name: PresetChatContainer
    local var1 = Foundation.Hooks.useTokens()
    local presetChatStore = GetPresetChatStore(false)
    local var2 = useDispatch()
    local var3 = SignalsReact.useSignalState(presetChatStore.getIsLoading)
    local var4 = SignalsReact.useSignalState(presetChatStore.getCategoryGroups)

    local var5 = SignalsReact.useSignalState(GetMessagesStore(false).getCanLocalUserChat)

    local var6 = Localization.useLocalization({ footerDescription = "Feature.Chat.PresetChat.Disclaimer" })

    local closePresetTray = React.useCallback(function()
        setIsPresetTrayOpen(presetChatStore, false)
    end, { presetChatStore })

    local onActivated = React.useCallback(function()
        closePresetTray()
        var2(PresetTrayKeyboardSelected())

        ExpChatShared.Analytics:TelemetryLogEvent(
            ExpChatShared.Analytics.ExpChatPresetActionConfig,
            {
                event_type = Constants.Analytics.EventTypes.Click,
                component = Constants.Analytics.Components.PresetKeyboardIcon
            },
            ExpChatShared.Analytics.DefaultStandardizedFields
        )
    end, { closePresetTray, var2 })

    local var9 = React.useRef(nil)

    local categoryGroupId = var4 and #var4 > 0 and var4[1].categoryGroupId or ""
    local var10, var11 = React.useState(categoryGroupId)
    local var12

    if FFlagExpChatPresetChatTabMemory then
        local var13 = SignalsReact.useSignalState(presetChatStore.getSelectedGroupIndex)
        local var14 = var4 and var4[var13]
        if var14 then
            var12 = var14.categoryGroupId
        else
            var12 = categoryGroupId
        end
    else
        var12 = var10
    end

    React.useEffect(function()
        if not FFlagExpChatPresetChatTabMemory and var12 == "" and categoryGroupId ~= "" then
            var11(categoryGroupId)
        end
    end, { categoryGroupId, var12 })

    local var13 = if FFlagExpChatPresetChatGamepadEnabled or FFlagExpChatPresetTrayDismissAnalytics then SignalsReact.useSignalState(presetChatStore.getIsTrayOpen) else nil

    React.useEffect(function()
        if FFlagExpChatPresetTrayDismissAnalytics and var13 and not var3 and var12 ~= "" then
            presetChatStore.markGroupViewed(var12)
        end
    end, {
        var13,
        var3,
        var12,
        presetChatStore
    })
    local var14 = React.useRef(nil)

    local function isValidSelection(current) -- Luacid: Inlined by compiler; 2 call sites recovered
        if current == nil then
            return false
        end
        local success, result = pcall(function()
            return current:IsDescendantOf(game) and current:FindFirstAncestorOfClass("ScreenGui") ~= nil
        end)
        return success and result
    end

    React.useEffect(function()
        if FFlagExpChatPresetChatGamepadEnabled and not var13 then
            return
        end
        local current = var9.current
        if current == nil or InputType.getInputGroup(UserInputService:GetLastInputType()) ~= InputType.InputTypeConstants.Gamepad then
            return
        end

        if var14.current == nil then
            local var15 = var14
            var15.current = if FFlagExpChatPresetChatGamepadEnabled then GuiService.SelectedCoreObject else GuiService.SelectedObject
        end

        task.defer(function()
            if not isValidSelection(current) then
                return
            end

            pcall(function()
                if FFlagExpChatPresetChatGamepadEnabled then
                    GuiService.SelectedCoreObject = current
                    return
                end
                GuiService.SelectedObject = current
            end)
        end)
    end, FFlagExpChatPresetChatGamepadEnabled and { var12, var13 } or { var12 })

    React.useEffect(function()
        local transparencyStore = GetTransparencyStore(false)
        transparencyStore.setContextMenuOpen()
        return function()
            transparencyStore.clearContextMenuOpen()
            local current = var14.current
            pcall(function()
                if isValidSelection(current) then
                    if FFlagExpChatPresetChatGamepadEnabled then
                        GuiService.SelectedCoreObject = current
                        return
                    end
                    GuiService.SelectedObject = current
                elseif FFlagExpChatPresetChatGamepadEnabled then
                    GuiService.SelectedCoreObject = nil
                else
                    GuiService.SelectedObject = nil
                end
            end)

            var14.current = nil
        end
    end, {})

    local var7 = useOnPresetActivated({ textChannel = tbl1.textChannel, closePresetTray = closePresetTray })

    local var8 = useOnEmojiActivated({
        textChannel = tbl1.textChannel,
        onSendChat = tbl1.onSendChat,
        onSendGlobalChat = tbl1.onSendGlobalChat,
        closePresetTray = closePresetTray
    })

    if var3 then
        return React.createElement(Foundation.Text, { Text = "Loading presets...", tag = "size-full text-body-medium content-muted" })
    end

    if not var4 or #var4 == 0 then
        return nil
    end

    local var17 = nil
    for _, value in var4 do
        if value.categoryGroupId == var12 then
            var17 = value
            break
        end
    end

    local fontStyle = {
        Font = Enum.Font.BuilderSansBold,
        FontSize = var1.FontSize.FontSize_300,
        LineHeight = 1.4
    }

    local tbl3 = ({})
    local bool1 = true
    local bool2 = not FFlagExpChatPresetTrayPresetOnlyDisclaimer
    if var17 then
        for layoutOrder, value2 in var17.categories do
            local tbl4 = ({})

            for value, value4 in if EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint then value2.contents else value2.messages do
                if not EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint or value4.kind == "Preset" then
                    bool2 = true
                end

                if EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint and value4.kind == "Emoji" then
                    local var18 = "Emoji_" .. value4.emoteId
                    tbl4[var18] = React.createElement(
                        PresetBorderlessGridButton,
                        {
                            unicode = value4.unicode,
                            layoutOrder = value,
                            onActivated = var8,
                            buttonRef = if bool1 then var9 else nil
                        }
                    )
                else
                    local var18 = "Msg_" .. value4.presetId
                    tbl4[var18] = React.createElement(PresetMessageButton, {
                        presetId = value4.presetId,
                        text = if EngineFeaturePresetChatUseExpressionTrayOptionsEndpoint then value4.text else value4.value,
                        layoutOrder = value,
                        onActivated = var7,
                        buttonRef = if bool1 then var9 else nil
                    })
                end

                bool1 = false
            end

            local var18 = "Category_" .. value2.categoryId
            local createElement = React.createElement
            local view = Foundation.View

            local tbl5 = {
                Header = React.createElement(Foundation.Text, {
                    LayoutOrder = 1,
                    Text = value2.name or value2.categoryId,
                    tag = "size-full-0 auto-y text-align-x-left content-default",
                    fontStyle = fontStyle
                }),
                Pills = React.createElement(Foundation.View, {
                    LayoutOrder = 2,
                    tag = "size-full-0 auto-y",
                    layout = {
                        FillDirection = Enum.FillDirection.Horizontal,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = UDim.new(0, var1.Padding.Small),
                        Wraps = true
                    }
                }, tbl4)
            }
            tbl3[var18] = createElement(view, { LayoutOrder = layoutOrder, tag = "col gap-small size-full-0 auto-y" }, tbl5)
        end

        if bool2 then
            tbl3.Footer = React.createElement(FoundationText, {
                LayoutOrder = #var17.categories + 1,
                Text = var6.footerDescription,
                TextWrapped = true,
                tag = "size-full-0 auto-y text-body-small text-align-x-left content-muted"
            })
        end
    end

    local tbl4 = {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, var1.Padding.XLarge),
            VerticalAlignment = Enum.VerticalAlignment.Bottom
        })
    }
    local bool3 = #var4 > 1
    for layoutOrder, value2 in var4 do
        local categoryGroupId2 = value2.categoryGroupId
        local bool4 = categoryGroupId2 == var12
        local textStyle = if bool4 or not bool3 then var1.Color.Content.Emphasis else var1.Color.Content.Muted
        local tbl5 = {
            AutomaticSize = Enum.AutomaticSize.X,
            Size = UDim2.new(0, 0, 0, 36),
            LayoutOrder = layoutOrder,
            Text = value2.name or categoryGroupId2,
            fontStyle = var1.Typography.LabelMedium,
            textStyle = textStyle,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center
        }
        local tbl6

        if bool4 and bool3 then
            tbl6 = { Indicator = 0 }
            local createElement = React.createElement
            local tbl7 = {
                AnchorPoint = Vector2.new(0.5, 1),
                Position = UDim2.new(0.5, 0, 1, 0),
                Size = UDim2.new(1, 0, 0, 2),
                BackgroundColor3 = var1.Color.Content.Emphasis.Color3,
                BorderSizePixel = 0
            }
            tbl6.Indicator = createElement("Frame", tbl7)
        else
            tbl6 = nil
        end

        if bool3 then
            function tbl5.onActivated()
                if FFlagExpChatPresetChatTabMemory then
                    presetChatStore.setSelectedGroupIndex(layoutOrder)
                    return
                end
                var11(categoryGroupId2)
            end
        end

        tbl4["Tab_" .. categoryGroupId2] = React.createElement(FoundationText, tbl5, tbl6)
    end

    local tbl5 = {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween
        }),
        Padding = React.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, var1.Padding.Large),
            PaddingRight = UDim.new(0, var1.Padding.Large),
            PaddingTop = UDim.new(0, var1.Padding.XSmall)
        }),
        TabsGroup = React.createElement(
            "Frame",
            {
                LayoutOrder = 1,
                AutomaticSize = Enum.AutomaticSize.XY,
                Size = UDim2.fromScale(0, 0),
                BackgroundTransparency = 1
            },
            tbl4
        ),
        KeyboardButton = 0
    }
    local element

    if var5 and tbl1.shouldShowKeyboardButton then
        element = React.createElement(Foundation.IconButton, {
            LayoutOrder = 2,
            icon = { name = "keyboard", variant = "Regular" },
            variant = Foundation.Enums.ButtonVariant.Utility,
            size = Foundation.Enums.InputSize.Small,
            isCircular = true,
            isDisabled = false,
            onActivated = onActivated
        })
    else
        element = nil
    end

    tbl5.KeyboardButton = element

    return React.createElement(
        PresetCooldownProvider,
        {},
        React.createElement("Frame", {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1
        }, {
            RootLayout = React.createElement(
                "UIListLayout",
                {
                    FillDirection = Enum.FillDirection.Vertical,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }
            ),
            TabRow = React.createElement(
                "Frame",
                {
                    LayoutOrder = 1,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Size = UDim2.fromScale(1, 0),
                    BackgroundTransparency = 1
                },
                tbl5
            ),
            TabRowBaseline = React.createElement("Frame", {
                LayoutOrder = 2,
                Size = UDim2.new(1, 0, 0, 1),
                BackgroundColor3 = var1.Color.Stroke.Default.Color3,
                BackgroundTransparency = var1.Color.Stroke.Default.Transparency,
                BorderSizePixel = 0
            }),
            Scroll = React.createElement(Foundation.ScrollView, {
                LayoutOrder = 3,
                tag = "grow size-full-0",
                scroll = {
                    scrollBarVisibility = Foundation.Enums.ScrollBarVisibility.Always,
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    CanvasSize = UDim2.new(0, 0, 0, 0)
                }
            }, {
                Categories = React.createElement(Foundation.View, {
                    tag = "size-full-0 auto-y",
                    layout = {
                        FillDirection = Enum.FillDirection.Vertical,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = UDim.new(0, var1.Padding.Large)
                    },
                    padding = {
                        top = UDim.new(0, var1.Padding.Large),
                        bottom = UDim.new(0, var1.Padding.Large),
                        left = UDim.new(0, var1.Padding.Large),
                        right = UDim.new(0, var1.Padding.Large)
                    }
                }, tbl3)
            })
        })
    )
end)
