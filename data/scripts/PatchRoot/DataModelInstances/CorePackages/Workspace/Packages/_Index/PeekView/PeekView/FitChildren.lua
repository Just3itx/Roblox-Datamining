-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeekViewParent = script:FindFirstAncestor("PeekView").Parent

local Cryo = require(PeekViewParent.Cryo)
local Roact = require(PeekViewParent.Roact)
local Immutable = require(PeekViewParent.AppCommonLib).Immutable
local Symbol = require(PeekViewParent.AppCommonLib).Symbol

local module = {
    FitAxis = {
        Width = Symbol.named("Width"),
        Height = Symbol.named("Height"),
        Both = Symbol.named("Both")
    }
}
function module.wrap(arg1)
    local var1 = Roact.PureComponent:extend(("FitChildren(%s)"):format(tostring(arg1)))

    function var1.disconnectSignals(arg2)
        for _, signal in ipairs(arg2.signals) do
            signal:Disconnect()
        end
    end

    function var1.resize(arg2)
        local var2 = arg2.props.fitFields or arg2.props.fitAxis and {
            Size = arg2.props.fitAxis
        } or {
            Size = module.FitAxis.Both
        }

        arg2:disconnectSignals()
        arg2.signals = {}

        local current = arg2.ref.current
        if current == nil then
            return
        end

        local uiGridStyleLayout = current:FindFirstChildWhichIsA("UIGridStyleLayout")
        if uiGridStyleLayout then
            local function update() -- Luacid: Inlined by compiler; 1 call site recovered
                local absoluteContentSize = uiGridStyleLayout.AbsoluteContentSize
                arg2:applyFit(var2, absoluteContentSize.x, absoluteContentSize.y)
            end
            local connection = uiGridStyleLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(update)
            table.insert(arg2.signals, connection)
            update()
            return
        end

        arg2:resizeFromChildren(var2)

        local children = current:GetChildren()
        for _, child in ipairs(children) do
            if not child:IsA("GuiBase2d") then
                continue
            end

            local connection = child:GetPropertyChangedSignal("Size"):Connect(function()
                arg2:resizeFromChildren(var2)
            end)
            table.insert(arg2.signals, connection)
            local connection2 = child:GetPropertyChangedSignal("Position"):Connect(function()
                arg2:resizeFromChildren(var2)
            end)
            table.insert(arg2.signals, connection2)
        end
    end

    function var1.resizeFromChildren(arg2, arg3)
        local current = arg2.ref.current
        if current == nil then
            return
        end

        local absolutePosition = current.AbsolutePosition
        local children = current:GetChildren()
        local num1 = 0
        local num2 = 0
        for _, child in ipairs(children) do
            if child:IsA("GuiBase2d") then
                local absoluteSize = child.AbsoluteSize
                local absolutePosition2 = child.AbsolutePosition

                num1 = math.max(num1, absolutePosition2.x - absolutePosition.x + absoluteSize.x)
                num2 = math.max(num2, absolutePosition2.y - absolutePosition.y + absoluteSize.y)
            end
        end
        arg2:applyFit(arg3, num1, num2)
    end

    function var1.applyFit(arg2, arg3, arg4, arg5)
        local current = arg2.ref.current
        if current == nil then
            return
        end

        local uiPadding = current:FindFirstChildOfClass("UIPadding")
        local var2 = arg2.props.Size or UDim2.new(0, 0, 0, 0)
        local width = module.FitAxis.Width
        local height = module.FitAxis.Height

        local function calculateAxis(both, arg6, arg7, arg8, str1: string, str2: string)
            local var3 = nil

            if both ~= arg6 and both ~= module.FitAxis.Both then
                return arg8.Scale, arg8.Offset
            end

            local num1 = 0
            if not uiPadding then
                return num1, arg7
            end

            local var4 = uiPadding[str1].Scale + uiPadding[str2].Scale
            local var5 = uiPadding[str1].Offset + uiPadding[str2].Offset
            if var4 ~= 1 then
                return num1, (arg7 + var5) / (1 - var4)
            end

            error("Can not apply FitChildren to a component with 100% padding width")
            return num1, var3
        end

        for k, value in pairs(arg3) do
            local xScale, xOffset = calculateAxis(value, width, arg4, var2.X, "PaddingLeft", "PaddingRight")
            local yScale, yOffset = calculateAxis(value, height, arg5, var2.Y, "PaddingTop", "PaddingBottom")

            current[k] = UDim2.new(xScale, xOffset, yScale, yOffset)
        end
    end

    function var1.init(arg2)
        arg2.signals = {}

        local forwardRef = arg2.props.forwardRef

        local bool1 = type(forwardRef) ~= "function"
        local str1 = tostring(var1)
        assert(bool1, ("%s does not support function ref forwarding"):format(str1))

        arg2.ref = forwardRef or Roact.createRef()
    end

    function var1.render(arg2)
        local var2 = Immutable.RemoveFromDictionary(arg2.props, "fitAxis", "fitFields", "forwardRef")
        var2[Roact.Ref] = arg2.ref

        return Roact.createElement(arg1, var2)
    end

    function var1.didMount(arg2)
        arg2:resize()
    end

    function var1.didUpdate(arg2)
        arg2:resize()
    end

    function var1.willUnmount(arg2)
        arg2:disconnectSignals()
    end

    return Roact.forwardRef(function(arg2, forwardRef)
        return Roact.createElement(var1, Cryo.Dictionary.join(arg2, { forwardRef = forwardRef }))
    end)
end

module.FitFrame = module.wrap("Frame")
module.FitScrollingFrame = module.wrap("ScrollingFrame")
module.FitTextButton = module.wrap("TextButton")

return module
