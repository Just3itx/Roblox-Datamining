-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:20:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.InGameMenuDependencies).Roact

local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local Controls = require(scriptParentParentParentParent.Resources.Controls)

local ControlLayoutContainer = require(script.Parent.Parent.ControlLayoutContainer)
local PaddedScrollFrame = require(scriptParentParentParentParent.Components.PaddedScrollFrame)
local ControlEntry = require(script.Parent.Parent.ControlEntry)
local ControlEntryHeader = require(script.Parent.Parent.ControlEntryHeader)

local function KeyboardControls(_)
    local tbl1 = {
        ListLayout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }),
        Padding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, 95), PaddingRight = UDim.new(0, 95) }),
        SizeConstraint = Roact.createElement("UISizeConstraint", { MaxSize = Vector2.new(1090, math.huge), MinSize = Vector2.new(150, 0) })
    }

    local num1 = 0
    local num2 = 0

    local num3 = 1

    for _, keybind in ipairs(Controls.keybinds) do
        local title = keybind.title
        num1 += 1

        tbl1[title .. "_header"] = Roact.createElement(ControlEntryHeader, { title = title, LayoutOrder = num3 })

        num3 += 1

        for i, control in ipairs(keybind.controls) do
            num2 += 1
            local var1 = title .. "_" .. i
            tbl1[var1] = Roact.createElement(ControlEntry, {
                LayoutOrder = num3,
                actionDescription = control.desc,
                inputs = control.inputs,
                isList = control.list,
                hasDivider = i ~= #keybind.controls
            })

            num3 += 1
        end
    end

    local yOffset = num1 * 45 + num2 * 50

    return Roact.createElement(
        ControlLayoutContainer,
        { titleText = "CoreScripts.InGameMenu.Controls.KeyboardAndMouseTitle" },
        {
            ScrollContent = Roact.createElement(PaddedScrollFrame, {
                CanvasSize = UDim2.new(0, 0, 0, yOffset),
                ScrollingDirection = Enum.ScrollingDirection.Y,
                Size = UDim2.new(1, 0, 1, -130)
            }, {
                ListContainer = Roact.createElement("Frame", {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(0.5, 0),
                    Position = UDim2.new(0.5, 0, 0, 0)
                }, tbl1)
            })
        }
    )
end

return KeyboardControls
