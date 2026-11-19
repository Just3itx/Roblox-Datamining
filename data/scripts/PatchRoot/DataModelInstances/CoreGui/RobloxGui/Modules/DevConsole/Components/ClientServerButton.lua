-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local Constants = require(script.Parent.Parent.Constants)
local FrameHeight = Constants.UtilityBarFormatting.FrameHeight
local SmallFrameHeight = Constants.UtilityBarFormatting.SmallFrameHeight
local ClientServerButtonWidth = Constants.UtilityBarFormatting.ClientServerButtonWidth
local ClientServerDropDownWidth = Constants.UtilityBarFormatting.ClientServerDropDownWidth
local UtilBar = Constants.Font.UtilBar
local UtilBar2 = Constants.DefaultFontSize.UtilBar
local ConstantsColorText = Constants.Color.Text

local FullScreenDropDownButton = require(script.Parent.FullScreenDropDownButton)
local DropDown = require(script.Parent.DropDown)

local uDim2 = UDim2.new(0, ClientServerButtonWidth, 0, FrameHeight)
local dropDownList = { "Client", "Server" }

local var1 = Roact.Component:extend("ClientServerButton")

function var1.init(arg1)
    function arg1.dropDownCallback(arg2)
        if arg2 == 1 then
            arg1.props.onClientButton()
        elseif arg2 == 2 then
            arg1.props.onServerButton()
        end
    end
end

function var1.render(arg1)
    local formFactor = arg1.props.formFactor
    local useDropDown = arg1.props.useDropDown
    local isClientView = arg1.props.isClientView
    local layoutOrder = arg1.props.layoutOrder
    local onServerButton = arg1.props.onServerButton
    local onClientButton = arg1.props.onClientButton

    local selectedBlue = Constants.Color.SelectedBlue
    local unselectedGray = Constants.Color.UnselectedGray

    if isClientView then
        unselectedGray = Constants.Color.SelectedBlue
        selectedBlue = Constants.Color.UnselectedGray
    end

    if formFactor == Constants.FormFactor.Small then
        return Roact.createElement(FullScreenDropDownButton, {
            buttonSize = UDim2.new(0, ClientServerDropDownWidth, 0, SmallFrameHeight),
            dropDownList = dropDownList,
            selectedIndex = if isClientView then 1 else 2,
            onSelection = arg1.dropDownCallback,
            layoutOrder = layoutOrder
        })
    end

    if useDropDown then
        return Roact.createElement(DropDown, {
            buttonSize = UDim2.new(0, ClientServerDropDownWidth, 0, SmallFrameHeight),
            dropDownList = dropDownList,
            selectedIndex = if isClientView then 1 else 2,
            onSelection = arg1.dropDownCallback,
            layoutOrder = layoutOrder
        })
    end
    local createElement = Roact.createElement
    local tbl2 = {
        Size = UDim2.new(0, 2 * ClientServerButtonWidth, 0, FrameHeight),
        BackgroundTransparency = 1,
        LayoutOrder = layoutOrder
    }
    local tbl3 = {
        ClientButton = Roact.createElement("TextButton", {
            Text = dropDownList[1],
            TextSize = UtilBar2,
            TextColor3 = ConstantsColorText,
            Font = UtilBar,
            Size = uDim2,
            AutoButtonColor = false,
            BackgroundColor3 = unselectedGray,
            BackgroundTransparency = 0,
            LayoutOrder = 1,
            [Roact.Event.Activated] = onClientButton
        }),
        ServerButton = Roact.createElement("TextButton", {
            Text = dropDownList[2],
            TextSize = UtilBar2,
            TextColor3 = ConstantsColorText,
            Font = UtilBar,
            Size = uDim2,
            AutoButtonColor = false,
            Position = UDim2.new(0, ClientServerButtonWidth, 0, 0),
            BackgroundColor3 = selectedBlue,
            BackgroundTransparency = 0,
            LayoutOrder = 2,
            [Roact.Event.Activated] = onServerButton
        })
    }
    return createElement("Frame", tbl2, tbl3)
end

return var1
