-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    resolveDefaultProps = function(arg1, tbl1)
        if not arg1 or typeof(arg1) ~= "table" or not arg1.defaultProps then
            return tbl1
        end

        local var1 = table.clone(tbl1)
        local defaultProps = arg1.defaultProps
        for k, _ in defaultProps do
            if var1[k] == nil then
                var1[k] = defaultProps[k]
            end
        end
        return var1
    end
}
