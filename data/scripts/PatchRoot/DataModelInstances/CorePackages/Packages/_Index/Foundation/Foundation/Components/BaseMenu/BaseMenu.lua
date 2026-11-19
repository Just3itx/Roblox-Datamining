-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:20:52Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Flags = require(Foundation.Utility.Flags)
local View = require(Foundation.Components.View)
local useScaledValue = require(Foundation.Utility.useScaledValue)

local useBindable = require(Foundation.Utility.useBindable)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local _ControlState = require(Foundation.Enums.ControlState)
local Radius = require(Foundation.Enums.Radius)

local _Types = require(Foundation.Components.Types)

local InputSize = require(Foundation.Enums.InputSize)

local BaseMenuContext = require(script.Parent.BaseMenuContext)
local BaseMenuScrollContainer = require(script.Parent.BaseMenuScrollContainer)
local useSubmenuHover = require(script.Parent.useSubmenuHover)

local DeclarativeBaseMenuContent = require(script.Parent.DeclarativeBaseMenuContent)

local tbl1 = {
    size = InputSize.Medium
}

local tbl2 = {
    [Radius.Small] = "radius-small",
    [Radius.Medium] = "radius-medium"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: BaseMenu
    local var1, var2 = React.useBinding(false)
    local var3 = table.clone(tbl1)
    var3.Visible = var1

    local var4 = withDefaults(arg1, var3)
    local width = useBindable(var4.width)
    local maxHeight = useBindable(var4.maxHeight)
    local var7 = useScaledValue(260)
    local x = useScaledValue(320)
    local hasLeading, var9 = React.useState(false)
    local var10 = useSubmenuHover()
    React.useEffect(function()
        task.delay(0, function()
            var2(true)
        end)
    end, {})

    local setHasLeading = React.useCallback(function()
        var9(true)
    end, {})

    local var12 = React.useMemo(function()
        return width:map(function(uDim: UDim?)
            return if uDim then uDim.Offset elseif Flags.FoundationBaseMenuContentSizing then 0 else var7
        end)
    end, { width, var7 })

    local autoSize = React.useMemo(function()
        return width:map(function(uDim: UDim?)
            if Flags.FoundationBaseMenuContentSizing then
                return not uDim or var4.couldGrow == true
            end
            local bool1 = not uDim
            return bool1 or var4.couldGrow == true and uDim.Offset < x
        end)
    end, { width, x, var4.couldGrow })

    local sizeConstraint = React.useMemo(function()
        return {
            MinSize = React.joinBindings({ autoSize, var12 }):map(function(arg2)
                local var14 = arg2[1]
                local var15 = arg2[2]
                if not var14 or Flags.FoundationBaseMenuContentSizing and var15 == 0 then
                    return nil
                end

                return Vector2.new(var15, 0)
            end),
            MaxSize = if Flags.FoundationBaseMenuContentSizing then nil else autoSize:map(function(arg2)
                if arg2 then
                    return Vector2.new(x, math.huge)
                end

                return nil
            end)
        }
    end, { autoSize, var12, x })

    local children = var4.children
    if not children and var4.items then
        children = React.createElement(DeclarativeBaseMenuContent, { items = var4.items, size = var4.size })
    end

    local var15 = if var4.radius == nil then "" else tbl2[var4.radius]

    local value = React.useMemo(function()
        return {
            onActivated = var4.onActivated,
            onNestedLeafActivated = var4.onNestedLeafActivated,
            size = var4.size,
            hasLeading = hasLeading,
            setHasLeading = setHasLeading,
            hoverOpenPath = var10.openPath,
            hoverOpenAtDepth = var10.openAtDepth,
            hoverCloseAtDepth = var10.closeAtDepth,
            hoverReset = var10.reset,
            depth = 1,
            maxHeight = var4.maxHeight
        }
    end, {
        var4.onActivated,
        var4.onNestedLeafActivated,
        var4.size,
        hasLeading,
        var10.openPath,
        var10.openAtDepth,
        var10.closeAtDepth,
        var10.reset,
        var4.maxHeight
    })

    local element = React.createElement(BaseMenuContext.Provider, { value = value }, children)

    if var4.maxHeight then
        return React.createElement(BaseMenuScrollContainer, {
            maxHeight = maxHeight,
            autoSize = autoSize,
            width = width,
            scrollViewProps = withCommonProps(var4, {
                ref = ref,
                sizeConstraint = sizeConstraint,
                scrollingFrameRef = var4.scrollingFrameRef,
                tag = `stroke-standard stroke-default {var15}`
            })
        }, element)
    end

    return React.createElement(
        View,
        withCommonProps(var4, {
            tag = `col stroke-standard stroke-default {var15}`,
            AutomaticSize = autoSize:map(function(arg2): Enum.AutomaticSize
                return if arg2 then Enum.AutomaticSize.XY else Enum.AutomaticSize.Y
            end),
            Size = React.joinBindings({ autoSize, width }):map(function(arg2)
                local var17 = arg2[1]
                local x2 = arg2[2]
                if var17 then
                    return nil
                end

                return UDim2.new(x2, UDim.new())
            end),
            ref = ref,
            sizeConstraint = sizeConstraint
        }),
        element
    )
end))
