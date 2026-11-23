-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent
local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local ReactRoblox = require(BuildExperienceParent.ReactRoblox)
local GuiService = game:GetService("GuiService")

local useTokens = Foundation.Hooks.useTokens

local function sameSnapPoints(current, tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    if #current ~= #tbl1 then
        return false
    end
    for value, value2 in current do
        if tbl1[value] ~= value2 then
            return false
        end
    end
    return true
end

local function useSheetBounds(tbl1, num1: number, sheet: number, content: number, num2: number, callback: (...any) -> (...any))
    local var1 = useTokens()
    local onBoundsChanged = tbl1.onBoundsChanged
    React.useEffect(function()
        if not tbl1.isOpen or sheet == nil or content == nil or num1 == nil then
            onBoundsChanged(nil, nil)
            callback(nil)
            return nil
        end
        local function updateBounds()
            local absolutePosition = num1.AbsolutePosition
            if sheet.AbsoluteSize.X < num1.AbsoluteSize.X - 1 then
                onBoundsChanged(nil, if sheet.AbsoluteSize.X > 0 then sheet.AbsolutePosition.X else nil)
                local min = sheet.AbsolutePosition - absolutePosition
                callback({ rect = Rect.new(min, min + sheet.AbsoluteSize), areaSize = num1.AbsoluteSize })
                return
            end
            local bool1 = content.AbsoluteSize.Y > 0
            onBoundsChanged(if bool1 then content.AbsolutePosition.Y - var1.Padding.Medium else nil, nil)
            local var2 = num1.AbsoluteSize.Y - num2
            local func1 = callback
            local tbl2

            if bool1 then
                tbl2 = { rect = 0, areaSize = 0 }
                local new = Rect.new
                local new2 = Vector2.new
                local var3 = var2 - var1.Size.Size_800
                tbl2.rect = new(new2(0, math.max(0, var3)), num1.AbsoluteSize)

                tbl2.areaSize = num1.AbsoluteSize
            else
                tbl2 = nil
            end

            func1(tbl2)
        end

        updateBounds()
        local tbl2 = {}
        for _, value in { sheet, content, num1 } do
            local absolutePositionChanged = value:GetPropertyChangedSignal("AbsolutePosition")
            table.insert(tbl2, absolutePositionChanged:Connect(updateBounds))
            local absoluteSizeChanged = value:GetPropertyChangedSignal("AbsoluteSize")
            table.insert(tbl2, absoluteSizeChanged:Connect(updateBounds))
        end
        return function()
            for _, value in tbl2 do
                value:Disconnect()
            end
            onBoundsChanged(nil, nil)
            callback(nil)
        end
    end, {
        tbl1.isOpen,
        sheet,
        content,
        num1,
        num2,
        var1,
        onBoundsChanged,
        callback
    })
end

local function LibraryChatSheetOverlay(tbl1)
    local var1 = Foundation.Hooks.useOverlay()
    local var2, var3 = React.useState(nil)
    local gui, ref = React.useState(nil)
    local var6, var7 = React.useState({})
    React.useLayoutEffect(function()
        if var1 == nil then
            return nil
        end
        local var8 = var1:FindFirstAncestorWhichIsA("ScreenGui") or var1
        local function updateLayout()
            var3({
                originY = var1.AbsolutePosition.Y,
                screenHeight = var8.AbsoluteSize.Y,
                availableHeight = var1.AbsoluteSize.Y,
                isBottomSheet = GuiService.ViewportDisplaySize == Enum.DisplaySize.Small and var8.AbsoluteSize.X <= var8.AbsoluteSize.Y
            })
        end

        updateLayout()
        local tbl2 = {
            var1:GetPropertyChangedSignal("AbsolutePosition"):Connect(updateLayout),
            var1:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateLayout),
            var8:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateLayout),
            GuiService:GetPropertyChangedSignal("ViewportDisplaySize"):Connect(updateLayout)
        }

        return function()
            for _, value in tbl2 do
                value:Disconnect()
            end
        end
    end, { var1 })
    local var8, var4 = React.useState(nil)
    local var10, var11 = React.useBinding(nil)
    local var12 = React.useCallback(function(sheet, content)
        var7({ sheet = sheet, content = content })
    end, {})
    local var13, var14 = React.useState(nil)
    local var15 = if tbl1.top == nil or var2 == nil then 0 else math.max(0, tbl1.top - var2.originY)
    local var16 = if var2 == nil then 0 else var2.screenHeight
    local var17 = if var2 == nil then 0 else var2.availableHeight
    local snapPoints = tbl1.snapPoints
    if var16 > 0 then
        snapPoints = {}
        for _, snapPoint in tbl1.snapPoints do
            table.insert(snapPoints, math.max(2, math.min(snapPoint * var16, var17 - var15)))
        end
    end

    local var18 = React.useRef(snapPoints)

    if not sameSnapPoints(var18.current, snapPoints) then
        var18.current = snapPoints
    end
    local current = var18.current
    useSheetBounds(tbl1, var8, var6.sheet, var6.content, var13 or current[1], var11)
    local isBottomSheet = not (var2 == nil) and var2.isBottomSheet
    local var19 = tbl1.renderSheet(current, var12, var14)
    local yOffset = if isBottomSheet then 0 else var15

    local createElement = React.createElement
    local fragment = React.Fragment
    local var20 = nil
    local tbl2 = { Inset = 0, Sheet = 0 }
    local portal

    if var1 == nil then
        portal = nil
    else
        portal = ReactRoblox.createPortal(
            React.createElement(Foundation.View, {
                ref = var4,
                Position = UDim2.fromOffset(0, yOffset),
                Size = UDim2.new(1, 0, 1, -yOffset),
                backgroundStyle = { Transparency = 1 }
            }, {
                Window = React.createElement(Foundation.View, {
                    Position = var10:map(function(tbl3): UDim2
                        if tbl3 then
                            return UDim2.fromOffset(tbl3.rect.Min.X, tbl3.rect.Min.Y)
                        end

                        return UDim2.new()
                    end),
                    Size = var10:map(function(tbl3): UDim2
                        if tbl3 then
                            return UDim2.fromOffset(tbl3.rect.Width, tbl3.rect.Height)
                        end

                        return UDim2.fromScale(1, 1)
                    end),
                    backgroundStyle = { Transparency = 1 },
                    tag = "clip"
                }, {
                    Host = React.createElement(Foundation.View, {
                        ref = ref,
                        Position = var10:map(function(tbl3): UDim2
                            if tbl3 then
                                return UDim2.fromOffset(-tbl3.rect.Min.X, -tbl3.rect.Min.Y)
                            end

                            return UDim2.new()
                        end),
                        Size = var10:map(function(tbl3): UDim2
                            if tbl3 then
                                return UDim2.fromOffset(tbl3.areaSize.X, tbl3.areaSize.Y)
                            end

                            return UDim2.fromScale(1, 1)
                        end),
                        backgroundStyle = { Transparency = 1 },
                        testId = "Library.ChatOverlay"
                    })
                })
            }),
            var1
        )
    end

    tbl2.Inset = portal

    tbl2.Sheet = if gui == nil then nil else React.createElement(Foundation.OverlayProvider, { gui = gui }, var19)
    return createElement(fragment, var20, tbl2)
end

return LibraryChatSheetOverlay
