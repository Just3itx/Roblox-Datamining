-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local inspect = require(scriptParentParent.jsutils.inspect).inspect
local devAssert = require(scriptParentParent.jsutils.devAssert).devAssert
local instanceOf = require(scriptParentParent.jsutils.instanceOf)

local Source = ({})
Source.__index = Source

function Source.new(body: string, name: string?, locationOffset)
    devAssert(typeof(body) == "string", "Body must be a string. Received: " .. inspect(body) .. ".")
    local tbl2 = {
        body = body,
        name = name or "GraphQL request",
        locationOffset = locationOffset or { line = 1, column = 1 }
    }
    devAssert(tbl2.locationOffset.line > 0, "line in locationOffset is 1-indexed and must be positive.")

    devAssert(tbl2.locationOffset.column > 0, "column in locationOffset is 1-indexed and must be positive.")

    return (setmetatable(tbl2, Source))
end

function Source.__tostring(_): string
    return "{table Source}"
end

function isSource(arg1)
    return instanceOf(arg1, Source)
end

return {
    Source = Source,
    isSource = isSource
}
