-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:51:36Z
-- Luau bytecode version: 14 | Luau type version: 3
local SduiCoreSystemParent = script:FindFirstAncestor("SduiCoreSystem").Parent
local t = require(SduiCoreSystemParent.t)

local var1 = t.union(t.literal("Touch"), t.literal("Pointer"), t.literal("Directional"))
local var2 = t.interface({
    imageQualityLevel = t.optional(t.string),
    isPortrait = t.optional(t.boolean),
    isSpatial = t.optional(t.boolean),
    lastInput = t.optional(var1),
    maxScreenWidth = t.optional(t.number),
    minScreenWidth = t.optional(t.number),
    performanceLevel = t.optional(t.string),
    preferredInput = t.optional(var1)
})
return {
    SduiConditionKey = {
        friendInGame = "friendInGame",
        imageQualityLevel = "imageQualityLevel",
        isPortrait = "isPortrait",
        lastInput = "lastInput",
        maxScreenWidth = "maxScreenWidth",
        minScreenWidth = "minScreenWidth",
        performanceLevel = "performanceLevel",
        preferredInput = "preferredInput",
        isSpatial = "isSpatial"
    },
    SduiResponsiveKey = {
        imageQualityLevel = "imageQualityLevel",
        isPortrait = "isPortrait",
        lastInput = "lastInput",
        maxScreenWidth = "maxScreenWidth",
        minScreenWidth = "minScreenWidth",
        performanceLevel = "performanceLevel",
        preferredInput = "preferredInput",
        isSpatial = "isSpatial"
    },
    ConditionalPropsInterface = {
        propOverrides = t.table,
        conditions = t.optional(var2)
    }
}
