-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local React = require(VirtualEvents.Parent.React)
local UIBlox = require(VirtualEvents.Parent.UIBlox)
local useSelector = require(VirtualEvents.Parent.RoactUtils).Hooks.RoactRodux.useSelector
local useNavigation = require(VirtualEvents.Parent.Navigation).useNavigation
local useLocalization = require(VirtualEvents.Parent.Localization).Hooks.useLocalization

local useStyle = UIBlox.Core.Style.useStyle
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local PartialPageModal = UIBlox.App.Dialog.Modal.PartialPageModal
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel

local uDim = UDim.new(0, 24)
local uDim2 = UDim.new(0, 12)

local function selectScreenSize(arg1)
    return arg1.ScreenSize
end

local function EventNotificationsModal(tbl1)
    local var1 = useStyle()
    local var2 = useNavigation()
    local screenSize = useSelector(selectScreenSize)

    local var4 = useLocalization({
        title = "Feature.VirtualEvents.EnableNotificationsModalTitle",
        body = "Feature.VirtualEvents.EnableNotificationsModalBody",
        notNow = "Feature.VirtualEvents.NotNowButton",
        getNotified = "Feature.VirtualEvents.GetNotifiedButton"
    })

    local var5 = React.useCallback(function()
        if tbl1.onClose then
            tbl1.onClose()
        end

        var2.goBack()
    end, { tbl1.onClose, var2 })

    local onActivated = React.useCallback(function()
        if tbl1.onConfirm then
            tbl1.onConfirm()
        end

        var5()
    end, { tbl1.onConfirm, var5 })

    return React.createElement(PartialPageModal, {
        position = UDim2.fromScale(0.5, 0.5),
        anchorPoint = Vector2.new(0.5, 0.5),
        title = var4.title,
        screenSize = screenSize,
        buttonStackProps = {
            buttons = {
                {
                    buttonType = ButtonType.Secondary,
                    props = {
                        onActivated = var5,
                        text = var4.notNow
                    }
                },
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = onActivated,
                        text = var4.getNotified
                    }
                }
            }
        },
        contentPadding = uDim,
        onCloseClicked = var5
    }, {
        Wrapper = React.createElement(
            "Frame",
            {
                Size = UDim2.fromScale(1, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1
            },
            {
                Layout = React.createElement(
                    "UIListLayout",
                    {
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        HorizontalAlignment = Enum.HorizontalAlignment.Center,
                        Padding = uDim2
                    }
                ),
                Padding = React.createElement("UIPadding", { PaddingTop = uDim2 + uDim2, PaddingBottom = uDim2 }),
                Body = React.createElement(StyledTextLabel, {
                    text = var4.body,
                    textXAlignment = Enum.TextXAlignment.Center,
                    fontStyle = var1.Font.Body,
                    colorStyle = var1.Theme.TextMuted,
                    size = UDim2.fromScale(1, 0),
                    automaticSize = Enum.AutomaticSize.Y,
                    fluidSizing = false
                })
            }
        )
    })
end

return EventNotificationsModal
