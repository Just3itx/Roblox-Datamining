-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local _RobloxGui = game:GetService("CoreGui").RobloxGui
local Roact = require(CorePackages.Packages.Roact)

local Constants = require(script.Parent.Parent.Constants)

local var1 = Roact.Component:extend("CheckboxDropdown")

function var1.render(arg1)
    local prop = arg1.props[Roact.Children] or {}
    local absolutePosition = arg1.props.absolutePosition
    local frameWidth = arg1.props.frameWidth
    local elementHeight = arg1.props.elementHeight
    local numElements = arg1.props.numElements
    local dropdownTargetGui = arg1.props.dropdownTargetGui

    local onCloseCheckbox = arg1.props.onCloseCheckbox

    local yOffset = elementHeight * numElements
    local uDim2 = UDim2.new(0, frameWidth, 0, 24 + yOffset)

    local createElement = Roact.createElement
    local portal = Roact.Portal
    local tbl1 = {
        target = dropdownTargetGui ~= nil and dropdownTargetGui or game:GetService("CoreGui").DevConsoleMaster
    }
    local tbl2 = {
        InputCatcher = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            [Roact.Event.InputEnded] = onCloseCheckbox
        }, {
            OuterFrame = Roact.createElement("ImageButton", {
                Size = uDim2,
                AutoButtonColor = false,
                Position = absolutePosition,
                BackgroundColor3 = Constants.Color.TextBoxGray,
                BackgroundTransparency = 0
            }, {
                innerFrame = Roact.createElement(
                    "Frame",
                    {
                        Position = UDim2.new(0, 12, 0, 12),
                        Size = UDim2.new(0, frameWidth, 0, yOffset),
                        BackgroundTransparency = 1
                    },
                    prop
                )
            })
        })
    }
    return createElement(portal, tbl1, tbl2)
end

return var1
