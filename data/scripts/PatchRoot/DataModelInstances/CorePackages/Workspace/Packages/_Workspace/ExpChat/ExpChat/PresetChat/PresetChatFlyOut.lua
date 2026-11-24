-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Foundation = require(ExpChatParent.Foundation)
local React = require(ExpChatParent.React)
local SignalsReact = require(ExpChatParent.SignalsReact)

local FFlagExpChatPresetTrayDismissAnalytics = require(ExpChat.Flags.FFlagExpChatPresetTrayDismissAnalytics)
local Config = require(ExpChat.Config)
local GetPresetChatStore = require(ExpChat.Stores.GetPresetChatStore)
local PresetChatButton = require(script.Parent.PresetChatButton)
local PresetChatContainer = require(script.Parent.PresetChatContainer)
local setIsPresetTrayOpen = require(script.Parent.Thunks.setIsPresetTrayOpen)
local FFlagExpChatPresetChatGamepadEnabled = require(ExpChat.Flags.FFlagExpChatPresetChatGamepadEnabled)
local FFlagExpChatPresetFullWidthButtonFixes = require(ExpChat.Flags.FFlagExpChatPresetFullWidthButtonFixes)
local FlyOutWidth = Config.PresetTray.FlyOutWidth
local FlyOutHeight = Config.PresetTray.FlyOutHeight

return React.memo(function(tbl1) -- name: PresetChatFlyOut
    local presetChatStore = GetPresetChatStore(false)
    local isOpen = SignalsReact.useSignalState(presetChatStore.getIsTrayOpen)

    local onPressedOutside = React.useCallback(function()
        setIsPresetTrayOpen(presetChatStore, false)
    end, { presetChatStore })

    React.useEffect(function()
        if not isOpen then
            return
        end

        local connection = if FFlagExpChatPresetChatGamepadEnabled then UserInputService.InputBegan:Connect(function(input: InputObject, _: boolean)
            if input.KeyCode == Enum.KeyCode.Escape or input.KeyCode == Enum.KeyCode.ButtonB then
                setIsPresetTrayOpen(presetChatStore, false)
            end
        end) else nil

        local connection2 = GuiService.MenuOpened:Connect(function()
            if FFlagExpChatPresetTrayDismissAnalytics then
                setIsPresetTrayOpen(presetChatStore, false)
                return
            end
            presetChatStore.setIsTrayOpen(false)
        end)

        return function()
            if connection then
                connection:Disconnect()
            end
            connection2:Disconnect()
        end
    end, { isOpen, presetChatStore })

    local createElement = React.createElement
    local root = Foundation.Popover.Root
    local tbl2 = { isOpen = isOpen }
    local tbl3 = {
        Anchor = React.createElement(Foundation.Popover.Anchor, nil, {
            AnchorWrapper = React.createElement(Foundation.View, {
                tag = "size-0-full auto-x",
                padding = tbl1.addTopPadding and {
                    top = UDim.new(0, 6)
                } or nil,
                layout = {
                    FillDirection = Enum.FillDirection.Vertical,
                    VerticalAlignment = Enum.VerticalAlignment.Bottom,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }
            }, {
                Button = React.createElement(PresetChatButton, {
                    fullWidth = tbl1.fullWidthButton,
                    size = tbl1.buttonSize,
                    isCircular = tbl1.buttonIsCircular,
                    targetTextChannel = tbl1.textChannel
                })
            })
        }),
        Content = React.createElement(Foundation.Popover.Content, {
            side = {
                position = if FFlagExpChatPresetFullWidthButtonFixes and tbl1.fullWidthButton then Foundation.Enums.PopoverSide.Bottom else Foundation.Enums.PopoverSide.Right,
                offset = 7
            },
            align = {
                position = Foundation.Enums.PopoverAlign.Start,
                offset = FFlagExpChatPresetFullWidthButtonFixes and tbl1.fullWidthButton and 0 or 3
            },
            hasArrow = false,
            radius = Foundation.Enums.Radius.Medium,
            onPressedOutside = onPressedOutside
        }, {
            ContentWrapper = React.createElement(Foundation.View, {
                Size = UDim2.fromOffset(FlyOutWidth, FlyOutHeight)
            }, {
                Container = React.createElement(PresetChatContainer, {
                    textChannel = tbl1.textChannel,
                    compact = true,
                    onSendChat = tbl1.onSendChat,
                    onSendGlobalChat = tbl1.onSendGlobalChat
                })
            })
        })
    }
    return createElement(root, tbl2, tbl3)
end)
