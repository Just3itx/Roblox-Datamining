-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ultimateList = script:FindFirstAncestor("ultimate-list")

local _Dimensions = require(ultimateList.Dimensions)
local DimensionsMethods = require(ultimateList.Dimensions.DimensionsMethods)
local React = require(ultimateList.Parent.React)
local _Renderers = require(ultimateList.Renderers)
local adjustPositionToScrollAxis = require(ultimateList.Dimensions.adjustPositionToScrollAxis)
local _createVirtualizedListController = require(ultimateList.createVirtualizedListController)
local joinAndMapBindings = require(ultimateList.Util.joinAndMapBindings)

local createElement = React.createElement

local function getKeyDefault(_, num1: number): string
    return tostring(num1)
end

local function ReactStateRenderer(tbl1)
    local var1, var2 = React.useState(tbl1.virtualizedListController.get)
    local var3, var4 = React.useBinding(nil)

    React.useEffect(function()
        local var5 = tbl1.virtualizedListController.get()
        var2(var5)

        return tbl1.virtualizedListController.bindToUpdate(function()
            var4({ lockedTo = var5, scrollAxis = tbl1.scrollAxisBinding:getValue() })

            var5 = tbl1.virtualizedListController.get()
            var2(var5)
        end)
    end, { tbl1.virtualizedListController, tbl1.scrollAxisBinding })

    local tbl2 = ({})
    local var5 = tbl1.getKey or getKeyDefault
    local range = tbl1.virtualizedListController.getRange()

    for value, value2 in var1 do
        local var6 = range.X + (value - 1)

        local uDimRect = DimensionsMethods.getUDimRect(
            tbl1.dimensions,
            value2,
            var6,
            tbl1.virtualizedListController.getWindowSize(),
            tbl1.direction
        )

        local var7 = var5(value2, var6)
        local var8 = createElement

        local tbl3 = {
            BackgroundTransparency = 1,
            Position = joinAndMapBindings(function(num1: number, tbl3)
                if tbl1.config.freezeViewWhileScrolling ~= false and tbl3 ~= nil and tbl3.lockedTo == var1 then
                    return adjustPositionToScrollAxis(uDimRect.position, tbl3.scrollAxis, tbl1.direction)
                end
                return adjustPositionToScrollAxis(uDimRect.position, num1, tbl1.direction)
            end, tbl1.scrollAxisBinding, var3),
            Size = uDimRect.size
        }

        tbl2[var7] = var8("Frame", tbl3, tbl1.callback(value2))
    end

    return createElement(React.Fragment, nil, tbl2)
end

return ReactStateRenderer
