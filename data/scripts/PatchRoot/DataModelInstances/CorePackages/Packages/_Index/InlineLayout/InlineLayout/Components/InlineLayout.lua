-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ComponentsParent = script:FindFirstAncestor("Components").Parent
local ComponentsParentParent = ComponentsParent.Parent
local Foundation = require(ComponentsParentParent.Foundation)

local React = require(ComponentsParentParent.React)

local useCallback = React.useCallback
local useRef = React.useRef
local useState = React.useState
local useEffect = React.useEffect

local map = require(ComponentsParentParent.Dash).map

local _RenderableInlineElement = require(ComponentsParent.Components.InlineLayout.InlineLayoutElements.RenderableInlineElement)
local HardBreakElement = require(ComponentsParent.Components.InlineLayout.InlineLayoutElements.HardBreakElement)
local HoverContext = require(ComponentsParent.Components.InlineLayout.InlineLayoutElements.HoverContext)
local renderInMeasuredFrame = require(ComponentsParent.Utils.renderInMeasuredFrame)
local MarkdownCore = require(ComponentsParentParent.MarkdownCore)
local View = Foundation.View

local Flags = MarkdownCore.Flags

local bool1 = game:DefineFastFlag("FFlagDebugInlineLayout", false)

local function layoutElements(elements, num1: number)
    if #elements == 0 then
        return {}
    end

    local num2 = if Flags.FFlagMarkdownAssistantParity then #elements * 4 + 100 else 100

    local tbl1 = {}
    local tbl2 = {}
    local num3 = num1

    local function flushRow() -- Luacid: Inlined by compiler; 2 call sites recovered
        table.insert(tbl1, tbl2)
        tbl2 = {}
        num3 = num1
    end

    local num4 = 1
    local num5 = 0
    local var1 = nil
    local bool2 = false
    local var2

    while true do
        while true do
            if not ((num4 <= #elements or var1) and num5 < num2) then
                if num5 == num2 and bool1 then
                    warn(
                        "InlineLayout: trying to wrap text across multiple lines and iterations cap is reached. Layout may be imperfect",
                        `Desired width: {num1}, elements: {#elements}`,
                        debug.traceback()
                    )
                end

                if #tbl2 > 0 then
                    table.insert(tbl1, tbl2)
                end
                return map(tbl1, function(arg1, layoutOrder)
                    return React.createElement(
                        View,
                        {
                            tag = "auto-xy row align-x-left",
                            key = tostring(layoutOrder),
                            LayoutOrder = layoutOrder
                        },
                        arg1
                    )
                end)
            end

            var2 = var1 or elements[num4]

            if var2 == HardBreakElement then
                num4 += 1
                flushRow()
                bool2 = false
                continue
            end

            local bool3 = false

            if #tbl2 == 0 and bool2 and var2.trimStart then
                var2 = var2:trimStart()
                bool3 = var2 == nil
            end

            if not bool3 then
                break
            end

            num4 += 1
            num5 += 1
            var1 = nil
        end

        local width = var2:getWidth()

        local num6 = #tbl2

        if width <= num3 then
            local tbl3 = tbl2
            table.insert(tbl3, renderInMeasuredFrame(var2:render(num4, num6), width, num6))

            num3 -= width

            num4 += 1
            var1 = nil
        else
            local var3
            var3, var1 = var2:split(num3)

            if var3:getWidth() <= num3 then
                local tbl3 = tbl2
                table.insert(tbl3, renderInMeasuredFrame(var3:render(num4, num6), var3:getWidth(), num6))
            elseif #tbl2 == 0 then
                if var2.canForceSplit then
                    var3, var1 = var2:split(num3, true)
                end

                local tbl3 = tbl2
                table.insert(tbl3, renderInMeasuredFrame(var3:render(num4, num6), var3:getWidth(), num6))
            else
                var1 = var2
            end

            if Flags.FFlagMarkdownAssistantParity and var1 == nil then
                num4 += 1
            end

            flushRow()
            bool2 = true
        end

        num5 += 1
    end
end

local function InlineLayout(tbl1)
    local ref = useRef(nil)
    local var2 = Foundation.Hooks.useTokens()
    local var3, var4 = useState({})

    local onAbsoluteSizeChanged = useCallback(function()
        if ref.current ~= nil and ref.current.AbsoluteSize.X ~= 0 then
            var4(layoutElements(tbl1.Elements, ref.current.AbsoluteSize.X))
        end
    end, { tbl1.Elements })

    useEffect(onAbsoluteSizeChanged, { onAbsoluteSizeChanged })

    return React.createElement(
        HoverContext.Provider,
        nil,
        React.createElement(View, {
            onAbsoluteSizeChanged = onAbsoluteSizeChanged,
            ref = ref,
            tag = "size-full-0 auto-y",
            layout = {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = tbl1.HorizontalAlignment or Enum.HorizontalAlignment.Left,
                Padding = tbl1.VerticalPadding or UDim.new(0, var2.Gap.Small)
            }
        }, var3)
    )
end

return InlineLayout
