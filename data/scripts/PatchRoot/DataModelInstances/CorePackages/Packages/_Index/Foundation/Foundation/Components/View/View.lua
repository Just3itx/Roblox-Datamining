-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:10:44Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Logger = require(Foundation.Utility.Logger)

local Interactable = require(Foundation.Components.Interactable)

local Flags = require(Foundation.Utility.Flags)
local GuiObjectChildren = require(Foundation.Utility.GuiObjectChildren)
local _Types = require(Foundation.Components.Types)
local useDefaultTags = require(Foundation.Utility.useDefaultTags)
local withDefaults = require(Foundation.Utility.withDefaults)
local withGuiObjectProps = require(Foundation.Utility.withGuiObjectProps)

local useStyleTags = require(Foundation.Providers.Style.useStyleTags)

local _ControlState = require(Foundation.Enums.ControlState)

local tbl1 = {
    layout = {
        SortOrder = Enum.SortOrder.LayoutOrder
    },
    AutoLocalize = false,
    BorderSizePixel = 0,
    isDisabled = false
}

local bool1 = false

return React.memo(React.forwardRef(function(arg1, ref) -- name: View
    local var1 = withDefaults(arg1, tbl1)

    local str1 = if var1.backgroundStyle == nil then "gui-object-defaults" else "gui-object-defaults x-default-transparency"

    local var2 = useDefaultTags(var1.tag, str1)
    local var3 = useStyleTags(var2)

    local bool2 = var1.onStateChanged ~= nil or var1.onActivated ~= nil or var1.onSecondaryActivated ~= nil
    local bool3

    if Flags.FoundationViewMemoizationChanges then
        local bool4 = not (var1.GroupTransparency == nil) and (type(var1.GroupTransparency) == "table" or var1.GroupTransparency > 0)
        bool3 = bool4
    else
        bool3 = React.useMemo(function(): boolean
            if var1.GroupTransparency == nil then
                return false
            end

            return type(var1.GroupTransparency) == "table" or var1.GroupTransparency > 0
        end, { var1.GroupTransparency })
    end

    local var4

    if Flags.FoundationViewMemoizationChanges then
        var4 = if bool3 then "CanvasGroup" elseif bool2 then "ImageButton" else "Frame"

        if bool3 and bool2 and not (var1.isDisabled or bool1) then
            bool1 = true
            Logger:warning("Some state changes are not supported with GroupTransparency")
        end
    else
        var4 = React.useMemo(function(): string
            if not bool3 then
                return if bool2 then "ImageButton" else "Frame"
            end

            if bool2 and not var1.isDisabled then
                Logger:warning("Some state changes are not supported with GroupTransparency")
            end
            return "CanvasGroup"
        end, { bool3, bool2 })
    end

    local var5 = withGuiObjectProps
    local tbl2 = {
        AutoButtonColor = not (var4 == "ImageButton") and nil,
        GroupTransparency = if bool3 then var1.GroupTransparency else nil,
        ref = ref,
        [React.Tag] = var3
    }
    local var6 = var5(var1, tbl2)
    local var7

    if bool2 then
        var7 = Interactable
        var6.component = var4
        var6.onActivated = var1.onActivated
        var6.onSecondaryActivated = var1.onSecondaryActivated
        var6.onStateChanged = var1.onStateChanged
        var6.stateLayer = var1.stateLayer
        var6.isDisabled = var1.isDisabled
        var6.cursor = var1.cursor
    else
        var7 = var4
    end

    return React.createElement(var7, var6, GuiObjectChildren(var1))
end))
