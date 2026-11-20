-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function checkName(name, name2) -- Luacid: Inlined by compiler; 2 call sites recovered
    if type(name) == "table" then
        for _, value in pairs(name) do
            if value == name2 then
                return true
            end
        end
    elseif type(name) == "string" then
        return name == name2
    end
    return false
end

local function getReadableName(name): string -- Luacid: Inlined by compiler; 2 call sites recovered
    if type(name) == "table" then
        return table.concat(name, " or ")
    end

    return if type(name) == "string" then name else "*"
end

local function validateWithSchemaHelper(arg1, arg2, arg3)
    if arg2.ClassName ~= arg1.ClassName or arg1.Name ~= nil and not checkName(arg1.Name, arg2.Name) then
        return { success = false }
    end

    if arg1._ignoreDescendants then
        assert(
            not arg1._children,
            "if _ignoreDescendants is true, there should be no descendants in the schema as they would be ignored anyway"
        )

        for _, descendant in arg2:GetDescendants() do
            arg3[descendant] = true
        end

        arg3[arg2] = true
        return { success = true }
    end

    if arg1._children then
        for _, _child in pairs(arg1._children) do
            local bool1 = false
            local var1 = nil
            for _, child in pairs(arg2:GetChildren()) do
                if arg3[child] then
                    continue
                end

                local var2 = validateWithSchemaHelper(_child, child, arg3)
                if var2.success then
                    bool1 = true
                    break
                end

                if var2.message then
                    var1 = var2
                end
            end

            if not (bool1 or _child._optional) then
                return var1
                    or {
                        success = false,
                        message = "Could not find a " .. _child.ClassName .. " called " .. getReadableName(_child.Name) .. " inside " .. arg2.Name
                    }
            end
        end
    end

    arg3[arg2] = true

    return { success = true }
end

local function validateWithSchema(arg1, arg2, _)
    if arg2.ClassName ~= arg1.ClassName or arg1.Name ~= nil and not checkName(arg1.Name, arg2.Name) then
        return {
            success = false,
            message = "Expected top-level instance to be a " .. arg1.ClassName .. " named " .. getReadableName(arg1.Name)
        }
    end

    local tbl1 = {}
    if not validateWithSchemaHelper(arg1, arg2, tbl1).success then
        return { success = false, message = "" }
    end

    local tbl2 = {}
    for _, descendant in pairs(arg2:GetDescendants()) do
        if tbl1[descendant] == nil then
            tbl2[#tbl2 + 1] = descendant:GetFullName()
        end
    end

    return if #tbl2 > 0 then { success = false, message = "" } else { success = true }
end

return validateWithSchema
