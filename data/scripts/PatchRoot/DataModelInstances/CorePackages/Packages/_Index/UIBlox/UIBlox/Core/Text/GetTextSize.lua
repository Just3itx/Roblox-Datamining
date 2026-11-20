-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextService = game:GetService("TextService")

local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local normalizeFontFace = require(scriptParentParentParentParent.Foundation).Utility.normalizeFontFace
local Logger = require(scriptParentParentParent.Logger)
local GetLegacyFont = require(script.Parent.GetLegacyFont)

local vector2 = Vector2.new(2, 2)

local function getTextSize(string: string, fontSize: number, arg1, vector2_2: Vector2, richText: boolean?)
    local success, result, result2 = pcall(function()
        if richText then
            local getTextBoundsParams = Instance.new("GetTextBoundsParams")
            getTextBoundsParams.Font = normalizeFontFace(arg1)
            getTextBoundsParams.Size = fontSize
            getTextBoundsParams.Text = string
            getTextBoundsParams.Width = vector2_2.X
            getTextBoundsParams.RichText = richText or false

            return TextService:GetTextBoundsAsync(getTextBoundsParams), false
        end

        local font, var1 = GetLegacyFont(arg1)
        if font == nil then
            return nil, var1
        end
        local var2 = var1 and font == Enum.Font.Cartoon

        local vector22X = vector2_2.X

        if vector22X > 0 and vector22X < math.huge then
            if var2 then
                vector22X /= 1.01
            end
        else
            vector22X = math.huge
        end

        local vector2_3 = Vector2.new(vector22X, math.huge)
        return TextService:GetTextSize(string, fontSize, font, vector2_3), var2
    end)
    if success and result then
        local var1 = Vector2.new(result.X, math.min(result.Y, vector2_2.Y))
        if result2 then
            local x = math.ceil(var1.X * 1.01)
            if vector2_2.X > 0 and vector2_2.X < math.huge then
                x = math.min(x, vector2_2.X)
            end
            var1 = Vector2.new(x, var1.Y)
        end

        return var1 + vector2
    elseif success then
        Logger:warning("Font cannot be measured, falling back to frame size")
        return vector2_2
    else
        Logger:warning(`Text measurement failed, falling back to frame size. Error: {result}`)
        return vector2_2
    end
end

return getTextSize
