-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local TextService = game:GetService("TextService")
local Players = game:GetService("Players")
local _CoreGui = game:GetService("CoreGui")
local LocalizationService = game:GetService("LocalizationService")

local PlatformService = nil
pcall(function()
    PlatformService = game:GetService("PlatformService")
end)
local module = {}

function module.IsFinite(arg1): boolean
    return arg1 == arg1 and arg1 ~= math.huge and arg1 ~= -math.huge
end

function module.FindAncestorOfType(arg1, arg2)
    local parent = arg1 and arg1.Parent
    if parent then
        if parent:IsA(arg2) then
            return parent
        end
        return module.FindAncestorOfType(parent, arg2)
    end

    return nil
end

function module.CalculateRelativeDimensions(arg1, arg2, arg3, _)
    local vector2 = GuiService:GetScreenResolution()
    local ancestorOfType = module.FindAncestorOfType(arg1, "SurfaceGui")
    if ancestorOfType then
        vector2 = ancestorOfType.CanvasSize
    end
    local var1 = arg2 / arg3
    if arg3.y > 0 and vector2.y > 0 then
        var1 *= arg3.x / arg3.y / (vector2.x / vector2.y)
        local parent = arg1.Parent
        if parent then
            local var2 = 1 / (parent.AbsoluteSize / vector2)
            if module.IsFinite(var2.x) and module.IsFinite(var2.y) then
                return UDim2.new(var2.x * var1.x, 0, var2.y * var1.y, 0)
            end
        end
    end
    return UDim2.new(var1.x, 0, var1.y, 0)
end

module.Enum = {
    Anchor = {
        TopLeft = 1,
        TopMiddle = 2,
        TopRight = 3,
        CenterLeft = 4,
        Center = 5,
        CenterRight = 6,
        BottomLeft = 7,
        BottomMiddle = 8,
        BottomRight = 9
    }
}

function module.CalculateFit(arg1, arg2): UDim2
    local var1 = arg1.AbsoluteSize / arg2
    local var2 = arg2 * math.min(var1.X, var1.Y)

    return UDim2.new(0, var2.X, 0, var2.Y)
end

function module.CalculateFill(arg1, arg2): UDim2
    local var1 = arg1.AbsoluteSize / arg2
    local var2 = arg2 * math.max(var1.X, var1.Y)

    return UDim2.new(0, var2.X, 0, var2.Y)
end

local tbl1 = ({})

local function getActiveTween(arg1, arg2) -- Luacid: Inlined by compiler; 6 call sites recovered
    return tbl1[arg1] and tbl1[arg1][arg2]
end

local function setActiveTween(arg1, arg2, arg3) -- Luacid: Inlined by compiler; 4 call sites recovered
    if not tbl1[arg1] then
        tbl1[arg1] = {}
    end
    tbl1[arg1][arg2] = arg3
end

function module.Linear(arg1, arg2, arg3, arg4)
    if arg4 <= arg1 then
        return arg2 + arg3
    end

    return arg3 * arg1 / arg4 + arg2
end

function module.EaseOutQuad(arg1, arg2, arg3, arg4)
    if arg4 <= arg1 then
        return arg2 + arg3
    end
    arg1 /= arg4
    return -arg3 * arg1 * (arg1 - 2) + arg2
end

function module.EaseInOutQuad(arg1, arg2, arg3, arg4)
    if arg4 <= arg1 then
        return arg2 + arg3
    end
    arg1 /= arg4 / 2
    if arg1 < 1 then
        return arg3 / 2 * arg1 * arg1 + arg2
    end

    arg1 -= 1
    return -arg3 / 2 * (arg1 * (arg1 - 2) - 1) + arg2
end

function module.SCurveUDim2(arg1, arg2, arg3, arg4)
    if arg4 <= arg1 then
        return arg2 + arg3
    end

    arg1 /= arg4
    arg1 = if arg1 < 0 then 0 else arg1
    arg1 = if arg1 > 1 then 1 else arg1
    local var1 = 3 * arg1 * arg1 - 2 * arg1 * arg1 * arg1
    return UDim2.new(var1 * arg3.X.Scale, var1 * arg3.X.Offset, var1 * arg3.Y.Scale, var1 * arg3.Y.Offset) + arg2
end

function module.SCurveVector2(arg1, arg2, arg3, arg4)
    if arg4 <= arg1 then
        return arg2 + arg3
    end

    arg1 /= arg4
    arg1 = if arg1 < 0 then 0 else arg1
    arg1 = if arg1 > 1 then 1 else arg1
    local var1 = 3 * arg1 * arg1 - 2 * arg1 * arg1 * arg1
    return Vector2.new(var1 * arg3.X, var1 * arg3.Y) + arg2
end

function module.PropertyTweener(arg1, arg2, arg3, final, arg5, arg6, arg7, callback)
    local var1 = arg6 or module.Linear

    local module2 = {
        StartTime = tick()
    }
    module2.EndTime = module2.StartTime + arg5
    module2.Cancelled = false

    local isFinished = false
    local percentComplete = 0

    local function setValue(arg8) -- Luacid: Inlined by compiler; 3 call sites recovered
        if arg1 then
            arg1[arg2] = arg8
        end
    end

    local function finalize()
        setValue((var1(1, arg3, final - arg3, 1)))
        isFinished = true
        percentComplete = 1

        if getActiveTween(arg2, arg1) == module2 then
            setActiveTween(arg2, arg1, nil)
        end

        if callback then
            callback()
        end
    end

    if arg7 or not getActiveTween(arg2, arg1) then
        if getActiveTween(arg2, arg1) then
            getActiveTween(arg2, arg1):Cancel()
        end

        setActiveTween(arg2, arg1, module2)
        setValue((var1(0, arg3, final - arg3, arg5)))
        spawn(function()
            local var2 = tick()
            while var2 < module2.EndTime and arg1 and not module2.Cancelled do
                setValue((var1(var2 - module2.StartTime, arg3, final - arg3, arg5)))
                percentComplete = module.Clamp(0, 1, (var2 - module2.StartTime) / arg5)
                RunService.RenderStepped:wait()
                var2 = tick()
            end
            if module2.Cancelled == false and arg1 then
                finalize()
            end

            if getActiveTween(arg2, arg1) == module2 then
                setActiveTween(arg2, arg1, nil)
            end
        end)
    else
        isFinished = true
    end

    function module2.GetFinal(_)
        return final
    end

    function module2.GetPercentComplete(_)
        return percentComplete
    end

    function module2.IsFinished(_)
        return isFinished
    end

    function module2.Finish(arg8)
        if not isFinished then
            arg8:Cancel()
            finalize()
        end
    end

    function module2.Cancel(_)
        module2.Cancelled = true
        isFinished = true
        if getActiveTween(arg2, arg1) == module2 then
            setActiveTween(arg2, arg1, nil)
        end
    end

    return module2
end

function module.CancelTweens(arg1)
    for k, value in pairs(arg1) do
        value:Finish()
        arg1[k] = nil
    end
end

function module.Signal()
    local module2 = {}

    local bindableEvent = Instance.new("BindableEvent")

    local var1 = nil
    local var2 = nil

    function module2.fire(_, ...)
        var1 = { ... }
        local select = select
        var2 = select("#", ...)
        bindableEvent:Fire()
    end

    function module2.connect(_, callback): RBXScriptConnection
        if not callback then
            error("connect(nil)", 2)
        end

        return bindableEvent.Event:connect(function()
            callback(unpack(var1, 1, var2))
        end)
    end

    function module2.wait(_)
        bindableEvent.Event:wait()
        assert(var1, "Missing arg data, likely due to :TweenSize/Position corrupting threadrefs.")
        return unpack(var1, 1, var2)
    end

    return module2
end

function module.DisconnectEvent(arg1)
    if arg1 then
        arg1:disconnect()
    end
    return nil
end

function module.DisconnectEvents(arg1)
    if not arg1 or type(arg1) ~= "table" then
        return
    end

    for _, value in pairs(arg1) do
        value:disconnect()
    end
end

function module.Clamp(arg1, arg2, arg3): number
    return math.max(arg1, math.min(arg2, arg3))
end

function module.ClampVector2(arg1, arg2, arg3): Vector2
    return Vector2.new(module.Clamp(arg1.x, arg2.x, arg3.x), module.Clamp(arg1.y, arg2.y, arg3.y))
end

function module.TweenPositionOrSet(arg1, ...)
    if arg1:IsDescendantOf(game) then
        arg1:TweenPositionInternal(...)
        return
    end
    local select = select
    arg1.Position = select(1, ...)
end

function module.ClampCanvasPosition(arg1, arg2): Vector2
    local var1 = arg1.Parent and arg1.Parent.AbsoluteSize or Vector2.new(0, 0)
    local vector2 = Vector2.new(
        arg1.CanvasSize.X.Scale * var1.X + arg1.CanvasSize.X.Offset,
        arg1.CanvasSize.Y.Scale * var1.Y + arg1.CanvasSize.Y.Offset
    )
    local x = module.Clamp(0, vector2.X - arg1.AbsoluteWindowSize.X, arg2.X)
    local y = module.Clamp(0, vector2.Y - arg1.AbsoluteWindowSize.Y, arg2.Y)

    return Vector2.new(x, y)
end

function module.Round(arg1, arg2)
    arg2 = arg2 or 1
    return math.floor((arg1 + arg2 / 2) / arg2) * arg2
end

function module.ChompString(arg1)
    return tostring(arg1):gsub("^%s+", ""):gsub("%s+$", "")
end

function module.SpaceNormalizeString(arg1)
    return tostring(arg1):gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
end

local function getDelimiterByLocale()
    local str1 = LocalizationService.RobloxLocaleId:lower()

    local tbl2 = {
        ["en-us"] = ",",
        ["zh-hk"] = "",
        ["zh-tw"] = "",
        ["nb-no"] = " ",
        ["es-es"] = " ",
        ["nl-nl"] = ".",
        ["it-it"] = ".",
        ["tr-tr"] = ".",
        ["ru-ru"] = " ",
        ["fi-fi"] = " ",
        ["da-dk"] = ".",
        ["de-de"] = ".",
        ["fr-fr"] = " ",
        ["pt-br"] = ".",
        ["pt-pt"] = ".",
        ["pl-pl"] = " ",
        ["sv-se"] = " "
    }

    return if tbl2[str1] then tbl2[str1] else ","
end

function module.FormatNumberString(arg1)
    local delimiterByLocale = getDelimiterByLocale()

    local var1 = module.ChompString(arg1)
    local str1 = string.format("%%1%s%%2", delimiterByLocale)

    repeat
        local var2
        var1, var2 = string.gsub(var1, "^(-?%d+)(%d%d%d)", str1)
    until var2 == 0

    return var1
end

function module.PrettyPrint(arg1)
    if type(arg1) == "table" then
        local str1 = "{"
        for k, value in pairs(arg1) do
            local str2 = str1 == "{" and str1 or str1 .. ", "
            if type(k) == "string" then
                str2 ..= k .. " = "
            elseif type(k) ~= "number" then
                str2 ..= "[" .. k .. "] = "
            end
            str1 = str2 .. module.PrettyPrint(value)
        end
        return str1 .. "}"
    elseif type(arg1) == "string" then
        return "'" .. arg1 .. "'"
    else
        return tostring(arg1)
    end
end

local function SCurveTranform(arg1, arg2, arg3) -- Luacid: Inlined by compiler; 2 call sites recovered
    arg2 = arg2 or 0.35
    arg3 = arg3 or 0.8
    arg1 = module.Clamp(-1, 1, arg1)

    if arg1 >= 0 then
        return arg2 * arg1 / (arg2 - arg1 + 1)
    end

    return -(arg3 * -arg1 / (arg3 + arg1 + 1))
end

local function toSCurveSpace(num1: number, arg1): number -- Luacid: Inlined by compiler; 2 call sites recovered
    arg1 = arg1 or 0.1
    return (1 + arg1) * (math.abs(num1) * 2 - 1) - arg1
end

local function fromSCurveSpace(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1 / 2 + 0.5
end

function module.GamepadLinearToCurve(arg1, arg2, _, _)
    local function onAxis(arg3)
        local num1 = if arg3 < 0 then -1 else 1
        local sCurveSpace = fromSCurveSpace((SCurveTranform(toSCurveSpace(math.abs(arg3), arg2), nil, nil)))
        return module.Clamp(-1, 1, sCurveSpace * num1)
    end
    local new = Vector2.new
    local x = arg1.x
    local num1 = if x < 0 then -1 else 1
    local sCurveSpace = fromSCurveSpace((SCurveTranform(toSCurveSpace(math.abs(x), arg2), nil, nil)))
    return new(module.Clamp(-1, 1, sCurveSpace * num1), onAxis(arg1.y))
end

function module.IsFastFlagEnabled(arg1)
    local success, result = pcall(function()
        return settings():GetFFlag(arg1)
    end)

    return success and result
end

function module.GetFastVariable(arg1)
    local success, result = pcall(function()
        return settings():GetFVariable(arg1)
    end)

    return success and result
end

local function getLocalPlayer(): Player -- Luacid: Inlined by compiler; 1 call site recovered
    while Players.LocalPlayer == nil do
        wait()
    end
    return Players.LocalPlayer
end

function module.IsFeatureNonZero(arg1): boolean
    return (tonumber(module.GetFastVariable(arg1)) or 0) ~= 0
end

function module.IsFeatureRolledOut(arg1): boolean
    return getLocalPlayer().UserId % 100 < (tonumber(module.GetFastVariable(arg1)) or 0)
end

function module.ExponentialRepeat(arg1, arg2, arg3)
    local num1 = 1
    local var1 = arg3 or 6

    while num1 <= var1 and arg1() do
        if arg2() then
            return
        end

        wait(num1 ^ 2)
        num1 += 1
    end
end

function module.SplitString(arg1, arg2)
    local result = {}
    if arg1 and arg2 then
        for value in string.gmatch(arg1, "([^" .. arg2 .. "]+)") do
            table.insert(result, value)
        end
    end
    return result
end

local function findAssetsHelper(arg1, arg2, arg3)
    if not arg1 then
        return
    end
    if arg1:IsA("CharacterMesh") then
        if arg1.MeshId > 0 then
            table.insert(arg2, arg3 .. tostring(arg1.MeshId))
        end
        if arg1.BaseTextureId > 0 then
            table.insert(arg2, arg3 .. tostring(arg1.BaseTextureId))
        end
        if arg1.OverlayTextureId > 0 then
            table.insert(arg2, arg3 .. tostring(arg1.OverlayTextureId))
        end
    elseif arg1:IsA("FileMesh") then
        table.insert(arg2, arg1.MeshId)
        table.insert(arg2, arg1.TextureId)
    elseif arg1:IsA("Decal") then
        table.insert(arg2, arg1.Texture)
    elseif arg1:IsA("Pants") then
        table.insert(arg2, arg1.PantsTemplate)
    elseif arg1:IsA("Shirt") then
        table.insert(arg2, arg1.ShirtTemplate)
    end

    for _, child in pairs(arg1:GetChildren()) do
        findAssetsHelper(child, arg2, arg3)
    end
end

function module.FindAssetsInModel(arg1, arg2)
    local assetsInModel = {}
    findAssetsHelper(arg1, assetsInModel, arg2 or "https://assetgame.roblox.com/asset/?id=")
    return assetsInModel
end

function module.ConvertFontSizeEnumToInt(arg1)
    local name = arg1.Name

    return string.match(name, "%d+") or 10
end

function module.Upper(arg1)
    if PlatformService then
        return PlatformService:Upper(arg1)
    end
    return string.upper(arg1)
end

function module.SetSelectedCoreObject(selectedCoreObject)
    GuiService.SelectedCoreObject = selectedCoreObject
end

function module.AddSelectionParent(selectionName: string, selectionParent: Instance)
    GuiService:AddSelectionParent(selectionName, selectionParent)
end

function module.RemoveSelectionGroup(selectionName: string)
    GuiService:RemoveSelectionGroup(selectionName)
end

function module.GetTextBounds(arg1)
    local bool1 = false
    local textSize = nil
    if arg1 then
        if arg1.TextFits then
            return true, arg1.TextBounds
        end

        if not arg1.TextWrapped then
            textSize = TextService:GetTextSize(arg1.Text, arg1.TextSize, arg1.Font, Vector2.new(0, 0))
            bool1 = true
        end
    end

    return bool1, textSize
end

function module.ResizeButtonWithText(arg1, arg2, arg3, arg4): boolean
    local bool1 = false
    local var1, var2 = module.GetTextBounds(arg2)
    if var1 and arg1.Size.X.Scale == 0 and arg1.Size.Y.Scale == 0 then
        local vector2 = Vector2.new(arg1.Size.X.Offset, arg1.Size.Y.Offset)
        local vector2X = vector2.X
        local vector2Y = vector2.Y
        if arg3 and vector2.X < var2.X + arg3 * 2 then
            vector2X = var2.X + arg3 * 2
            bool1 = true
        end

        if arg4 and vector2.Y < var2.Y + arg4 * 2 then
            vector2Y = var2.Y + arg4 * 2
            bool1 = true
        end

        if bool1 then
            arg1.Size = UDim2.new(0, vector2X, 0, vector2Y)
        end
    end

    return bool1
end

function module.ResizeButtonWithDynamicText(arg1, arg2, arg3, arg4, arg5)
    local var1 = module.ResizeButtonWithText(arg1, arg2, arg4, arg5) or false
    local text = arg2.Text
    if arg3 and #arg3 > 0 then
        for i = 1, #arg3 do
            arg2.Text = arg3[i]
            var1 = module.ResizeButtonWithText(arg1, arg2, arg4, arg5) or var1
        end
    end

    arg2.Text = text
    return var1
end

return module
