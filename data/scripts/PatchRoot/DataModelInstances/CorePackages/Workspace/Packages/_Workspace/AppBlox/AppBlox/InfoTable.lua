-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent

local React = require(AppBloxParent.React)
local Foundation = require(AppBloxParent.Foundation)
local useBreakpoint = require(AppBloxParent.Foundation).Hooks.useBreakpoint
local useResponsive = require(AppBloxParent.Foundation).Hooks.useResponsive
local ResponsiveProvider = require(AppBloxParent.Foundation).ResponsiveProvider
local Cryo = require(AppBloxParent.Cryo)

local SharedFlags = require(AppBloxParent.SharedFlags)

local bool1 = game:DefineFastFlag("LuaAppInfoTableResponsiveProviderOverride", false)
local FFlagInfoTableStableItemKeys = SharedFlags.FFlagInfoTableStableItemKeys

local Breakpoint = Foundation.Enums.Breakpoint

local function buildColumnMajorChildren(items, num1: number, size: number)
    local itemsLen = #items
    local num2 = math.ceil(itemsLen / num1)
    local columnMajorChildren = ({})
    local num3 = 0
    for i = 1, num2 do
        for j = 1, num1 do
            num3 += 1
            local num4 = (j - 1) * num2 + i
            local var1 = if num4 <= itemsLen then items[num4] else React.createElement(Foundation.View, { tag = "size-full-0 auto-y", BackgroundTransparency = 1 })
            local str1 = if FFlagInfoTableStableItemKeys then if num4 <= itemsLen then `Cell_{num4}` else `Placeholder_{num3}` else `Cell_{num3}`
            columnMajorChildren[str1] = React.createElement(Foundation.Grid.Cell, { size = size, tag = "size-full-0 auto-y", LayoutOrder = num3 }, var1)
        end
    end

    return columnMajorChildren
end

return React.memo(function(tbl1) -- name: InfoTable
    local var1 = if tbl1.numColumns and tbl1.numColumns > 0 then tbl1.numColumns else 1
    local var2 = nil
    local var3 = nil
    local var4, var5

    if bool1 then
        local var6
        var2, var6 = React.useState(false)
        var3 = var6
        var4, var5 = React.useState(nil)
    else
        var4 = nil
        var5 = nil
    end

    local tbl2 = {}
    local size = 12 / var1
    if not bool1 or var2 then
        if var1 > 1 then
            tbl2 = buildColumnMajorChildren(tbl1.items, var1, size)
        else
            for layoutOrder, item in tbl1.items do
                tbl2[`Cell_{layoutOrder}`] = React.createElement(Foundation.Grid.Cell, { size = size, tag = "size-full-0 auto-y", LayoutOrder = layoutOrder }, item)
            end
        end
    end

    local var7

    if bool1 then
        local var8 = useResponsive()
        local join = Cryo.Dictionary.join
        local config = var8.config
        local tbl3 = {
            grid = Cryo.Dictionary.join(var8.config.grid, {
                margins = {
                    [Breakpoint.XSmall] = 0,
                    [Breakpoint.Small] = 0,
                    [Breakpoint.Medium] = 0,
                    [Breakpoint.Large] = 0,
                    [Breakpoint.XLarge] = 0,
                    [Breakpoint.XXLarge] = 0
                }
            })
        }
        var7 = join(config, tbl3)
    else
        var7 = nil
    end

    if bool1 then
        local _, var8 = useBreakpoint(var4)

        React.useEffect(function()
            if var8.X > 0 then
                task.defer(function()
                    var3(true)
                end)
            end
        end, { var8.X })

        return React.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            LayoutOrder = tbl1.LayoutOrder,
            ref = var5
        }, {
            ContentFrame = React.createElement("Frame", {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                LayoutOrder = tbl1.LayoutOrder
            }, {
                Grid = React.createElement(
                    ResponsiveProvider,
                    { config = var7 },
                    React.createElement(Foundation.Grid.Root, { tag = tbl1.gridTag, testId = tbl1.testId }, tbl2)
                )
            })
        })
    elseif bool1 then
        return React.createElement(
            ResponsiveProvider,
            { config = var7 },
            React.createElement(
                Foundation.Grid.Root,
                {
                    tag = tbl1.gridTag,
                    LayoutOrder = tbl1.LayoutOrder,
                    testId = tbl1.testId
                },
                tbl2
            )
        )
    else
        return React.createElement(
            Foundation.Grid.Root,
            {
                tag = tbl1.gridTag,
                LayoutOrder = tbl1.LayoutOrder,
                testId = tbl1.testId
            },
            tbl2
        )
    end
end)
