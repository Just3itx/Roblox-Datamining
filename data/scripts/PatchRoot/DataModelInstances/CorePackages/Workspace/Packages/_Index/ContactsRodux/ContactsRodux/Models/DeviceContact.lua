-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local getMockName = require(script.Parent.getMockName)
local _ContactTypes = require(script.Parent.Parent.Types.ContactTypes)
local Dash = require(scriptParentParentParent.Dash)

local module = {}

function module.new(arg1)
    module.__index = module

    local tbl1 = {
        id = arg1.id,
        phoneNumbers = arg1.phoneNumbers,
        contactName = arg1.contactName
    }

    setmetatable(tbl1, module)

    return tbl1
end

function module.mock(tbl1)
    local mockName = getMockName()
    local var1 = Dash.join({ id = mockName, contactName = mockName, phoneNumbers = { "123456" } }, tbl1)

    return module.new(var1)
end

function module.formatFromDevice(tbl1)
    local firstname = tbl1.firstname or ""
    local lastname = tbl1.lastname or ""
    return module.new(
        {
            id = module.generateId(tbl1),
            contactName = firstname .. " " .. lastname,
            phoneNumbers = tbl1.phonenumber
        }
    )
end

function module.generateId(tbl1)
    return (tbl1.firstname or "") .. (tbl1.lastname or "") .. tostring(tbl1.phonenumber[1])
end

return module
