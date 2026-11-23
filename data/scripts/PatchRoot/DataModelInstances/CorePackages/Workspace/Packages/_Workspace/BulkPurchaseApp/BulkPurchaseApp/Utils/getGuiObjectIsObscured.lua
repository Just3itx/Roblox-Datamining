-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local BulkPurchaseAppParent = BulkPurchaseApp.Parent
local FIntAXGuiObjectIsObscuredPadding = require(BulkPurchaseApp.Flags.FIntAXGuiObjectIsObscuredPadding)
local FFlagFixBulkPurchaseTopBarObfuscation = require(BulkPurchaseAppParent.SharedFlags).FFlagFixBulkPurchaseTopBarObfuscation

local function isTransparentImageLabel(imageLabel) -- Luacid: Inlined by compiler; 1 call site recovered
    return FFlagFixBulkPurchaseTopBarObfuscation and imageLabel:IsA("ImageLabel") and imageLabel.ImageTransparency == 1
end

local function hasDefaultTransparency(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = FFlagFixBulkPurchaseTopBarObfuscation
    return var1
        and arg1.BackgroundTransparency == 0
        and arg1:HasTag("gui-object-defaults")
        and not arg1:HasTag("x-default-transparency")
end

local function getGuiObjectIsObscuredAtPosition(arg1, num1: number, num2: number)
    for _, value in (CoreGui:GetGuiObjectsAtPosition(num1, num2)) do
        if (value:IsA("Frame") or isTransparentImageLabel(value)) and value.Active == false then
            if value.BackgroundTransparency ~= 1 and not (hasDefaultTransparency(value) or value:IsDescendantOf(arg1)) then
                return value ~= arg1
            end
        elseif not value:IsDescendantOf(arg1) then
            return value ~= arg1
        end
    end
    return false
end

local function getGuiObjectIsObscured(arg1): boolean
    local absolutePosition = arg1.AbsolutePosition
    local absoluteSize = arg1.AbsoluteSize
    local var1 = absolutePosition + absoluteSize * 0.5

    local var2 = absolutePosition + absoluteSize
    local var3 = absolutePosition + Vector2.new(absoluteSize.X, 0)
    local var4 = absolutePosition + Vector2.new(0, absoluteSize.Y)
    local var5 = absolutePosition + absoluteSize * Vector2.new(math.random(1, 9) / 10, math.random(1, 9) / 10)
    local guiObjectIsObscuredAtPosition = getGuiObjectIsObscuredAtPosition(arg1, var1.X, var1.Y)
        or getGuiObjectIsObscuredAtPosition(
            arg1,
            absolutePosition.X + FIntAXGuiObjectIsObscuredPadding,
            absolutePosition.Y + FIntAXGuiObjectIsObscuredPadding
        )
        or getGuiObjectIsObscuredAtPosition(
            arg1,
            var4.X + FIntAXGuiObjectIsObscuredPadding,
            var4.Y - FIntAXGuiObjectIsObscuredPadding
        )
        or getGuiObjectIsObscuredAtPosition(
            arg1,
            var3.X - FIntAXGuiObjectIsObscuredPadding,
            var3.Y + FIntAXGuiObjectIsObscuredPadding
        )
        or getGuiObjectIsObscuredAtPosition(
            arg1,
            var2.X - FIntAXGuiObjectIsObscuredPadding,
            var2.Y - FIntAXGuiObjectIsObscuredPadding
        )
    guiObjectIsObscuredAtPosition = guiObjectIsObscuredAtPosition or getGuiObjectIsObscuredAtPosition(arg1, math.floor(var5.X), math.floor(var5.Y))
    return guiObjectIsObscuredAtPosition
end
return getGuiObjectIsObscured
