-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local InputType = require(scriptParentParentParent.Enums.InputType)
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Cryo = require(scriptParentParentParentParent.Cryo)
local _Types = require(scriptParent.ShortcutBar.Types)

local module = {}
local function func1(mouseAndKeyboard) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(arg1, _)
        local icon = arg1.icon
        if typeof(icon) == "string" or typeof(icon) == "table" and icon.Image then
            return
        end

        if typeof(icon) == "EnumItem"
            or #icon > 0 and typeof(icon[1]) == "EnumItem" and mouseAndKeyboard == InputType.MouseAndKeyboard
        then
            return arg1
        end

        if icon[mouseAndKeyboard] then
            return Cryo.Dictionary.join(arg1, { icon = icon[mouseAndKeyboard] })
        end
    end
end

function module.filterItems(arg1, mouseAndKeyboard)
    local var1 = Cryo.List.filter(arg1, function(arg2, _)
        local icon = arg2.icon

        return typeof(icon) == "string" or typeof(icon) == "table" and icon.Image
    end)

    if not mouseAndKeyboard then
        return var1
    end

    assert(mouseAndKeyboard, "Assert inputType not nil at this point to silence type checker")
    return (Cryo.List.join(var1, Cryo.List.filterMap(arg1, (func1(mouseAndKeyboard)))))
end

return module
