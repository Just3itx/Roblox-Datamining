-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local dependencies = require(script.dependencies)
local scriptParentParentParent = script.Parent.Parent.Parent

local GetTokenGenerators = dependencies.GetTokenGenerators
local GetFoundationTokens = dependencies.GetFoundationTokens

local UIBloxConfig = require(scriptParentParentParent.UIBloxConfig)
local Types = require(script.Types)
local Constants = require(script.Parent.Constants)

local function getPlatformScale(console, num1: number?) -- Luacid: Inlined by compiler; 2 call sites recovered
    if UIBloxConfig.disableTokenScaling then
        return 1
    end

    num1 = math.clamp(if num1 == nil then 1 else num1, 0, math.huge)

    return (if console == Constants.DeviceType.Console then 1.5 else 1) * num1
end

return {
    getTokens = function(console, arg1, num1: number?)
        local tokenGenerators = GetTokenGenerators(arg1) or GetTokenGenerators(Constants.DefaultThemeName)
        local platformScale = getPlatformScale(console, num1)
        return {
            Global = tokenGenerators.Global(platformScale),
            Semantic = tokenGenerators.Semantic(platformScale),
            Component = tokenGenerators.Component(platformScale)
        }
    end,
    Types = Types,
    getFoundationTokens = function(console, arg1, num1: number?)
        return (GetFoundationTokens(arg1) or GetFoundationTokens(Constants.DefaultThemeName))((getPlatformScale(console, num1)))
    end,
    getFoundationTokensDefaultScale = function(arg1)
        return (GetFoundationTokens(arg1) or GetFoundationTokens(Constants.DefaultThemeName))(1)
    end,
    Mappers = require(script.mappers)
}
