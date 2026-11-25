-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:11:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local React = require(ServerDrivenUiParent.React)
local useTokens = require(ServerDrivenUiParent.Foundation).Hooks.useTokens
local SignalsReact = require(ServerDrivenUiParent.SignalsReact)
local _SduiCompat = require(ServerDrivenUiParent.SduiCompat)

local CollectionViews = require(ServerDrivenUiParent.CollectionViews)
local useCollectionLayout = CollectionViews.useCollectionLayout
local calculateItemWidth = CollectionViews.calculateItemWidth

local SduiPlaceholder = require(ServerDrivenUiParent.SduiSharedContent).SduiPlaceholder

local usePreferredTextSizeLineBudget = require(ServerDrivenUiParent.SduiSharedUtilities).usePreferredTextSizeLineBudget

local SharedFlags = require(ServerDrivenUiParent.SharedFlags)
local FIntLuaAppSduiCarouselPlaceholderHeaderHeightPx = SharedFlags.FIntLuaAppSduiCarouselPlaceholderHeaderHeightPx
local FFlagSduiCollectionCarouselPlaceholderItem = SharedFlags.FFlagSduiCollectionCarouselPlaceholderItem
local FFlagSduiPreferredTextSizeLineBudgets = SharedFlags.FFlagSduiPreferredTextSizeLineBudgets

local num1 = game:DefineFastInt("LuaAppSduiCarouselPlaceholderHeaderMinWidthPct", 30)

local num2 = game:DefineFastInt("LuaAppSduiCarouselPlaceholderHeaderMaxWidthPct", 60)

local uDim = UDim.new(1, 72)

local function SduiCollectionCarouselItemPlaceholderRow(tbl1)
    local var1 = React.useMemo(function()
        return tbl1.itemSizeBinding:map(function(vector2: Vector2): UDim2
            return UDim2.new(0, vector2.X, 0, vector2.Y)
        end)
    end, { tbl1.itemSizeBinding })

    local tbl2 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, tbl1.gutter)
        })
    }
    local var2 = if tbl1.carouselPeek > 0 then tbl1.itemsPerRow + 1 else tbl1.itemsPerRow

    for layoutOrder = 1, var2 do
        local str1 = `Item{layoutOrder}`
        local createElement = React.createElement

        local tbl3 = {
            ItemPlaceholder = React.cloneElement(tbl1.itemPlaceholderComponent, { transparencyBinding = tbl1.transparencyBinding })
        }
        tbl2[str1] = createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                LayoutOrder = layoutOrder,
                Size = var1
            },
            tbl3
        )
    end

    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        LayoutOrder = tbl1.layoutOrder,
        Size = tbl1.rowSizeBinding
    }, tbl2)
end

return React.memo(function(tbl1) -- name: SduiCollectionCarouselPlaceholder
    local var1 = useTokens()
    local scale = var1.Config.UI.Scale
    local var2 = if FFlagSduiPreferredTextSizeLineBudgets then usePreferredTextSizeLineBudget(tbl1.preferredTextSizeLineCount) else nil

    local var3 = useCollectionLayout(tbl1.collectionItemSize)

    local var4 = SignalsReact.useSignalBinding(var3.getContainerWidth)

    local var5 = tbl1.itemHeightFromWidth or uDim
    local var6 = nil
    local var7

    if FFlagSduiCollectionCarouselPlaceholderItem then
        local useMemo = React.useMemo
        local function func1()
            return var4:map(function(num3: number): Vector2
                local itemWidth = calculateItemWidth(var3.itemsPerRow, var3.gutter, var3.margin, num3, 0, var3.carouselPeek)

                local var8 = itemWidth * var5.Scale + var5.Offset * scale + (var2 or 0)

                return Vector2.new(itemWidth, math.max(var8, 0))
            end)
        end

        local itemsPerRow = var3.itemsPerRow
        local gutter = var3.gutter
        local margin = var3.margin
        local carouselPeek = var3.carouselPeek
        local var8 = if FFlagSduiPreferredTextSizeLineBudgets then var2 else nil
        var6 = useMemo(func1, { var4, itemsPerRow, gutter, margin, carouselPeek, var5, scale, var8 })

        var7 = React.useMemo(function()
            return var6:map(function(vector2: Vector2): UDim2
                return UDim2.new(1, 0, 0, vector2.Y)
            end)
        end, { var6 })
    else
        local useMemo = React.useMemo
        local function func1()
            return var4:map(function(num3: number): UDim2
                local var8 = calculateItemWidth(var3.itemsPerRow, var3.gutter, var3.margin, num3, 0, var3.carouselPeek) * var5.Scale + var5.Offset * scale + (var2 or 0)
                return UDim2.new(1, 0, 0, math.max(var8, 0))
            end)
        end

        local itemsPerRow = var3.itemsPerRow
        local gutter = var3.gutter
        local margin = var3.margin
        local carouselPeek = var3.carouselPeek
        local var8 = if FFlagSduiPreferredTextSizeLineBudgets then var2 else nil
        var7 = useMemo(func1, { var4, itemsPerRow, gutter, margin, carouselPeek, var5, scale, var8 })
    end

    local offset = if FFlagSduiCollectionCarouselPlaceholderItem and tbl1.hideHeader then 0 else var1.Padding.Medium

    local xScale = React.useMemo(function(): number
        local num3 = num1 / 100
        local num4 = num2 / 100
        return num3 + math.random() * (num4 - num3)
    end, {})

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        AnchorPoint = tbl1.anchorPoint,
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = tbl1.layoutOrder,
        Position = tbl1.position,
        Size = UDim2.fromScale(1, 0),
        ZIndex = tbl1.zIndex,
        [React.Tag] = if tbl1.testId then `data-testid={tbl1.testId}` else nil
    }
    local tbl3 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, offset)
        }),
        Header = if FFlagSduiCollectionCarouselPlaceholderItem and tbl1.hideHeader then nil else React.createElement(
            SduiPlaceholder,
            {
                backgroundStyle = tbl1.backgroundStyle,
                cornerRadius = tbl1.cornerRadius,
                layoutOrder = 1,
                size = UDim2.new(xScale, 0, 0, FIntLuaAppSduiCarouselPlaceholderHeaderHeightPx * scale),
                transparencyBinding = tbl1.transparencyBinding
            }
        ),
        Row = 0
    }
    local element

    if FFlagSduiCollectionCarouselPlaceholderItem and tbl1.itemPlaceholderComponent then
        element = React.createElement(SduiCollectionCarouselItemPlaceholderRow, {
            carouselPeek = var3.carouselPeek,
            gutter = var3.gutter,
            itemPlaceholderComponent = tbl1.itemPlaceholderComponent,
            itemSizeBinding = var6,
            itemsPerRow = var3.itemsPerRow,
            layoutOrder = 2,
            rowSizeBinding = var7,
            transparencyBinding = tbl1.transparencyBinding
        })
    else
        element = React.createElement(SduiPlaceholder, {
            backgroundStyle = tbl1.backgroundStyle,
            cornerRadius = tbl1.cornerRadius,
            layoutOrder = 2,
            size = var7,
            transparencyBinding = tbl1.transparencyBinding
        })
    end

    tbl3.Row = element
    return createElement(str1, tbl2, tbl3)
end)
