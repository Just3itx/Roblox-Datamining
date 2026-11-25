-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Enum = {
    XSmall = "XSmall",
    Small = "Small",
    Medium = "Medium",
    Large = "Large",
    XLarge = "XLarge",
    X2Large = "X2Large",
    Landscape = "Landscape",
    Portrait = "Portrait"
}

local sizesMinMax = {
    [Enum.XSmall] = {
        Key = Enum.XSmall,
        size = Enum.XSmall,
        minWidth = 320,
        maxWidth = 360
    },
    [Enum.Small] = {
        Key = Enum.Small,
        size = Enum.Small,
        minWidth = 361,
        maxWidth = 600
    },
    [Enum.Medium] = {
        Key = Enum.Medium,
        size = Enum.Medium,
        minWidth = 601,
        maxWidth = 1140
    },
    [Enum.Large] = {
        Key = Enum.Large,
        size = Enum.Large,
        minWidth = 1141,
        maxWidth = 1520
    },
    [Enum.XLarge] = {
        Key = Enum.XLarge,
        size = Enum.XLarge,
        minWidth = 1521,
        maxWidth = 1920
    },
    [Enum.X2Large] = {
        Key = Enum.X2Large,
        size = Enum.X2Large,
        minWidth = 1920,
        maxWidth = 4096
    }
}
local sizes = {
    [Enum.XSmall] = {
        Key = Enum.XSmall,
        size = Enum.XSmall,
        maxWidth = 360
    },
    [Enum.Small] = {
        Key = Enum.Small,
        size = Enum.Small,
        maxWidth = 600
    },
    [Enum.Medium] = {
        Key = Enum.Medium,
        size = Enum.Medium,
        maxWidth = 1140
    },
    [Enum.Large] = {
        Key = Enum.Large,
        size = Enum.Large,
        maxWidth = 1520
    },
    [Enum.XLarge] = {
        Key = Enum.XLarge,
        size = Enum.XLarge,
        maxWidth = 1920
    },
    [Enum.X2Large] = {
        Key = Enum.X2Large,
        size = Enum.X2Large,
        maxWidth = 4096
    }
}
local sizesMinMaxY = {
    [Enum.XSmall] = {
        Key = Enum.XSmall,
        size = Enum.XSmall,
        minHeight = 320,
        maxHeight = 360
    },
    [Enum.Small] = {
        Key = Enum.Small,
        size = Enum.Small,
        minHeight = 361,
        maxHeight = 600
    },
    [Enum.Medium] = {
        Key = Enum.Medium,
        size = Enum.Medium,
        minHeight = 601,
        maxHeight = 1140
    },
    [Enum.Large] = {
        Key = Enum.Large,
        size = Enum.Large,
        minHeight = 1141,
        maxHeight = 1520
    },
    [Enum.XLarge] = {
        Key = Enum.XLarge,
        size = Enum.XLarge,
        minHeight = 1521,
        maxHeight = 1920
    },
    [Enum.X2Large] = {
        Key = Enum.X2Large,
        size = Enum.X2Large,
        minHeight = 1920,
        maxHeight = 4096
    }
}
local sizesY = {
    [Enum.XSmall] = {
        Key = Enum.XSmall,
        size = Enum.XSmall,
        maxHeight = 360
    },
    [Enum.Small] = {
        Key = Enum.Small,
        size = Enum.Small,
        maxHeight = 600
    },
    [Enum.Medium] = {
        Key = Enum.Medium,
        size = Enum.Medium,
        maxHeight = 1140
    },
    [Enum.Large] = {
        Key = Enum.Large,
        size = Enum.Large,
        maxHeight = 1520
    },
    [Enum.XLarge] = {
        Key = Enum.XLarge,
        size = Enum.XLarge,
        maxHeight = 1920
    },
    [Enum.X2Large] = {
        Key = Enum.X2Large,
        size = Enum.X2Large,
        maxHeight = 4096
    }
}
local tbl6 = {
    {
        Key = Enum.Landscape,
        minRatio = 1
    },
    {
        Key = Enum.Portrait,
        minRatio = 0
    }
}

local default = {
    sizes[Enum.XSmall],
    sizes[Enum.Small],
    sizes[Enum.Medium],
    sizes[Enum.Large],
    sizes[Enum.XLarge],
    sizes[Enum.X2Large]
}

local tbl8 = {
    sizesY[Enum.XSmall],
    sizesY[Enum.Small],
    sizesY[Enum.Medium],
    sizesY[Enum.Large],
    sizesY[Enum.XLarge],
    sizesY[Enum.X2Large]
}

local keyIndex = {}
for value, value2 in default do
    keyIndex[value2.Key] = value
end

return {
    Enum = Enum,
    sizes = sizes,
    sizesMinMax = sizesMinMax,
    sizesY = sizesY,
    sizesMinMaxY = sizesMinMaxY,
    rules = { default = default, Y = tbl8, Orientation = tbl6 },
    keyIndex = keyIndex,
    getMinWidthFor = function(arg1)
        local var1 = sizesMinMax[arg1]
        return if var1 == nil then 0 else var1.minWidth
    end,
    getMinHeightFor = function(arg1)
        local var1 = sizesMinMaxY[arg1]
        return if var1 == nil then 0 else var1.minHeight
    end
}
