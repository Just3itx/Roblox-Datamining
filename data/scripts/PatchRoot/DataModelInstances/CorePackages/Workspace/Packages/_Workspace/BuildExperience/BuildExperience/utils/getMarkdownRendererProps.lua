-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local _Foundation = require(BuildExperienceParent.Foundation)

local font = Font.new("rbxasset://fonts/families/BuilderMono.json", Enum.FontWeight.Regular)

local function colorToHex(arg1): string -- Luacid: Inlined by compiler; 3 call sites recovered
    return `#{arg1.Color3:ToHex()}`
end

local function typographyToTextStyles(arg1, arg2)
    local font2 = arg1.Font
    local tbl1 = {
        textSize = arg1.FontSize,
        color = colorToHex(arg2),
        transparency = arg2.Transparency
    }
    if typeof(font2) == "EnumItem" then
        tbl1.font = font2
        return tbl1
    elseif typeof(font2) == "Font" then
        tbl1.fontFace = font2
        return tbl1
    else
        if typeof(font2) == "table" then
            tbl1.fontFace = Font.new(font2.Family, font2.Weight, font2.Style)
        end

        return tbl1
    end
end

local function getTextSize(bodyMedium) -- Luacid: Inlined by compiler; 1 call site recovered
    return bodyMedium.FontSize
end

local function getLineHeight(bodyMedium) -- Luacid: Inlined by compiler; 1 call site recovered
    return bodyMedium.LineHeight
end

local function getColor3(surface300) -- Luacid: Inlined by compiler; 1 call site recovered
    return surface300.Color3
end

local function getTransparency(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1.Transparency
end

local function getSize(num1: number): number -- Luacid: unused: defined but never referenced
    return num1
end

local function getMarkdownRendererProps(arg1, arg2)
    local typography = arg1.Typography
    local content = arg1.Color.Content
    local surface = arg1.DarkMode.Surface
    return {
        textStyles = typographyToTextStyles(typography.BodyMedium, arg2),
        headerStyles = {
            typographyToTextStyles(typography.HeadingLarge, content.Emphasis),
            typographyToTextStyles(typography.HeadingMedium, content.Emphasis),
            typographyToTextStyles(typography.HeadingSmall, content.Emphasis),
            typographyToTextStyles(typography.TitleLarge, content.Emphasis),
            typographyToTextStyles(typography.TitleMedium, content.Emphasis),
            (typographyToTextStyles(typography.TitleMedium, content.Emphasis))
        },
        codeStyles = {
            fontFace = font,
            textSize = getTextSize(typography.BodyMedium),
            lineHeight = getLineHeight(typography.BodyMedium),
            color = colorToHex(content.Emphasis),
            transparency = getTransparency(content.Emphasis)
        },
        codeBackgroundStyles = {
            backgroundColor3 = getColor3(surface.Surface_300),
            backgroundTransparency = getTransparency(surface.Surface_300)
        },
        linkStyles = {
            linkColor = colorToHex(content.Link)
        },
        imageStyles = {
            size = UDim2.fromOffset(arg1.Size.Size_400, arg1.Size.Size_400)
        }
    }
end

return getMarkdownRendererProps
