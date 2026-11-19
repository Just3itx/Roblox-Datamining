-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:40:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local t = InGameMenuDependencies.t
local Roact = InGameMenuDependencies.Roact
local UIBlox = InGameMenuDependencies.UIBlox
local Cryo = InGameMenuDependencies.Cryo
local Foundation = require(CorePackages.Packages.Foundation)
local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation
local var1 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.UNSTABLE.withCursorMigration else UIBlox.App.SelectionImage.withSelectionCursorProvider
local var2 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.Enums.CursorType else UIBlox.App.SelectionImage.CursorKind
local scriptParentParentParent = script.Parent.Parent.Parent

local Assets = require(scriptParentParentParent.Resources.Assets)
local GlobalConfig = require(scriptParentParentParent.GlobalConfig)

local ImageSetButton = UIBlox.Core.ImageSet.ImageSetButton

local Image = Foundation.Image
local ControlState = Foundation.Enums.ControlState

local var3 = t.strictInterface({
    AnchorPoint = t.optional(t.Vector2),
    Position = t.optional(t.UDim2),
    layoutOrder = t.optional(t.integer),
    onActivated = t.callback,
    onSelectionGained = t.optional(t.callback),
    onSelectionLost = t.optional(t.callback),
    forwardRef = t.optional(t.table)
})

local function isSelectedState(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1 == ControlState.Selected or arg1 == ControlState.SelectedPressed
end

local func1

if FFlagCoreUiMigrateUIBloxToFoundation then
    func1 = Roact.Component:extend("CloseMenuButton")

    function func1.init(arg1)
        arg1.wasSelected = false
    end

    function func1.render(arg1)
        local props = arg1.props
        return var1(function(arg2)
            if GlobalConfig.propValidation then
                assert(var3(props))
            end

            return Roact.createElement(Image, {
                AnchorPoint = props.AnchorPoint,
                Position = props.Position,
                Size = UDim2.new(0, 32, 0, 32),
                backgroundStyle = { Transparency = 1 },
                LayoutOrder = props.layoutOrder,
                Image = Assets.Images.CloseButton,
                selection = {
                    SelectionImageObject = arg2(var2.RoundedRect)
                },
                onActivated = props.onActivated,
                onStateChanged = function(arg3)
                    local wasSelected = isSelectedState(arg3)

                    if wasSelected and not arg1.wasSelected then
                        if props.onSelectionGained then
                            props.onSelectionGained()
                        end
                    elseif not wasSelected and arg1.wasSelected and props.onSelectionLost then
                        props.onSelectionLost()
                    end

                    arg1.wasSelected = wasSelected
                end,
                ref = props.forwardRef
            })
        end)
    end
else
    func1 = function(arg1)
        return var1(function(arg2)
            if GlobalConfig.propValidation then
                assert(var3(arg1))
            end

            return Roact.createElement(ImageSetButton, {
                AnchorPoint = arg1.AnchorPoint,
                BackgroundTransparency = 1,
                Image = Assets.Images.CloseButton,
                Position = arg1.Position,
                Size = UDim2.new(0, 32, 0, 32),
                LayoutOrder = arg1.layoutOrder,
                SelectionImageObject = arg2(var2.RoundedRect),
                [Roact.Event.Activated] = arg1.onActivated,
                [Roact.Event.SelectionGained] = arg1.onSelectionGained,
                [Roact.Event.SelectionLost] = arg1.onSelectionLost,
                [Roact.Ref] = arg1.forwardRef
            })
        end)
    end
end

return Roact.forwardRef(function(arg1, forwardRef)
    return Roact.createElement(func1, Cryo.Dictionary.join(arg1, { forwardRef = forwardRef }))
end)
