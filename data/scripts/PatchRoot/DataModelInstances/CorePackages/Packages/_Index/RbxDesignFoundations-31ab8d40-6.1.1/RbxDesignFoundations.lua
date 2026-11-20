-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Default = require(script.Default)
local enums = require(script.enums)
local _types = require(script.types)

return {
    ColorMode = enums.ColorMode,
    Theme = enums.Theme,
    themes = {
        CircuitRush = function()
            return require(script.CircuitRush)
        end,
        Classic = function()
            return require(script.Classic)
        end,
        CosmicDust = function()
            return require(script.CosmicDust)
        end,
        Default = function()
            return Default
        end,
        ElectricLime = function()
            return require(script.ElectricLime)
        end,
        Halloween2026 = function()
            return require(script.Halloween2026)
        end,
        HyperPlum = function()
            return require(script.HyperPlum)
        end,
        InfernoBlast = function()
            return require(script.InfernoBlast)
        end,
        Kids = function()
            return require(script.Kids)
        end,
        KineticEnergy = function()
            return require(script.KineticEnergy)
        end,
        LavaGlow = function()
            return require(script.LavaGlow)
        end,
        NebulaDrift = function()
            return require(script.NebulaDrift)
        end,
        NitroFrost = function()
            return require(script.NitroFrost)
        end,
        PixelPop = function()
            return require(script.PixelPop)
        end,
        PolarFreeze = function()
            return require(script.PolarFreeze)
        end,
        QuantumPulse = function()
            return require(script.QuantumPulse)
        end,
        StarBurst = function()
            return require(script.StarBurst)
        end,
        SuperCharge = function()
            return require(script.SuperCharge)
        end
    }
}
