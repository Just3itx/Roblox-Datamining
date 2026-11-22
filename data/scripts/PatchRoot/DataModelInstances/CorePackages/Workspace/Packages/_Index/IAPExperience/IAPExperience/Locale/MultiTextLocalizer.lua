-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Roact = require(scriptParentParentParent.Roact)
local t = require(scriptParentParentParent.t)

local LocaleRoactContext = require(script.Parent.LocaleRoactContext)

local var1 = t.strictInterface({ keys = t.table, render = t.callback })

local var2 = t.strictInterface({ key = t.string, params = t.optional(t.table) })

local function MultiTextLocalizer(arg1)
    assert(var1(arg1))
    for _, key in pairs(arg1.keys) do
        assert(var2(key))
    end

    local render = arg1.render

    return Roact.createElement(LocaleRoactContext.Consumer, {
        render = function(arg2)
            local tbl1 = ({})
            for k, key in pairs(arg1.keys) do
                tbl1[k] = arg2:Format(key.key, key.params)
            end
            return render(tbl1)
        end
    })
end

return MultiTextLocalizer
