-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Cryo = require(scriptParentParent.Cryo)
local Roact = require(scriptParentParent.Roact)

local success, result = pcall(function(): boolean
    return game:GetEngineFeature("TextBoundsRoundUp")
end)
local var1 = success and result

local TextService = game:GetService("TextService")
local function getTextHeight(string: string, fontSize: number, font: Enum.Font, x: number)
    if var1 then
        return TextService:GetTextSize(string, fontSize, font, Vector2.new(x, 10000)).Y
    end

    return TextService:GetTextSize(string, fontSize, font, Vector2.new(x, 10000)).Y + 2
end

local function getTextWidth(string: string, fontSize: number, font: Enum.Font)
    if var1 then
        return TextService:GetTextSize(string, fontSize, font, Vector2.new(10000, 10000)).X
    end

    return TextService:GetTextSize(string, fontSize, font, Vector2.new(10000, 10000)).X + 2
end

local function getFontTextBoundsAsync(getTextBoundsParamsText, getTextBoundsParamsSize, font, width: number): Vector2?
    local getTextBoundsParams = Instance.new("GetTextBoundsParams")
    getTextBoundsParams.Text = getTextBoundsParamsText
    getTextBoundsParams.Font = font
    getTextBoundsParams.Size = getTextBoundsParamsSize
    getTextBoundsParams.Width = width

    local success2, result2 = pcall(function(): Vector2
        return TextService:GetTextBoundsAsync(getTextBoundsParams)
    end)
    getTextBoundsParams:Destroy()

    return if success2 and typeof(result2) == "Vector2" then result2 else nil
end

local Width = {
    FitToText = {}
}

local var2 = Roact.PureComponent:extend("FitTextLabel")

var2.defaultProps = {
    Font = Enum.Font.SourceSans,
    Text = "Label",
    TextSize = 12,
    TextWrapped = true,
    maximumWidth = math.huge
}

function var2.init(arg1)
    arg1.measurementId = 0
    arg1.mounted = false

    if Roact.Ref == "ref" then
        arg1.frameRef = arg1.props.forwardedRef or Roact.createRef()
    else
        arg1.frameRef = arg1.props[Roact.Ref] or Roact.createRef()
    end

    function arg1.onResize()
        if not arg1.frameRef.current then
            return
        end

        if typeof(arg1.props.Font) == "Font" then
            arg1:__resizeForFont(arg1.frameRef.current)
        else
            arg1.measurementId += 1
            arg1.frameRef.current.Size = arg1:__getSize(arg1.frameRef.current)
        end
    end
end

function var2.render(arg1)
    local str1 = if arg1.props.onActivated then "TextButton" else "TextLabel"
    return Roact.createElement(str1, arg1:__getFilteredProps())
end

function var2.didMount(arg1)
    arg1.mounted = true
    arg1.onResize()
end

function var2.didUpdate(arg1)
    arg1.onResize()
end

function var2.willUnmount(arg1)
    arg1.mounted = false
    arg1.measurementId += 1
end

function var2.__getFilteredProps(arg1)
    local x = typeof(arg1.props.width) == "UDim" and arg1.props.width or UDim.new(0, 0)
    local tbl2 = {
        width = nil,
        width = Cryo.None,
        maximumWidth = Cryo.None,
        onActivated = Cryo.None,
        forwardedRef = Cryo.None,
        Size = UDim2.new(x, UDim.new(0, 0)),
        [Roact.Ref] = arg1.frameRef,
        [Roact.Children] = Cryo.Dictionary.join(arg1.props[Roact.Children] or {}, {
            sizeConstraint = arg1.props.maximumWidth < math.huge
                and Roact.createElement("UISizeConstraint", { MaxSize = Vector2.new(arg1.props.maximumWidth, math.huge) })
        }),
        [Roact.Event.Activated] = arg1.props.onActivated
    }
    tbl2[Roact.Change.AbsoluteSize] = function(arg2)
        if arg1.props[Roact.Change.AbsoluteSize] then
            arg1.props[Roact.Change.AbsoluteSize](arg2)
        end
        arg1.onResize()
    end

    if typeof(arg1.props.Font) == "Font" then
        tbl2.Font = Cryo.None
        tbl2.FontFace = arg1.props.Font
    end

    return Cryo.Dictionary.join(arg1.props, tbl2)
end

function var2.__resizeForFont(arg1, arg2)
    arg1.measurementId += 1
    local measurementId = arg1.measurementId

    local propsText = arg1.props.Text
    local textSize = arg1.props.TextSize
    local font = arg1.props.Font
    local maximumWidth = arg1.props.maximumWidth
    local width = arg1.props.width
    local num1 = math.max(maximumWidth < math.huge and maximumWidth or 0, arg2.AbsoluteSize.X)

    task.spawn(function()
        if width == Width.FitToText then
            local fontTextBoundsAsync = getFontTextBoundsAsync(propsText, textSize, font, 10000)
            local new = UDim.new
            local num2 = 0
            local var3 = if fontTextBoundsAsync then math.min(math.ceil(fontTextBoundsAsync.X), maximumWidth) or 0 else 0
            width = new(num2, var3)
        end

        if not arg1.mounted or arg1.measurementId ~= measurementId then
            return
        end

        local fontTextBoundsAsync = getFontTextBoundsAsync(propsText, textSize, font, num1)
        local offset = fontTextBoundsAsync and math.ceil(fontTextBoundsAsync.Y) or textSize

        if not arg1.mounted or arg1.measurementId ~= measurementId or not arg1.frameRef.current then
            return
        end

        arg1.frameRef.current.Size = UDim2.new(width, UDim.new(0, offset))
    end)
end

function var2.__getSize(arg1, arg2): UDim2
    local maximumWidth = arg1.props.maximumWidth
    local width = arg1.props.width
    if width == Width.FitToText then
        local textWidth = getTextWidth(arg1.props.Text, arg1.props.TextSize, arg1.props.Font)
        width = UDim.new(0, math.min(textWidth, maximumWidth))
    end

    local num1 = math.max(maximumWidth < math.huge and maximumWidth or 0, arg2.AbsoluteSize.X)
    local textHeight = getTextHeight(arg1.props.Text, arg1.props.TextSize, arg1.props.Font, num1)

    return UDim2.new(width, UDim.new(0, textHeight))
end

local var3 = if Roact.Ref == "ref" then Roact.forwardRef(function(arg1, forwardedRef)
    return Roact.createElement(var2, Cryo.Dictionary.join(arg1, { forwardedRef = forwardedRef }))
end) else var2

var3.Width = Width

return var3
