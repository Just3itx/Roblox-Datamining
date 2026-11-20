-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local _Types = require(scriptParentParent.util.Types)
local ErrorSourceStrings = require(scriptParentParent.validationSystem.ErrorSourceStrings)

local function checkName(name, name2: string): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    if type(name) == "table" then
        return table.find(name, name2) ~= nil
    end

    return name == name2
end

local function getReadableName(name): string -- Luacid: Inlined by compiler; 2 call sites recovered
    if type(name) == "table" then
        return table.concat(name, " or ")
    end

    return if type(name) == "string" then name else "*"
end

local function validateInstancesFromSchema(arg1, arg2, tbl1, arg3, str1: string?, bool1: boolean?)
    tbl1[arg1] = true
    if arg2._ignoreDescendants then
        assert(
            not arg2._children,
            "if _ignoreDescendants is true, there should be no descendants in the schema as they would be ignored anyway"
        )

        for _, descendant in arg1:GetDescendants() do
            tbl1[descendant] = true
        end

        return
    end

    for _, value in arg2._children or {} do
        local bool2 = false
        for _, child in arg1:GetChildren() do
            if tbl1[child] == nil and child.ClassName == value.ClassName and (value.Name == nil or checkName(value.Name, child.Name)) then
                validateInstancesFromSchema(child, value, tbl1, arg3, str1, bool1)
                bool2 = true
                break
            end
        end

        if bool2 or value._optional then
            continue
        end

        local var1 = str1 or ErrorSourceStrings.Keys.AssetSchemaMissingItem
        local var2 = if bool1 then nil else arg1
        local tbl2 = {
            ParentPath = arg1:GetFullName(),
            ExpectedClass = value.ClassName,
            ExpectedName = getReadableName(value.Name),
            detail = `missing required {value.ClassName}` .. (if value.Name then ` named '{getReadableName(value.Name)}'` else "") .. ` inside '{arg1.Name}'`
        }
        arg3:fail(var1, tbl2, var2)
    end
end

local function validateNoInstancesOutsideSchema(arg1, tbl1, arg2, str1: string?, bool1: boolean?)
    local tbl2 = {}
    for _, descendant in arg1:GetDescendants() do
        if tbl1[descendant] == nil then
            table.insert(tbl2, descendant:GetFullName())
        end
    end

    if not (#tbl2 > 0) then
        return
    end

    local var1 = str1 or ErrorSourceStrings.Keys.AssetSchemaUnexpectedItems
    if bool1 then
        arg1 = nil
    end

    arg2:fail(var1, {
        UnexpectedDescendantPaths = table.concat(tbl2, ", "),
        detail = `unauthorized instances found: {table.concat(tbl2, ", ")}`
    }, arg1)
end

local function validateInstanceTreeAgainstSchema(arg1, arg2, arg3, tbl1)
    local skipRootClassCheck = if tbl1 then tbl1.skipRootClassCheck else nil
    local missingErrorKey = if tbl1 then tbl1.missingErrorKey else nil
    local unauthorizedErrorKey = if tbl1 then tbl1.unauthorizedErrorKey else nil
    local skipInstanceContext = if tbl1 then tbl1.skipInstanceContext else nil
    local tbl2 = {}

    if not skipRootClassCheck then
        if arg2.ClassName ~= arg1.ClassName then
            arg3:fail(
                ErrorSourceStrings.Keys.AssetSchemaWrongRootClass,
                {
                    RootClass = arg1.ClassName,
                    ExpectedClass = arg2.ClassName
                }
            )
            return
        end

        if arg2.Name ~= nil and not checkName(arg2.Name, arg1.Name) then
            arg3:fail(ErrorSourceStrings.Keys.AssetSchemaWrongRootName, { RootName = arg1.Name, ExpectedName = arg2.Name })

            return
        end
    end

    validateInstancesFromSchema(arg1, arg2, tbl2, arg3, missingErrorKey, skipInstanceContext)
    validateNoInstancesOutsideSchema(arg1, tbl2, arg3, unauthorizedErrorKey, skipInstanceContext)
end

return validateInstanceTreeAgainstSchema
