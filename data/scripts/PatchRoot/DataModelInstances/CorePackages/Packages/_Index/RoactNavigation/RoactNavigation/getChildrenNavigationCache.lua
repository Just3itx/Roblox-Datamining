-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:11:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1)
    if not arg1 then
        return {}
    end

    if not arg1._childrenNavigation then
        arg1._childrenNavigation = {}
    end

    local _childrenNavigation = arg1._childrenNavigation

    local tbl1 = {}
    for _, value in arg1.state.routes or {} do
        tbl1[value.key] = true
    end

    if not arg1.state.isTransitioning then
        for value, _ in _childrenNavigation do
            if not tbl1[value] then
                _childrenNavigation[value] = nil
            end
        end
    end

    return arg1._childrenNavigation
end
