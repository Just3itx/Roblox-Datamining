-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local Dash = require(scriptParent.Dash)
local RoduxNetworking = require(scriptParent.LuaSocialLibrariesDeps).RoduxNetworking
local NetworkingContacts = require(scriptParent.LuaSocialLibrariesDeps).NetworkingContacts

local ContactsReducer = require(script.Reducers.ContactsReducer)
local Selectors = require(script.Selectors)

local module = {
    ["jest.config"] = script["jest.config"]
}

function module.config(arg1)
    local var1 = Dash.join(arg1, { networkingContacts = NetworkingContacts.config({ roduxNetworking = RoduxNetworking.mock() }) })

    return {
        installReducer = function()
            return ContactsReducer(var1)
        end,
        Selectors = Selectors(var1),
        Models = require(script.Models),
        Actions = require(script.Actions)
    }
end

return module
