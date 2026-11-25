-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserRelationshipModalsParent = script:FindFirstAncestor("UserRelationshipModals").Parent

local React = require(UserRelationshipModalsParent.React)
local Foundation = require(UserRelationshipModalsParent.Foundation)
local RoactRodux = require(UserRelationshipModalsParent.RoactRodux)
local LocalizationProvider = require(UserRelationshipModalsParent.Localization).LocalizationProvider
local Rodux = require(UserRelationshipModalsParent.Rodux)

local mockLocalization = require(script.Parent.mockLocalization)

return function(component, tbl1)
    local store = if tbl1 ~= nil then tbl1.store else Rodux.Store.new(function()
        return {
            UserRelationshipModals = {
                LocalUserId = 456,
                NetworkStatus = {}
            }
        }
    end, {}, { Rodux.thunkMiddleware })

    return React.createElement(LocalizationProvider, { localization = mockLocalization }, {
        Provider = React.createElement(
            Foundation.FoundationProvider,
            {
                colorMode = "Dark",
                preferences = { reducedMotion = true }
            },
            { React.createElement(RoactRodux.StoreProvider, { store = store }, { component = component }) }
        )
    })
end
