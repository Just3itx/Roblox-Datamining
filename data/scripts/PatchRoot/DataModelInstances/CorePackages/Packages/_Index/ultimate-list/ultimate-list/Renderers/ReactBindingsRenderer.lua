-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:50:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ultimateList = script:FindFirstAncestor("ultimate-list")

local _Dimensions = require(ultimateList.Dimensions)
local DimensionsMethods = require(ultimateList.Dimensions.DimensionsMethods)
local React = require(ultimateList.Parent.React)
local adjustPositionToScrollAxis = require(ultimateList.Dimensions.adjustPositionToScrollAxis)
local createDebugLogger = require(ultimateList.Util.createDebugLogger)
local _createVirtualizedListController = require(ultimateList.createVirtualizedListController)
local joinAndMapBindings = require(ultimateList.Util.joinAndMapBindings)

local createElement = React.createElement

local debugLogger = createDebugLogger("ReactBindingsRenderer")

local function getKeyDefault(_, num1: number): string
    return tostring(num1)
end

return (React.memo(function(tbl1) -- name: ReactBindingsRenderer
    local var1, var2 = React.useState(function()
        local result = {}

        local var1 = DimensionsMethods.elementsDisplayedHint(tbl1.dimensions, tbl1.virtualizedListController.getWindowSize(), tbl1.direction)

        if var1 == nil then
            return result
        end

        for _ = 1, var1 do
            local binding, set = React.createBinding({ contents = { type = "vacant" } })

            table.insert(result, { binding = binding, set = set })
        end

        return result
    end)

    local var3 = tbl1.getKey or getKeyDefault

    React.useEffect(function()
        return tbl1.virtualizedListController.bindToUpdate(function()
            local var4 = tbl1.virtualizedListController.get()
            local range = tbl1.virtualizedListController.getRange()

            local tbl2 = ({})
            for value, value2 in var4 do
                tbl2[var3(value2, value + (range.X - 1))] = value
            end

            local tbl3 = {}
            local tbl4 = {}
            local tbl5 = {}

            for _, value in var1 do
                local value2 = value.binding:getValue()
                if value2.contents.type == "vacant" then
                    table.insert(tbl4, value.set)
                else
                    local key = value2.contents.key
                    local var5 = tbl2[key]
                    if var5 == nil then
                        debugLogger("%s is now dead", key)
                        table.insert(tbl3, value.set)
                    else
                        tbl2[key] = nil

                        local var6 = var4[var5]
                        if value2.contents.value ~= var6 then
                            debugLogger("%s existed, but changed", key)
                            value.set({ contents = { type = "full", index = var5 + (range.X - 1), key = key, value = var6 } })
                        end
                    end
                end
            end

            debugLogger("%d total setters, %d dead setters, %d vacant setters", #var1, #tbl3, #tbl4)

            for key, value2 in tbl2 do
                assert(value2 ~= nil, "Luau")
                local value = var4[value2]

                local tbl6 = {
                    contents = {
                        type = "full",
                        index = value2 + (range.X - 1),
                        key = key,
                        value = value
                    }
                }

                local var6 = table.remove(tbl3)
                if var6 ~= nil then
                    debugLogger("%s is filling dead spot", key)
                    var6(tbl6)
                else
                    local var7 = table.remove(tbl4)
                    if var7 ~= nil then
                        debugLogger("%s is filling vacant spot", key)
                        var7(tbl6)
                    else
                        local binding, set = React.createBinding(tbl6)
                        table.insert(tbl5, { binding = binding, set = set })
                    end
                end
            end
            if #tbl5 > 0 then
                debugLogger("Needed to create %d more bindings to fit, there will be %d setters", #tbl5, #tbl5 + #var1)

                var2(function(arg1)
                    arg1 = table.clone(arg1)
                    table.move(tbl5, 1, #tbl5, #arg1 + 1, arg1)
                    return arg1
                end)
            end

            for _, value in tbl3 do
                value({ contents = { type = "vacant" } })
            end
        end)
    end, { tbl1.virtualizedListController, var3, var1 })

    local tbl2 = ({})
    for value, value2 in var1 do
        local binding = value2.binding

        local var4 = binding:map(function(tbl3)
            if tbl3.contents.type == "vacant" then
                return {
                    size = UDim2.new(),
                    position = UDim2.new()
                }
            end

            return DimensionsMethods.getUDimRect(
                tbl1.dimensions,
                tbl3.contents.value,
                tbl3.contents.index,
                tbl1.virtualizedListController.getWindowSize(),
                tbl1.direction
            )
        end)

        local str1 = `Item{value}`

        tbl2[str1] = createElement("Frame", {
            BackgroundTransparency = 1,
            Position = joinAndMapBindings(function(arg1, num1: number)
                return adjustPositionToScrollAxis(arg1.position, num1, tbl1.direction)
            end, var4, tbl1.scrollAxisBinding),
            Size = var4:map(function(arg1)
                return arg1.size
            end),
            Visible = binding:map(function(tbl3): boolean
                return tbl3.contents.type == "full"
            end)
        }, {
            Content = tbl1.callback(binding:map(function(tbl3)
                return if tbl3.contents.type == "full" then tbl3.contents.value else nil
            end))
        })
    end

    return createElement(React.Fragment, {}, tbl2)
end))
