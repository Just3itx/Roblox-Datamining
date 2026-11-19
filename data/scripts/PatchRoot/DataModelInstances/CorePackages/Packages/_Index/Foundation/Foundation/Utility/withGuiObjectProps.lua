-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:31:02Z
-- Luau bytecode version: 9 | Luau type version: 3
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

local var1 = Flags.FoundationGuiObjectInputSinkProperty and pcall(game.GetEngineFeature, game, "GuiObjectInputSink")

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
        if var1 then
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
    local var2 = withCommonProps(arg1, arg2)

    var2[React.Change.AbsoluteSize] = arg1.onAbsoluteSizeChanged
    var2.onAbsoluteSizeChanged = nil
    var2[React.Change.AbsolutePosition] = arg1.onAbsolutePositionChanged
    var2.onAbsolutePositionChanged = nil

    local testIdTag = getTestIdTag(var2.testId)

    if var2[React.Tag] and testIdTag then
        local tag = React.Tag
        var2[tag] ..= " " .. testIdTag
    else
        var2[React.Tag] = var2[React.Tag] or testIdTag
    end
    var2.testId = nil

    return var2
end

return withGuiObjectProps
