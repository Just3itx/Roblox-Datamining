-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:11:08Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local _ColorMode = require(Foundation.Enums.ColorMode)
local Device = require(Foundation.Enums.Device)
local Flags = require(Foundation.Utility.Flags)
local FontName = require(Foundation.Enums.FontName)
local ThemeName = require(Foundation.Enums.ThemeName)

local TypographyVariants = require(Foundation.Generated.StyleRules.TypographyVariants)

local tbl1 = {
    Common = function()
        return require(Foundation.Generated.StyleRules.CommonAttribute)
    end,
    Console = function()
        return require(Foundation.Generated.StyleRules.ConsoleAttribute)
    end,
    Desktop = function()
        return require(Foundation.Generated.StyleRules.DesktopAttribute)
    end
}

local tbl2 = {
    [ThemeName.CircuitRush] = {
        Dark = function()
            return require(Foundation.Generated.StyleRules.CircuitRush.DarkAttribute)
        end,
        Light = function()
            return require(Foundation.Generated.StyleRules.CircuitRush.LightAttribute)
        end
    },
    [ThemeName.Classic] = {
        Dark = function()
            return require(Foundation.Generated.StyleRules.Classic.DarkAttribute)
        end,
        Light = function()
            return require(Foundation.Generated.StyleRules.Classic.LightAttribute)
        end
    },
    [ThemeName.CosmicDust] = {
        Dark = function()
            return require(Foundation.Generated.StyleRules.CosmicDust.DarkAttribute)
        end,
        Light = function()
            return require(Foundation.Generated.StyleRules.CosmicDust.LightAttribute)
        end
    },
    [ThemeName.Default] = {
        Dark = function()
            return require(Foundation.Generated.StyleRules.Default.DarkAttribute)
        end,
        Light = function()
            return require(Foundation.Generated.StyleRules.Default.LightAttribute)
        end
    },
    [ThemeName.ElectricLime] = {
        Dark = function()
            return require(Foundation.Generated.StyleRules.ElectricLime.DarkAttribute)
        end,
        Light = function()
            return require(Foundation.Generated.StyleRules.ElectricLime.LightAttribute)
        end
    },
    [ThemeName.Halloween2026] = {
        Dark = function()
            return require(Foundation.Generated.StyleRules.Halloween2026.DarkAttribute)
        end,
        Light = function()
            return require(Foundation.Generated.StyleRules.Halloween2026.LightAttribute)
        end
    },
    [ThemeName.HyperPlum] = {
        Dark = function()
            return require(Foundation.Generated.StyleRules.HyperPlum.DarkAttribute)
        end,
        Light = function()
            return require(Foundation.Generated.StyleRules.HyperPlum.LightAttribute)
        end
    },
    [ThemeName.InfernoBlast] = {
        Dark = function()
            return require(Foundation.Generated.StyleRules.InfernoBlast.DarkAttribute)
        end,
        Light = function()
            return require(Foundation.Generated.StyleRules.InfernoBlast.LightAttribute)
        end
    },
    [ThemeName.Kids] = {
        Dark = function()
            return require(Foundation.Generated.StyleRules.Kids.DarkAttribute)
        end,
        Light = function()
            return require(Foundation.Generated.StyleRules.Kids.LightAttribute)
        end
    },
    [ThemeName.KineticEnergy] = {
        Dark = function()
            return require(Foundation.Generated.StyleRules.KineticEnergy.DarkAttribute)
        end,
        Light = function()
            return require(Foundation.Generated.StyleRules.KineticEnergy.LightAttribute)
        end
    },
    [ThemeName.LavaGlow] = {
        Dark = function()
            return require(Foundation.Generated.StyleRules.LavaGlow.DarkAttribute)
        end,
        Light = function()
            return require(Foundation.Generated.StyleRules.LavaGlow.LightAttribute)
        end
    },
    [ThemeName.NebulaDrift] = {
        Dark = function()
            return require(Foundation.Generated.StyleRules.NebulaDrift.DarkAttribute)
        end,
        Light = function()
            return require(Foundation.Generated.StyleRules.NebulaDrift.LightAttribute)
        end
    },
    [ThemeName.NitroFrost] = {
        Dark = function()
            return require(Foundation.Generated.StyleRules.NitroFrost.DarkAttribute)
        end,
        Light = function()
            return require(Foundation.Generated.StyleRules.NitroFrost.LightAttribute)
        end
    },
    [ThemeName.PixelPop] = {
        Dark = function()
            return require(Foundation.Generated.StyleRules.PixelPop.DarkAttribute)
        end,
        Light = function()
            return require(Foundation.Generated.StyleRules.PixelPop.LightAttribute)
        end
    },
    [ThemeName.PolarFreeze] = {
        Dark = function()
            return require(Foundation.Generated.StyleRules.PolarFreeze.DarkAttribute)
        end,
        Light = function()
            return require(Foundation.Generated.StyleRules.PolarFreeze.LightAttribute)
        end
    },
    [ThemeName.QuantumPulse] = {
        Dark = function()
            return require(Foundation.Generated.StyleRules.QuantumPulse.DarkAttribute)
        end,
        Light = function()
            return require(Foundation.Generated.StyleRules.QuantumPulse.LightAttribute)
        end
    },
    [ThemeName.StarBurst] = {
        Dark = function()
            return require(Foundation.Generated.StyleRules.StarBurst.DarkAttribute)
        end,
        Light = function()
            return require(Foundation.Generated.StyleRules.StarBurst.LightAttribute)
        end
    },
    [ThemeName.SuperCharge] = {
        Dark = function()
            return require(Foundation.Generated.StyleRules.SuperCharge.DarkAttribute)
        end,
        Light = function()
            return require(Foundation.Generated.StyleRules.SuperCharge.LightAttribute)
        end
    }
}

local BuilderSans = FontName.BuilderSans

local tbl3 = {
    [FontName.BuilderSans] = {
        Desktop = function()
            return require(Foundation.Generated.StyleRules.Typography.BuilderSans.DesktopAttribute)
        end,
        Console = function()
            return require(Foundation.Generated.StyleRules.Typography.BuilderSans.ConsoleAttribute)
        end
    },
    [FontName.Cartoon] = {
        Desktop = function()
            return require(Foundation.Generated.StyleRules.Typography.Cartoon.DesktopAttribute)
        end,
        Console = function()
            return require(Foundation.Generated.StyleRules.Typography.Cartoon.ConsoleAttribute)
        end
    }
}

local tbl4 = {
    [FontName.BuilderSans] = {
        Desktop = function()
            return require(Foundation.Generated.StyleRules.Legacy.Typography.BuilderSans.DesktopAttribute)
        end,
        Console = function()
            return require(Foundation.Generated.StyleRules.Legacy.Typography.BuilderSans.ConsoleAttribute)
        end
    },
    [FontName.Cartoon] = {
        Desktop = function()
            return require(Foundation.Generated.StyleRules.Legacy.Typography.Cartoon.DesktopAttribute)
        end,
        Console = function()
            return require(Foundation.Generated.StyleRules.Legacy.Typography.Cartoon.ConsoleAttribute)
        end
    }
}

local function getGeneratedRules(arg1, arg2, console)
    local var1 = arg1 or ThemeName.Default

    local var2 = tbl1.Common()
    local var3 = (tbl2[var1] or tbl2[ThemeName.Default])[arg2]()
    local var4 = if console == Device.Console and not Flags.FoundationDisableTokenScaling then tbl1[Device.Console]() else tbl1[Device.Desktop]()

    if not (var3 and var4 and var2) then
        return {}
    end

    local var5 = table.clone(var4)

    for value, value2 in var2 do
        var5[value] = value2
    end

    for value, value2 in var3 do
        var5[value] = value2
    end
    local var6 = TypographyVariants[var1] or BuilderSans

    local var7 = (if Flags.FoundationFontFaceMigration then tbl3[var6] or tbl3[BuilderSans] else tbl4[var6] or tbl4[BuilderSans])[if console == Device.Console and not Flags.FoundationDisableTokenScaling then Device.Console else Device.Desktop]

    if var7 then
        local var8 = var7()
        if var8 then
            for value, value2 in var8 do
                var5[value] = value2
            end
        end
    end

    return var5
end

return getGeneratedRules
