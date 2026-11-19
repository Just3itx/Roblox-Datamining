-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:21:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local _RobloxGui = game:GetService("CoreGui").RobloxGui
local Roact = require(CorePackages.Packages.Roact)

local bool1 = game:DefineFastFlag("DevConsoleDropdownFlipFix", false)
local bool2 = game:DefineFastFlag("DevConsoleDropdownMultiSelect", false)

local Constants = require(script.Parent.Parent.Constants)
local UtilBar = Constants.Font.UtilBar
local UtilBar2 = Constants.DefaultFontSize.UtilBar
local DropDownArrowHeight = Constants.GeneralFormatting.DropDownArrowHeight
local var1 = DropDownArrowHeight / 2
local DownArrow = Constants.Image.DownArrow

local var2 = Roact.Component:extend("DropDown")

function var2.init(arg1)
    if bool1 then
        arg1.guiInset = game:GetService("GuiService"):GetGuiInset()
    end

    function arg1.onMainButtonPressed(_, _)
        arg1:setState({ showDropDown = true })
    end

    function arg1.nonDropDownSelection(_, arg2)
        if arg2.UserInputType == Enum.UserInputType.MouseButton1
            or arg2.UserInputType == Enum.UserInputType.Touch and arg2.UserInputState == Enum.UserInputState.End
        then
            arg1:setState({ showDropDown = false })
        end
    end

    arg1.state = { showDropDown = false }

    arg1.ref = Roact.createRef()
end

function var2.render(arg1)
    local buttonSize = arg1.props.buttonSize
    local dropDownList = arg1.props.dropDownList
    local selectedIndex = arg1.props.selectedIndex

    local onSelection = arg1.props.onSelection
    local layoutOrder = arg1.props.layoutOrder

    local selectedSet = arg1.props.selectedSet
    local onToggle = arg1.props.onToggle
    local bool3 = bool2 and onToggle ~= nil

    local dropDownTargetParent = arg1.props.dropDownTargetParent

    local showDropDown = arg1.ref.current and arg1.state.showDropDown

    local tbl1 = ({})

    local yOffset = 0
    local x, var3, var4

    if arg1.ref.current and showDropDown then
        local absolutePosition = arg1.ref.current.AbsolutePosition
        local absoluteSize = arg1.ref.current.AbsoluteSize

        x = absoluteSize.X

        tbl1.UIListLayout = Roact.createElement("UIListLayout", {
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Top
        })

        for k, value in pairs(dropDownList) do
            local backgroundColor3 = (if bool3 then not (selectedSet == nil) and selectedSet[k] == true else k == selectedIndex)
                and Constants.Color.SelectedGray
                or Constants.Color.UnselectedGray

            local createElement = Roact.createElement
            local tbl2 = {
                Size = buttonSize,
                Text = value,
                TextColor3 = Constants.Color.Text,
                TextSize = UtilBar2,
                Font = UtilBar,
                AutoButtonColor = false,
                BackgroundColor3 = backgroundColor3,
                BackgroundTransparency = 0,
                BorderSizePixel = 0,
                LayoutOrder = k
            }
            tbl2[Roact.Event.Activated] = function()
                if bool3 then
                    onToggle(k)
                    return
                end
                onSelection(k)
                arg1:setState({ showDropDown = false })
            end

            tbl1[value] = createElement("TextButton", tbl2)

            yOffset += absoluteSize.Y
        end

        local yOffset2 = yOffset + 24
        if bool1 then
            local currentCamera = workspace.CurrentCamera
            local var5 = (currentCamera and currentCamera.ViewportSize.Y or math.huge) - arg1.guiInset.Y - (absolutePosition.Y + absoluteSize.Y)
            local absolutePositionY = absolutePosition.Y
            local bool4 = var5 < yOffset2 and var5 < absolutePositionY
            var3 = UDim2.new(0, x + 24, 0, yOffset2)
            if bool4 then
                var4 = UDim2.new(0, absolutePosition.X, 0, absolutePosition.Y - yOffset2)
            else
                var4 = UDim2.new(0, absolutePosition.X, 0, absolutePosition.Y + absoluteSize.Y)
            end
        else
            var3 = UDim2.new(0, x + 24, 0, yOffset + 24)
            var4 = UDim2.new(0, absolutePosition.X, 0, absolutePosition.Y + absoluteSize.Y)
        end
    else
        var3 = nil
        var4 = nil
        x = 0
    end

    local createElement = Roact.createElement
    local str1 = "TextButton"
    local tbl2 = {
        Size = buttonSize,
        Position = if bool1 then arg1.props.position or UDim2.new() or nil else nil,
        Text = if bool3 then arg1.props.summaryText or "" else dropDownList[selectedIndex],
        TextColor3 = Constants.Color.Text,
        TextSize = UtilBar2,
        Font = UtilBar,
        AutoButtonColor = false,
        BackgroundColor3 = Constants.Color.UnselectedGray,
        BackgroundTransparency = 0,
        LayoutOrder = layoutOrder,
        [Roact.Event.Activated] = arg1.onMainButtonPressed,
        [Roact.Ref] = arg1.ref
    }
    local tbl3 = {
        arrow = Roact.createElement("ImageLabel", {
            Image = DownArrow,
            BackgroundTransparency = 1,
            Size = UDim2.new(0, DropDownArrowHeight, 0, DropDownArrowHeight),
            Position = UDim2.new(1, -DropDownArrowHeight - var1, 0.5, -var1)
        }),
        DropDown = 0
    }

    if showDropDown then
        local createElement2 = Roact.createElement
        local portal = Roact.Portal
        local tbl4 = {
            target = dropDownTargetParent ~= nil and dropDownTargetParent or game:GetService("CoreGui").DevConsoleMaster
        }
        local tbl5 = {
            InputCatcher = Roact.createElement("Frame", {
                Size = UDim2.new(1, 0, 1, 0),
                Position = UDim2.new(0, 0, 0, 0),
                BackgroundTransparency = 1,
                [Roact.Event.InputEnded] = arg1.nonDropDownSelection
            }, {
                OuterFrame = Roact.createElement("ImageButton", {
                    Size = var3,
                    AutoButtonColor = false,
                    Position = var4,
                    BackgroundColor3 = Constants.Color.TextBoxGray,
                    BackgroundTransparency = 0
                }, {
                    innerFrame = Roact.createElement(
                        "Frame",
                        {
                            Position = UDim2.new(0, 12, 0, 12),
                            Size = UDim2.new(0, x, 0, yOffset),
                            BackgroundTransparency = 1
                        },
                        tbl1
                    )
                })
            })
        }
        showDropDown = createElement2(portal, tbl4, tbl5)
    end

    tbl3.DropDown = showDropDown
    return createElement(str1, tbl2, tbl3)
end

return var2
