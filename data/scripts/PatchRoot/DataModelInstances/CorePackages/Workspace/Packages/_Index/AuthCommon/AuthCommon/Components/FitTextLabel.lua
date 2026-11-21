-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:11:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local Roact = require(AuthCommonParent.Roact)
local Immutable = require(AuthCommonParent.AppCommonLib).Immutable
local GetTextSize = require(AuthCommonParent.Style).GetTextSize
local normalizeFontFace = require(AuthCommonParent.Foundation).Utility.normalizeFontFace

local FitChildren = require(AuthCommon.Components.FitChildren)

local var1 = Roact.PureComponent:extend("FitTextLabel")

var1.defaultProps = {
    fitAxis = FitChildren.FitAxis.Height,
    maxWidth = nil
}

function var1.init(arg1)
    function arg1.onRef(ref)
        arg1.ref = ref
    end

    function arg1.resize(arg2)
        local fitAxis = arg1.props.fitAxis
        local maxWidth = arg1.props.maxWidth

        if fitAxis ~= FitChildren.FitAxis.Width and fitAxis ~= FitChildren.FitAxis.Both then
            local uDim = UDim.new(0, GetTextSize(arg2.Text, arg2.TextSize, arg2.FontFace, Vector2.new(arg2.AbsoluteSize.X, 10000)).Y)

            arg1:setState({ width = arg2.Size.Width, height = uDim })

            return
        end

        local uDim = UDim.new(0, GetTextSize(arg2.Text, arg2.TextSize, arg2.FontFace, Vector2.new(10000, 10000)).X)
        local var2

        if maxWidth ~= nil and maxWidth < uDim.Offset then
            uDim = UDim.new(0, maxWidth)
            var2 = UDim.new(0, GetTextSize(arg2.Text, arg2.TextSize, arg2.FontFace, Vector2.new(uDim.Offset, 10000)).Y)
        else
            var2 = fitAxis == FitChildren.FitAxis.Both and UDim.new(0, arg2.TextSize) or arg2.Size.Height
        end

        arg1:setState({ width = uDim, height = var2 })
    end
    arg1:setState({ width = nil, height = nil })
end

function var1.render(arg1)
    local var2 = arg1.props.fitAxis or FitChildren.FitAxis.Height
    local var3 = Immutable.RemoveFromDictionary(arg1.props, "fitAxis", "maxWidth", "Font", "FontFace")
    local width = arg1.state.width
    local height = arg1.state.height

    if width and height then
        var3 = Immutable.JoinDictionaries(var3, { Size = UDim2.new(width, height) })
    end

    return Roact.createElement(
        "TextLabel",
        Immutable.JoinDictionaries(var3, {
            FontFace = if arg1.props.FontFace or arg1.props.Font then normalizeFontFace(arg1.props.FontFace or arg1.props.Font) else nil
        }, {
            [Roact.Ref] = arg1.onRef,
            [Roact.Change.Text] = arg1.resize,
            [Roact.Change.TextSize] = arg1.resize,
            [Roact.Change.AbsoluteSize] = if var2 == FitChildren.FitAxis.Height then arg1.resize or nil else nil,
            [Roact.Change.FontFace] = arg1.resize
        })
    )
end

function var1.didMount(arg1)
    arg1.resize(arg1.ref)
end

return var1
