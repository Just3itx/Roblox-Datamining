-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent
local React = require(ServerDrivenUiParent.React)
local Cryo = require(ServerDrivenUiParent.Cryo)

local ImpressionsTagUtility = require(ServerDrivenUiParent.Impressions).ImpressionsTagUtility
local combineReactTags = require(ServerDrivenUiParent.RoactUtils).combineReactTags

local FFlagSduiOptionSelectorAnchorTag = require(ServerDrivenUiParent.SharedFlags).FFlagSduiOptionSelectorAnchorTag

return React.memo(function(tbl1) -- name: SduiCollectionItem
    local layoutOrder = tbl1.layoutOrder
    local size = tbl1.size
    local position = tbl1.position
    local anchorPoint = tbl1.anchorPoint
    local zIndex = tbl1.zIndex
    local automaticSize = tbl1.automaticSize
    local innerWrapperSize = tbl1.innerWrapperSize
    local var1 = React.useRef(nil)
    React.useEffect(function()
        ImpressionsTagUtility.AddTag(var1, tbl1.impressionsTag, tbl1.index)
        return function()
            ImpressionsTagUtility.RemoveTag(var1, tbl1.impressionsTag, tbl1.index)
        end
    end, { var1, tbl1.impressionsTag, tbl1.index })

    local var2 = React.useCallback(function(current)
        var1.current = current
        if current then
            ImpressionsTagUtility.AddTag(var1, tbl1.impressionsTag, tbl1.index)
        end
    end, { tbl1.impressionsTag, tbl1.index })

    local var3 = React.useCallback(function(arg1)
        if tbl1.onItemSizeChanged then
            tbl1.onItemSizeChanged(tbl1.index, arg1)
        end
    end, { tbl1.onItemSizeChanged, tbl1.index })

    local var4 = innerWrapperSize ~= nil
        and {
            InnerWrapper = React.createElement(
                "Frame",
                {
                    ref = var2,
                    Size = innerWrapperSize,
                    Position = UDim2.fromScale(0, 0),
                    BackgroundTransparency = 1
                },
                tbl1.children
            )
        }
        or tbl1.children

    if tbl1.minHeightBinding then
        var4 = Cryo.Dictionary.join(var4 or {}, {
            SizeConstraint = React.createElement("UISizeConstraint", {
                MinSize = tbl1.minHeightBinding:map(function(num1: number?): Vector2
                    return Vector2.new(0, num1 and num1 > 0 and num1 or 0)
                end)
            })
        })
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {}
    if innerWrapperSize ~= nil then
        var2 = nil
    end

    tbl2.ref = var2
    tbl2.AnchorPoint = anchorPoint
    tbl2.Position = position
    tbl2.Size = size
    tbl2.LayoutOrder = layoutOrder or tbl1.index
    tbl2.ZIndex = zIndex
    tbl2.BackgroundTransparency = 1
    tbl2.AutomaticSize = automaticSize
    local absoluteSize = React.Change.AbsoluteSize

    if not tbl1.onItemSizeChanged then
        var3 = nil
    end

    tbl2[absoluteSize] = var3
    local tag = React.Tag
    local var5 = if FFlagSduiOptionSelectorAnchorTag then combineReactTags(tbl1.tag, if tbl1.testId then `data-testid={tbl1.testId}` else nil) elseif tbl1.testId then `data-testid={tbl1.testId}` else nil
    tbl2[tag] = var5
    return createElement(str1, tbl2, var4)
end)
