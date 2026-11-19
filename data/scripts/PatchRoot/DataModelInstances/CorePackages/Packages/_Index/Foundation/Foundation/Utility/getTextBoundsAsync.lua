-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:20:40Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local _Types = require(Foundation.Components.Types)
local normalizeFontFace = require(Foundation.Utility.normalizeFontFace)
local TextService = require(Foundation.Utility.Wrappers.Services).TextService

local function getTextBoundsAsync(getTextBoundsParamsText: string, arg1, getTextBoundsParamsSize: number, width: number?)
    local font = normalizeFontFace(arg1)
    if typeof(font) ~= "Font" then
        return nil
    end

    local getTextBoundsParams = Instance.new("GetTextBoundsParams")
    getTextBoundsParams.Text = getTextBoundsParamsText
    getTextBoundsParams.Font = font
    getTextBoundsParams.Size = getTextBoundsParamsSize
    getTextBoundsParams.Width = width or math.huge

    local success, result = pcall(function()
        return TextService:GetTextBoundsAsync(getTextBoundsParams)
    end)
    getTextBoundsParams:Destroy()

    return if success then result else nil
end

return getTextBoundsAsync
