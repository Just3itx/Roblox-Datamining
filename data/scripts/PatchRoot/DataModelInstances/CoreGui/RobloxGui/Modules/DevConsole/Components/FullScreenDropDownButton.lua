-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:21:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local RobloxGui = game:GetService("CoreGui").RobloxGui
local Roact = require(CorePackages.Packages.Roact)

local ExternalEventConnection = require(CorePackages.Workspace.Packages.RoactUtils).ExternalEventConnection

local Constants = require(script.Parent.Parent.Constants)
local DropDownEntryHeight = Constants.GeneralFormatting.DropDownEntryHeight
local DropDownArrowHeight = Constants.GeneralFormatting.DropDownArrowHeight
local var1 = DropDownArrowHeight / 2
local DownArrow = Constants.Image.DownArrow

local var2 = Roact.Component:extend("FullScreenDropDownButton")

function var2.init(arg1)
    function arg1.startDropDownView()
        arg1:setState({ selectionScreenExpanded = true })
    end

    function arg1.noSelection(_, arg2)
        if arg2.UserInputType == Enum.UserInputType.MouseButton1
            or arg2.UserInputType == Enum.UserInputType.Touch and arg2.UserInputState == Enum.UserInputState.End
        then
            arg1:setState({ selectionScreenExpanded = false })
        end
    end

    arg1.state = {
        selectionScreenExpanded = false,
        guiSizeY = RobloxGui.AbsoluteSize.Y
    }
end

function var2.render(arg1)
    local buttonSize = arg1.props.buttonSize
    local dropDownList = arg1.props.dropDownList
    local selectedIndex = arg1.props.selectedIndex
    local onSelection = arg1.props.onSelection
    local layoutOrder = arg1.props.layoutOrder

    local selectionScreenExpanded = arg1.state.selectionScreenExpanded
    local portalTarget = arg1.props.portalTarget

    local tbl1 = ({})
    local yOffset = 16

    if selectionScreenExpanded then
        tbl1.UIListLayout = Roact.createElement("UIListLayout", {
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            FillDirection = Enum.FillDirection.Vertical
        })

        if dropDownList then
            for i, value in ipairs(dropDownList) do
                local backgroundColor3 = i == selectedIndex and Constants.Color.SelectedGray or Constants.Color.UnselectedGray

                local createElement = Roact.createElement
                local tbl2 = {
                    Text = value,
                    Font = Constants.Font.TabBar,
                    TextSize = Constants.DefaultFontSize.DropDownTabBar,
                    TextColor3 = Constants.Color.Text,
                    AutoButtonColor = false,
                    Size = UDim2.new(1, 0, 0, DropDownEntryHeight),
                    BackgroundColor3 = backgroundColor3,
                    LayoutOrder = i,
                    BorderSizePixel = 0
                }
                tbl2[Roact.Event.Activated] = function(_)
                    arg1:setState({ selectionScreenExpanded = false })

                    onSelection(i)
                end

                tbl1[i] = createElement("TextButton", tbl2)

                yOffset += DropDownEntryHeight
            end
        end
    end

    local yOffset2 = yOffset - 16 - arg1.state.guiSizeY

    local createElement = Roact.createElement
    local str1 = "TextButton"
    local tbl2 = {
        Size = buttonSize,
        BackgroundColor3 = Constants.Color.UnselectedGray,
        Text = "",
        AutoButtonColor = false,
        LayoutOrder = layoutOrder,
        [Roact.Event.Activated] = arg1.startDropDownView
    }

    local tbl3 = {
        SizeChangeEvent = Roact.createElement(ExternalEventConnection, {
            event = RobloxGui:GetPropertyChangedSignal("AbsoluteSize"),
            callback = function()
                arg1:setState({ guiSizeY = RobloxGui.AbsoluteSize.Y })
            end
        }),
        text = Roact.createElement("TextLabel", {
            Size = UDim2.new(1, -DropDownArrowHeight - var1, 1, 0),
            Text = dropDownList[selectedIndex],
            Font = Constants.Font.TabBar,
            TextSize = Constants.DefaultFontSize.DropDownTabBar,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextColor3 = Constants.Color.Text,
            BackgroundTransparency = 1
        }),
        arrow = Roact.createElement("ImageLabel", {
            Image = DownArrow,
            BackgroundTransparency = 1,
            Size = UDim2.new(0, DropDownArrowHeight, 0, DropDownArrowHeight),
            Position = UDim2.new(1, -DropDownArrowHeight - var1, 0.5, -var1)
        }),
        selectionView = 0
    }

    if selectionScreenExpanded then
        local createElement2 = Roact.createElement
        local portal = Roact.Portal
        local tbl4 = {
            target = portalTarget ~= nil and portalTarget or game:GetService("CoreGui").DevConsoleMaster
        }
        local tbl5 = {
            GreyOutFrame = Roact.createElement("Frame", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundColor3 = Constants.Color.Black,
                BackgroundTransparency = 0.36,
                Active = true,
                [Roact.Event.InputEnded] = arg1.noSelection
            }, {
                BorderFrame = Roact.createElement("Frame", {
                    Size = UDim2.new(0, 375, 0, yOffset),
                    Position = UDim2.new(0.5, -187.5, 0, 0),
                    BackgroundColor3 = Constants.Color.UnselectedGray,
                    BorderSizePixel = 0
                }, {
                    SelectionFrame = Roact.createElement("ScrollingFrame", {
                        Size = UDim2.new(1, -30, 1, -16),
                        Position = UDim2.new(0, 15, 0, 8),
                        BackgroundTransparency = 1,
                        CanvasSize = UDim2.new(1, -30, 1, yOffset2),
                        BorderSizePixel = 0,
                        ScrollBarThickness = 0
                    }, tbl1)
                })
            })
        }
        selectionScreenExpanded = createElement2(portal, tbl4, tbl5)
    end

    tbl3.selectionView = selectionScreenExpanded
    return createElement(str1, tbl2, tbl3)
end

return var2
