-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)
local ReactIs = require(FoundationParent.ReactIs)

local _Types = require(Foundation.Components.Types)

local Flags = require(Foundation.Utility.Flags)
local getTestIdTag = require(Foundation.Utility.getTestIdTag)
local indexBindable = require(Foundation.Utility.indexBindable)
local withCommonProps = require(Foundation.Utility.withCommonProps)

local FoundationGuiObjectInputSinkProperty = Flags.FoundationGuiObjectInputSinkProperty and pcall(game.GetEngineFeature, game, "GuiObjectInputSink")

local function withGuiObjectProps(arg1, arg2)
    if type(arg2) == "table" then
        arg2.AutoLocalize = arg1.AutoLocalize
        arg2.AutomaticSize = arg1.AutomaticSize
        arg2.BackgroundColor3 = if arg1.backgroundStyle then indexBindable(arg1.backgroundStyle, "Color3") else nil

        arg2.BackgroundTransparency = if arg1.backgroundStyle then indexBindable(arg1.backgroundStyle, "Transparency") else nil

        arg2.BorderSizePixel = arg1.BorderSizePixel
        arg2.BorderColor3 = arg1.BorderColor3
        arg2.BorderMode = arg1.BorderMode
        arg2.ClipsDescendants = arg1.ClipsDescendants
        if FoundationGuiObjectInputSinkProperty then
            arg2.InputSink = arg1.InputSink
        end
        arg2.Rotation = arg1.Rotation
        arg2.SizeConstraint = arg1.SizeConstraint

        if arg1.selection then
            arg2.Selectable = arg1.selection.Selectable
            arg2.SelectionImageObject = arg1.selection.SelectionImageObject
            arg2.SelectionOrder = arg1.selection.SelectionOrder
            arg2.NextSelectionDown = arg1.selection.NextSelectionDown
            arg2.NextSelectionLeft = arg1.selection.NextSelectionLeft
            arg2.NextSelectionRight = arg1.selection.NextSelectionRight
            arg2.NextSelectionUp = arg1.selection.NextSelectionUp
        end

        if arg1.selectionGroup ~= nil then
            if type(arg1.selectionGroup) == "boolean" or ReactIs.isBinding(arg1.selectionGroup) then
                arg2.SelectionGroup = arg1.selectionGroup
            else
                local selectionGroup = arg1.selectionGroup
                arg2.SelectionGroup = true
                arg2.SelectionBehaviorUp = selectionGroup.SelectionBehaviorUp
                arg2.SelectionBehaviorDown = selectionGroup.SelectionBehaviorDown
                arg2.SelectionBehaviorLeft = selectionGroup.SelectionBehaviorLeft
                arg2.SelectionBehaviorRight = selectionGroup.SelectionBehaviorRight
            end
        end

        arg2.Size = arg1.Size
    end
    local var1 = withCommonProps(arg1, arg2)

    var1[React.Change.AbsoluteSize] = arg1.onAbsoluteSizeChanged
    var1.onAbsoluteSizeChanged = nil
    var1[React.Change.AbsolutePosition] = arg1.onAbsolutePositionChanged
    var1.onAbsolutePositionChanged = nil

    local testIdTag = getTestIdTag(var1.testId)

    if var1[React.Tag] and testIdTag then
        local tag = React.Tag
        var1[tag] ..= " " .. testIdTag
    else
        var1[React.Tag] = var1[React.Tag] or testIdTag
    end
    var1.testId = nil

    return var1
end

return withGuiObjectProps
