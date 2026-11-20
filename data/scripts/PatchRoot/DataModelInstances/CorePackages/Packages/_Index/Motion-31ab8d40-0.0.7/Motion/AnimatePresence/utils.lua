-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local React = require(scriptParentParentParent.React)

return {
    getChildKey = function(arg1)
        if arg1 == nil then
            return nil
        end

        if type(arg1) ~= "table" then
            return nil
        end

        if arg1.key == nil then
            if arg1.props and arg1.props.key ~= nil then
                return arg1.props.key
            end

            return nil
        end

        return arg1.key
    end,
    onlyElements = function(arg1)
        local result = {}

        React.Children.forEach(arg1, function(arg2)
            if React.isValidElement(arg2) then
                table.insert(result, arg2)
            end
        end)

        return result
    end,
    useIdFallback = function(): string
        local str1 = tostring(math.random(1000000))
        return if str1 == nil then "id-" .. str1 else str1
    end
}
