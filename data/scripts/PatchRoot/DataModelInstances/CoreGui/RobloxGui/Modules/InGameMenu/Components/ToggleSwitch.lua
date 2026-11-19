-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local UIBlox = InGameMenuDependencies.UIBlox
local Otter = InGameMenuDependencies.Otter
local t = InGameMenuDependencies.t

local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle
local Foundation = require(CorePackages.Packages.Foundation)
local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation
local var1 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.UNSTABLE.withCursorMigration else UIBlox.App.SelectionImage.withSelectionCursorProvider
local var2 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.Enums.CursorType else UIBlox.App.SelectionImage.CursorKind
local scriptParentParent = script.Parent.Parent

local divideTransparency = require(scriptParentParent.Utility.divideTransparency)

local AssetImage = require(script.Parent.AssetImage)

local uDim2 = UDim2.new(0, -3, 0.5, 0)
local uDim2_2 = UDim2.new(1, -39, 0.5, 0)
local tbl1 = { frequency = 4 }

local var3 = Roact.PureComponent:extend("ToggleSwitch")
var3.validateProps = t.strictInterface({
    checked = t.boolean,
    onToggled = t.callback,
    disabled = t.optional(t.boolean),
    buttonRef = t.optional(t.union(t.callback, t.table)),
    AnchorPoint = t.optional(t.Vector2),
    LayoutOrder = t.optional(t.integer),
    Position = t.optional(t.UDim2),
    NextSelectionUp = t.optional(t.union(t.Instance, t.table)),
    onSelectionLost = t.optional(t.callback),
    onSelectionGained = t.optional(t.callback)
})

function var3.init(arg1)
    local num1 = if arg1.props.checked then 1 else 0
    local progress, setProgress = Roact.createBinding(num1)
    arg1.progress = progress
    arg1.setProgress = setProgress

    arg1.fillTransparency = arg1.progress:map(function(arg2)
        return divideTransparency(1 - arg2, if arg1.props.disabled then 4 else 1)
    end)

    arg1.knobPosition = arg1.progress:map(function(arg2)
        return uDim2:lerp(uDim2_2, arg2)
    end)

    arg1.motor = Otter.createSingleMotor(num1)
    arg1.motor:onStep(arg1.setProgress)
end

function var3.renderWithSelectionCursor(arg1, arg2)
    return withFoundationOrUIBloxStyle(function(arg3)
        return {
            Theme = {
                SecondaryDefault = {
                    Color = arg3.Color.Extended.White.White_70.Color3,
                    Transparency = arg3.Color.Extended.White.White_70.Transparency
                },
                Success = {
                    Color = arg3.Color.System.Success.Color3,
                    Transparency = arg3.Color.System.Success.Transparency
                }
            }
        }
    end, function(arg3)
        return Roact.createElement(AssetImage.Button, {
            Size = UDim2.new(0, 60, 0, 36),
            BackgroundTransparency = 1,
            Position = arg1.props.Position,
            LayoutOrder = arg1.props.LayoutOrder,
            imageKey = "ToggleOutline",
            AnchorPoint = arg1.props.AnchorPoint,
            ImageColor3 = arg3.Theme.SecondaryDefault.Color,
            ImageTransparency = divideTransparency(arg3.Theme.SecondaryDefault.Transparency, if arg1.props.disabled then 4 else 1),
            NextSelectionUp = arg1.props.NextSelectionUp,
            [Roact.Event.Activated] = arg1.props.onToggled,
            [Roact.Ref] = arg1.props.buttonRef,
            [Roact.Event.SelectionLost] = arg1.props.onSelectionLost,
            [Roact.Event.SelectionGained] = arg1.props.onSelectionGained,
            SelectionImageObject = arg2(var2.Toggle)
        }, {
            Fill = Roact.createElement(AssetImage.Label, {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                imageKey = "ToggleFill",
                ImageColor3 = arg3.Theme.Success.Color,
                ImageTransparency = arg1.fillTransparency
            }),
            Knob = Roact.createElement(AssetImage.Label, {
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 42, 0, 42),
                AnchorPoint = Vector2.new(0, 0.5),
                Position = arg1.knobPosition,
                imageKey = "ToggleKnob",
                ImageTransparency = divideTransparency(0, if arg1.props.disabled then 4 else 1),
                ZIndex = 2
            })
        })
    end)
end

function var3.render(arg1)
    return var1(function(arg2)
        return arg1:renderWithSelectionCursor(arg2)
    end)
end

function var3.didUpdate(arg1)
    local num1 = if arg1.props.checked then 1 else 0
    arg1.motor:setGoal(Otter.spring(num1, tbl1))
end

function var3.willUnmount(arg1)
    arg1.motor:destroy()
end

return var3
