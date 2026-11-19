-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:21:05Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local ReactIs = require(FoundationParent.ReactIs)

local _Types = require(Foundation.Components.Types)

local function normalizeFontFace(font)
    if typeof(font) == "table" then
        if ReactIs.isBinding(font) then
            return font
        end

        return Font.new(font.Family, font.Weight, font.Style)
    elseif typeof(font) == "EnumItem" then
        if font == Enum.Font.Unknown then
            return nil
        end
        return Font.fromEnum(font)
    else
        return font
    end
end
return normalizeFontFace
