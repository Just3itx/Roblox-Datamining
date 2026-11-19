-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local t = require(CorePackages.Packages.t)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local BubbleChatBillboards = require(script.Parent.BubbleChatBillboards)

local var1 = Roact.Component:extend("App")

var1.validateProps = t.strictInterface({ store = t.table })

function var1.render(arg1)
    return Roact.createElement(
        RoactRodux.StoreProvider,
        {
            store = arg1.props.store
        },
        {
            BubbleChatBillboards = Roact.createElement(BubbleChatBillboards)
        }
    )
end
return var1
