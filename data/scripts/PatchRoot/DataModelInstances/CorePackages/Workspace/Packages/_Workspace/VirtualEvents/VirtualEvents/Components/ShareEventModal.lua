-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local React = require(VirtualEvents.Parent.React)
local UIBlox = require(VirtualEvents.Parent.UIBlox)
local useNavigation = require(VirtualEvents.Parent.Navigation).useNavigation
local useSelector = require(VirtualEvents.Parent.RoactUtils).Hooks.RoactRodux.useSelector
local useLocalization = require(VirtualEvents.Parent.Localization).Hooks.useLocalization
local UrlBuilder = require(VirtualEvents.Parent.UrlBuilder).UrlBuilder
local SelectableTextLabel = require(script.Parent.SelectableTextLabel)

local uDim = UDim.new(0, 24)
local uDim2 = UDim.new(0, 8)
local uDim3 = UDim.new(0, 2)

local PartialPageModal = UIBlox.App.Dialog.Modal.PartialPageModal
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local useStyle = UIBlox.Core.Style.useStyle

local function selectScreenSize(arg1)
    return arg1.ScreenSize
end

local function ShareEventModal(tbl1)
    local var1 = useStyle()
    local screenSize = useSelector(selectScreenSize)
    local var3 = useNavigation()

    local var4 = React.useMemo(function()
        return UrlBuilder.virtualevents.appsflyer({ eventId = tbl1.virtualEventId })
    end, { tbl1.virtualEventId })

    local var5 = useLocalization({
        title = "Feature.VirtualEvents.ShareModalTitle",
        body = "Feature.VirtualEvents.ShareModalBody",
        copyLink = "Feature.VirtualEvents.ShareModalLinkCopy",
        callToAction = "Feature.VirtualEvents.ShareModalCallToAction"
    })

    local onCloseClicked = React.useCallback(function()
        var3.goBack()

        if tbl1.onClose then
            tbl1.onClose()
        end
    end, { tbl1, var3 })

    local onActivated = React.useCallback(function()
        if tbl1.onCopy then
            tbl1.onCopy(var4)
        end
    end, { var4, tbl1.onCopy })

    return React.createElement(
        PartialPageModal,
        {
            title = var5.title,
            screenSize = screenSize,
            contentPadding = uDim,
            onCloseClicked = onCloseClicked
        },
        {
            Wrapper = React.createElement(
                "Frame",
                {
                    Size = UDim2.fromScale(1, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1
                },
                {
                    Layout = React.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = uDim }),
                    Padding = React.createElement("UIPadding", { PaddingTop = uDim }),
                    Body = React.createElement(StyledTextLabel, {
                        layoutOrder = 1,
                        text = var5.body,
                        fontStyle = var1.Font.Body,
                        colorStyle = var1.Theme.TextMuted,
                        size = UDim2.new(1, 0, 0, 40),
                        fluidSizing = false
                    }),
                    Deeplink = React.createElement(
                        "Frame",
                        {
                            LayoutOrder = 2,
                            AutomaticSize = Enum.AutomaticSize.XY,
                            BackgroundTransparency = 1
                        },
                        {
                            Layout = React.createElement("UIListLayout", {
                                SortOrder = Enum.SortOrder.LayoutOrder,
                                FillDirection = Enum.FillDirection.Horizontal,
                                VerticalAlignment = Enum.VerticalAlignment.Center,
                                Padding = uDim
                            }),
                            Field = React.createElement("Frame", {
                                LayoutOrder = 1,
                                Size = UDim2.fromScale(0.8, 0) - UDim2.fromOffset(uDim.Offset, 0),
                                AutomaticSize = Enum.AutomaticSize.Y,
                                BackgroundColor3 = var1.Theme.UIMuted.Color,
                                BackgroundTransparency = 1
                            }, {
                                Corner = React.createElement("UICorner", { CornerRadius = uDim3 }),
                                Border = React.createElement("UIStroke", { Color = var1.Theme.UIDefault.Color }),
                                Padding = React.createElement(
                                    "UIPadding",
                                    {
                                        PaddingTop = uDim2,
                                        PaddingRight = uDim2,
                                        PaddingBottom = uDim2,
                                        PaddingLeft = uDim2
                                    }
                                ),
                                Label = React.createElement(SelectableTextLabel, {
                                    fontStyle = var1.Font.Body,
                                    colorStyle = var1.Theme.TextMuted,
                                    Size = UDim2.fromScale(1, 0),
                                    AutomaticSize = Enum.AutomaticSize.Y,
                                    Text = var4
                                })
                            }),
                            Action = React.createElement(Button, {
                                buttonType = ButtonType.PrimarySystem,
                                layoutOrder = 2,
                                text = var5.copyLink,
                                size = UDim2.new(0.2, 0, 0, 32),
                                onActivated = onActivated
                            })
                        }
                    )
                }
            )
        }
    )
end

return ShareEventModal
