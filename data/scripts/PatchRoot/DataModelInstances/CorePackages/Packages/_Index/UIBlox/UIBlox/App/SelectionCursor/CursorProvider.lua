-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")

local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Cryo = require(scriptParentParentParentParent.Cryo)
local React = require(scriptParentParentParentParent.React)
local RoactGamepad = require(scriptParentParentParentParent.RoactGamepad)
local useStyle = require(scriptParentParentParent.Core.Style.useStyle)

local CursorContext = require(script.Parent.CursorContext)
local CursorComponent = require(script.Parent.CursorComponent)
local CursorType = require(script.Parent.CursorType)

local function func1(uDim: UDim, num1: number, num2: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    return string.format("%f %f %f %f", uDim.Scale, uDim.Offset, num1, num2)
end

local function func2(str1: string)
    local huge = math.huge
    local huge2 = math.huge
    local huge3 = math.huge
    local huge4 = math.huge

    for value, value2 in string.split(str1, " ") do
        local var1 = tonumber(value2)
        if var1 == nil then
            continue
        end

        if value == 1 then
            huge = var1
        elseif value == 2 then
            huge2 = var1
        elseif value == 3 then
            huge3 = var1
        elseif value == 4 then
            huge4 = var1
        end
    end

    assert(
        not (huge == math.huge or huge2 == math.huge or huge3 == math.huge) and huge4 ~= math.huge,
        "Error! Not all parameters are decoded."
    )

    return UDim.new(huge, math.max(0, huge2 + huge3)), huge3, huge4
end

return function(tbl1)
    local var1, var2 = React.useState({})
    local var3, var4 = React.useState({})
    local ref = React.createRef()
    local var5, var6 = React.useState(nil)
    local var7 = RoactGamepad.useRefCache()
    local tokens = useStyle().Tokens

    local function getCursor(uDim: UDim?, num1: number?, num2: number?)
        warn("UIBlox's SelectionCursor is deprecated and should not be used anymore.")

        local uDim2 = UDim.new(0, 0)
        if uDim ~= nil then
            uDim2 = uDim
        end

        if num2 ~= nil then
            assert(num2 > 0, "Error! borderWidth should be larger than 0.")
        else
            num2 = tokens.Stroke.Thick
        end

        local var8 = if num1 ~= nil then num1 - num2 else tokens.Size.Size_150 - num2
        local str1 = func1(uDim2, var8, num2)

        if var1[str1] == nil then
            var2(Cryo.Dictionary.join(var1, { [str1] = true }))
        end

        return var7[str1]
    end

    local function getCursorByType(arg1)
        local var8 = CursorType.isEnumValue(arg1)
        local str1 = tostring(arg1)
        assert(var8, ("Error! expected a CursorType enum, got %s"):format(str1))

        warn("UIBlox's SelectionCursor is deprecated and should not be used anymore.")

        if var3[arg1] == nil then
            var4(Cryo.Dictionary.join(var3, { [arg1] = true }))
        end

        return var7[arg1]
    end

    local function func5()
        local result = ({})

        for k, _ in pairs(var1) do
            local isVisible = not (var7[k] == nil or var5 == nil) and var7[k].current == var5
            local cornerRadius, offset, borderWidth = func2(k)

            local createElement = React.createElement
            local var9 = CursorComponent
            local tbl2 = {
                ref = var7[k],
                isVisible = isVisible,
                cornerRadius = cornerRadius,
                offset = offset,
                borderWidth = borderWidth
            }
            result[k] = createElement(var9, tbl2)
        end

        for k, _ in pairs(var3) do
            local var8 = k.rawValue()
            local isVisible = not (var7[k] == nil or var5 == nil) and var7[k].current == var5
            local createElement = React.createElement
            local tbl2 = {
                ref = var7[k],
                isVisible = isVisible
            }
            result[k] = createElement(var8, tbl2)
        end

        return result
    end

    React.useEffect(function()
        if ref.current == nil or not ref.current:IsDescendantOf(game) then
            return
        end

        local isDescendantOf = ref.current:IsDescendantOf(CoreGui)

        local function setUpSelectionImageObjectConnection()
            if isDescendantOf then
                return GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function()
                    if GuiService.SelectedCoreObject == nil then
                        var6(nil)
                        return
                    end
                    var6(GuiService.SelectedCoreObject.SelectionImageObject)
                end)
            end

            return GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(function()
                if GuiService.SelectedObject == nil then
                    var6(nil)
                    return
                end
                var6(GuiService.SelectedObject.SelectionImageObject)
            end)
        end

        local connection = setUpSelectionImageObjectConnection()
        local connection2 = ref.current.AncestryChanged:Connect(function()
            connection:Disconnect()
            connection = setUpSelectionImageObjectConnection()
        end)

        return function()
            connection:Disconnect()
            connection2:Disconnect()
        end
    end, {})

    return React.createElement(
        CursorContext.Provider,
        {
            value = { getCursor = getCursor, getCursorByType = getCursorByType }
        },
        Cryo.Dictionary.join({
            InvisibleContainer = React.createElement("Frame", { Size = UDim2.new(0, 0, 0, 0), Visible = false, ref = ref }, (func5()))
        }, tbl1.children)
    )
end
