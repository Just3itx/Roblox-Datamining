-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Object = require(scriptParentParent.Parent.LuauPolyfill).Object

local invariant = require(scriptParentParent.jsutils.invariant).invariant

local _schema = require(scriptParentParent.type.schema)

local parse = require(scriptParentParent.language.parser).parse

local executeSync = require(scriptParentParent.execution.execute).executeSync

local getIntrospectionQuery = require(script.Parent.getIntrospectionQuery).getIntrospectionQuery

return {
    introspectionFromSchema = function(schema, arg1)
        local var1 = Object.assign(
            {
                specifiedByUrl = true,
                directiveIsRepeatable = true,
                schemaDescription = true,
                inputValueDeprecation = true
            },
            arg1
        )

        local document = parse(getIntrospectionQuery(var1))
        local var3 = executeSync({ schema = schema, document = document })
        invariant(not var3.errors and var3.data)

        return var3.data
    end
}
