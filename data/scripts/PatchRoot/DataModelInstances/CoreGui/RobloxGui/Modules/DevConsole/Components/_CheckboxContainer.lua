-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local TextService = game:GetService("TextService")
local Roact = require(CorePackages.Packages.Roact)

local Components = script.Parent.Parent.Components
local _Checkbox = require(Components._Checkbox)
local _CheckboxDropdown = require(Components._CheckboxDropdown)

local Constants = require(script.Parent.Parent.Constants)
local CheckboxHeight = Constants.UtilityBarFormatting.CheckboxHeight
local var1 = Constants.UtilityBarFormatting.CheckboxInnerPadding * 2
local FilterUnfilled = Constants.Image.FilterUnfilled
local FilterFilled = Constants.Image.FilterFilled

local var2 = Roact.PureComponent:extend("CheckboxContainer")

function var2.init(arg1)
    function arg1.onCheckboxClicked(arg2, arg3)
        arg1.props.onCheckboxChanged(arg2, arg3)
    end

    function arg1.onCheckboxExpanded(_, arg2)
        if arg2.UserInputType == Enum.UserInputType.MouseButton1
            or arg2.UserInputType == Enum.UserInputType.Touch and arg2.UserInputState == Enum.UserInputState.End
        then
            arg1:setState({ expanded = true })
        end
    end

    function arg1.onCloseCheckbox(_, arg2)
        if arg2.UserInputType == Enum.UserInputType.MouseButton1
            or arg2.UserInputType == Enum.UserInputType.Touch and arg2.UserInputState == Enum.UserInputState.End
        then
            arg1:setState({ expanded = false })
        end
    end

    if not arg1.props.orderedCheckboxState then
        warn("CheckboxContainer must be passed a list of Box Names or else it only creates an empty frame")
    end

    local textWidths = ({})
    local num1 = 0
    local num2 = 0
    for i, value in ipairs(arg1.props.orderedCheckboxState) do
        local vector2 = TextService:GetTextSize(value.name, Constants.DefaultFontSize.UtilBar, Constants.Font.UtilBar, Vector2.new(0, 0))

        textWidths[i] = vector2.X
        num1 = num1 + vector2.X + CheckboxHeight + var1
        num2 += 1
    end

    arg1.ref = Roact.createRef()

    arg1.state = {
        expanded = false,
        textWidths = textWidths,
        numCheckboxes = num2,
        minFullLength = num1
    }
end

function var2.render(arg1)
    local tbl1 = ({})
    local frameWidth = arg1.props.frameWidth
    local frameHeight = arg1.props.frameHeight
    local pos = arg1.props.pos

    local layoutOrder = arg1.props.layoutOrder
    local orderedCheckboxState = arg1.props.orderedCheckboxState

    local minFullLength = arg1.state.minFullLength
    local expanded = arg1.state.expanded
    local numCheckboxes = arg1.state.numCheckboxes

    local bool1 = false
    for i, value in ipairs(orderedCheckboxState) do
        local name = value.name
        tbl1[name] = Roact.createElement(_Checkbox, {
            name = value.name,
            font = Constants.Font.UtilBar,
            fontSize = Constants.DefaultFontSize.UtilBar,
            checkboxHeight = CheckboxHeight,
            frameHeight = frameHeight,
            layoutOrder = i,
            isSelected = value.state,
            selectedColor = Constants.Color.SelectedBlue,
            unselectedColor = Constants.Color.UnselectedGray,
            onCheckboxClicked = arg1.onCheckboxClicked
        })
        bool1 = bool1 or value.state
    end

    if not (frameWidth < minFullLength) then
        tbl1.CheckboxLayout = Roact.createElement("UIListLayout", {
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            FillDirection = Enum.FillDirection.Horizontal
        })

        return Roact.createElement("Frame", {
            Size = UDim2.new(0, frameWidth, 0, frameHeight),
            Position = pos,
            BackgroundTransparency = 1,
            LayoutOrder = layoutOrder
        }, tbl1)
    end

    tbl1.CheckboxLayout = Roact.createElement("UIListLayout", {
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        FillDirection = Enum.FillDirection.Vertical
    })

    local var3 = arg1.ref.current and expanded
    local var4

    if var3 then
        local absolutePosition = arg1.ref.current.AbsolutePosition

        var4 = UDim2.new(0, absolutePosition.X, 0, absolutePosition.Y + frameHeight + 3)
    else
        var4 = nil
    end

    return Roact.createElement("ImageButton", {
        Size = UDim2.new(0, frameHeight, 0, frameHeight),
        LayoutOrder = layoutOrder,
        Image = var3 and FilterFilled or FilterUnfilled,
        BackgroundTransparency = 1,
        BorderColor3 = Constants.Color.Text,
        [Roact.Event.InputEnded] = arg1.onCheckboxExpanded,
        [Roact.Ref] = arg1.ref
    }, {
        DropDown = var3
            and Roact.createElement(_CheckboxDropdown, {
                absolutePosition = var4,
                frameWidth = frameWidth,
                elementHeight = frameHeight,
                numElements = numCheckboxes,
                onCloseCheckbox = arg1.onCloseCheckbox
            }, tbl1)
    })
end

return var2
