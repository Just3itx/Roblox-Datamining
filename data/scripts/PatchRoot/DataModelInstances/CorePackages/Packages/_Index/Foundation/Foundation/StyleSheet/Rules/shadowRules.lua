-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:10:33Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local ShadowPreset = require(Foundation.Enums.ShadowPreset)
local _Tokens = require(Foundation.Providers.Style.Tokens)
local _Types = require(script.Parent.Types)

local tbl1 = {
    {
        name = ShadowPreset.Raised100,
        layers = {
            { blur = "100", spread = "0" },
            { blur = "500", spread = "0" }
        }
    },
    {
        name = ShadowPreset.Raised300,
        layers = {
            { blur = "100", spread = "0" },
            { blur = "500", spread = "0" },
            { blur = "800", spread = "0" },
            { blur = "1400", spread = "0" }
        }
    },
    {
        name = ShadowPreset.Overlay100,
        layers = {
            { offsetY = "50", blur = "100", spread = "-0.5" },
            { offsetY = "250", blur = "500", spread = "-0.75" }
        }
    },
    {
        name = ShadowPreset.Overlay300,
        layers = {
            { offsetY = "50", blur = "100", spread = "-0.5" },
            { offsetY = "250", blur = "500", spread = "-0.75" },
            { offsetY = "400", blur = "800", spread = "-1" },
            { offsetY = "1200", blur = "1400", spread = "-1.5" }
        }
    }
}

local function sizeTokenField(str1: string): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return `Size_{str1}`
end

local function shadowAttributeName(str1: string, str2: string): string -- Luacid: unused: defined but never referenced
    return `Shadow{str1}Size{str2}`
end

local function layerRule(tag: string, tbl2, num1: number, size, color3: Color3)
    local name = `ShadowBlurSize{tbl2.blur}`

    local num2 = math.floor(tonumber(tbl2.spread))

    local properties = {
        BlurRadius = "$" .. name,
        Color = color3,
        Transparency = 0.92,
        Spread = UDim2.fromOffset(num2, num2),
        ZIndex = -num1
    }

    local attributes = {{
        name = name,
        value = UDim.new(0, size[sizeTokenField(tbl2.blur)])
    }}

    if tbl2.offsetY ~= nil then
        local str1 = `ShadowOffsetSize{tbl2.offsetY}`
        properties.Offset = "$" .. str1
        table.insert(attributes, { name = str1, value = UDim2.fromOffset(0, size[sizeTokenField(tbl2.offsetY)]) })
    else
        properties.Offset = UDim2.new()
    end

    return {
        tag = tag,
        pseudo = "UIShadow",
        pseudoName = `{tag}-{num1}`,
        properties = properties,
        attributes = attributes
    }
end

local function shadowRules(arg1)
    local size = arg1.Size

    local color3 = arg1.Color.Common.Shadow.Color3
    local result = {}

    for _, value in tbl1 do
        local str1 = `shadow-{value.name}`
        local layers = value.layers

        local tbl2 = layerRule(str1, layers[1], 1, size, color3)

        if #layers > 1 then
            local children = {}
            for i = 2, #layers do
                table.insert(children, (layerRule(str1, layers[i], i, size, color3)))
            end
            tbl2.children = children
        end

        table.insert(result, tbl2)
    end

    return result
end

return shadowRules
