-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Types = require(script.Parent.Parent.Parent.Types)
local _SystemTypes = require(script.Parent.SystemTypes)
local unpackContent = require(script.Parent.Parent.unpackContent)

local module = {}

function module.fromSystem(text: string, iconName: string?)
    return {
        system = { text = text, iconName = iconName }
    }
end

function module.getDetail(arg1)
    return arg1.system
end

function module.isSystemMessage(tbl1): boolean
    local content = tbl1.contents[1]
    return not (content == nil) and unpackContent(content) == "system"
end

return module
