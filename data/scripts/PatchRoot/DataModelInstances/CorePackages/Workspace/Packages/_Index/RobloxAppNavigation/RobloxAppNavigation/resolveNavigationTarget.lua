-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function resolveNavigationTarget(arg1)
    if type(arg1) ~= "table" then
        return nil
    elseif type(arg1.action) == "table" and arg1.action.routeName then
        return arg1.action.routeName
    elseif arg1.routeName then
        return arg1.routeName
    elseif type(arg1.actions) == "table" and arg1.index then
        return resolveNavigationTarget(arg1.actions[arg1.index])
    end
    return nil
end

return resolveNavigationTarget
