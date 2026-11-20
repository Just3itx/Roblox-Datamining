-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecycler").Flags).FFlagViewRecyclerReact084
local EventKind = table.freeze({
    RangeChanged = "rangeChanged",
    PoolChanged = "poolChanged",
    ItemViewsSynchronized = "itemViewsSynchronized",
    MeasurementsProcessingStarted = "measurementsProcessingStarted",
    MeasurementsProcessed = "measurementsProcessed",
    ScrollCorrection = "scrollCorrection"
})

local RangeKind = table.freeze({ Visible = "visible", Rendered = "rendered" })

local PoolAction = table.freeze({ Create = "create", Acquire = "acquire", Release = "release", Evict = "evict" })

local ScrollCorrectionSource = table.freeze({
    Data = "data",
    Measurement = "measurement",
    ProgrammaticScroll = "programmaticScroll",
    Policy = if FFlagViewRecyclerReact084 then "policy" else nil
})

return table.freeze({
    EventKind = EventKind,
    PoolAction = PoolAction,
    RangeKind = RangeKind,
    ScrollCorrectionSource = ScrollCorrectionSource
})
