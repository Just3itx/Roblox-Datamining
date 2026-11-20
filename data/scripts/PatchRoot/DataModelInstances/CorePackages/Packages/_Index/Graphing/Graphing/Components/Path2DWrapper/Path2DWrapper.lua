-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:40:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphingParent = script:FindFirstAncestor("Graphing").Parent
local React = require(GraphingParent.React)
local Signals = require(GraphingParent.Signals)

local maxControlPoints = nil
local function getMaxPointsPerPath() -- Luacid: Inlined by compiler; 1 call site recovered
    if not maxControlPoints then
        local path2D = Instance.new("Path2D")
        maxControlPoints = path2D:GetMaxControlPoints()
        path2D:Destroy()
    end

    assert(maxControlPoints, "MAX_POINTS_PER_PATH was nil")
    return maxControlPoints
end

function Path2DWrapper(tbl1)
    local ref = React.useRef(nil)
    local maxPointsPerPath = getMaxPointsPerPath()
    local var2 = tbl1.PointCount or tbl1.ControlPoints and #tbl1.ControlPoints or 0

    local function applyControlPoints(tbl2)
        local current = ref.current
        if not current then
            return
        end

        local num1 = 1
        for _, child in current:GetChildren() do
            local tbl3 = {}
            local num2 = #tbl2

            for i = num1, num1 + maxPointsPerPath - 1 do
                if num2 < i then
                    break
                end

                table.insert(tbl3, tbl2[i])
            end

            child:SetControlPoints(tbl3)
            num1 += maxPointsPerPath - 1
        end
    end

    React.useLayoutEffect(function()
        if tbl1.ObserveControlPoints then
            local observeControlPoints = tbl1.ObserveControlPoints
            return Signals.createEffect(function(arg1)
                applyControlPoints(observeControlPoints(arg1))
            end)
        end

        if tbl1.ControlPoints then
            applyControlPoints(tbl1.ControlPoints)
        end
        return function() end
    end, { tbl1.ObserveControlPoints, tbl1.ControlPoints })

    local tag = tbl1.Tag or ""
    local var3 = tbl1.ClipContents == nil or tbl1.ClipContents

    local tbl2 = ({})
    local num1 = 1
    for _ = 2, var2, maxPointsPerPath - 1 do
        local str1 = tostring(num1)
        tbl2[str1] = React.createElement(
            "Path2D",
            {
                Color3 = tbl1.Color3,
                Thickness = tbl1.Thickness,
                ZIndex = tbl1.ZIndex,
                [React.Tag] = tag
            }
        )
        num1 += 1
    end

    return React.createElement(
        if var3 then "CanvasGroup" else "Frame",
        {
            ref = ref,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.fromScale(1, 1),
            ZIndex = tbl1.ZIndex
        },
        tbl2
    )
end

return Path2DWrapper
