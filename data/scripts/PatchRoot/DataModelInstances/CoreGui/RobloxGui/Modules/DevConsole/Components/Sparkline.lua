-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:50:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local Constants = require(script.Parent.Parent.Constants)
local LineWidth = Constants.GeneralFormatting.LineWidth
local HighlightBlue = Constants.Color.HighlightBlue
local uDim2 = UDim2.fromOffset(52, 13)

local var1 = Roact.Component:extend("Sparkline")

function var1.init(arg1)
    arg1.graphRef = Roact.createRef()
    arg1.state = { absSize = nil }
end

function var1.didMount(arg1)
    arg1:setState({ absSize = arg1.graphRef.current.AbsoluteSize })
end

function var1.didUpdate(arg1)
    local absoluteSize = arg1.graphRef.current.AbsoluteSize
    if arg1.state.absSize ~= absoluteSize then
        arg1:setState({ absSize = absoluteSize })
    end
end

function var1.render(arg1)
    local dataSet = arg1.props.dataSet
    local getY = arg1.props.getY
    local minY = arg1.props.minY
    local maxY = arg1.props.maxY
    local backgroundColor3 = arg1.props.color or HighlightBlue
    local absSize = arg1.state.absSize

    local tbl1 = ({})
    if absSize and dataSet then
        local var3 = dataSet:iterator()
        local var4 = var3:next()
        local tbl2 = {}

        while var4 do
            table.insert(tbl2, getY(var4))
            var4 = var3:next()
        end

        local var5 = maxY - minY
        local num1 = #tbl2
        for i = 2, num1 do
            local var6 = var5 > 0 and (tbl2[i] - minY) / var5 or 0.5
            local var7 = var5 > 0 and (tbl2[i - 1] - minY) / var5 or 0.5

            local var8 = (i - 1) / (num1 - 1) * absSize.X
            local var9 = (i - 2) / (num1 - 1) * absSize.X
            local var10 = var6 * absSize.Y
            local var11 = var7 * absSize.Y

            local var12 = (var8 + var9) / 2
            local var13 = (var10 + var11) / 2
            local var14 = var8 - var9
            local var15 = var10 - var11

            local xOffset = math.sqrt(var14 * var14 + var15 * var15)
            local num2 = math.deg(math.atan2(var15, var14))

            local str1 = "seg" .. i
            tbl1[str1] = Roact.createElement("Frame", {
                Size = UDim2.new(0, xOffset, 0, LineWidth),
                Position = UDim2.new(0, var12 - xOffset / 2, 1, -var13),
                BackgroundColor3 = backgroundColor3,
                BorderSizePixel = 0,
                Rotation = -num2
            })
        end
    end

    return Roact.createElement("Frame", {
        Size = arg1.props.size or uDim2,
        Position = arg1.props.pos,
        LayoutOrder = arg1.props.layoutOrder,
        BackgroundTransparency = 1,
        [Roact.Ref] = arg1.graphRef
    }, tbl1)
end

return var1
