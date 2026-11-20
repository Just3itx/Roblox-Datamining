-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Object = require(scriptParentParentParent.LuauPolyfill).Object

local _directiveLocation = require(script.Parent.Parent.language.directiveLocation)

function getIntrospectionQuery(tbl1): string
    local var1 = Object.assign({
        descriptions = true,
        specifiedByUrl = false,
        directiveIsRepeatable = false,
        schemaDescription = false,
        inputValueDeprecation = false
    }, tbl1)

    local str1 = if var1.descriptions then "description" else ""
    local str2 = if var1.specifiedByUrl then "specifiedByUrl" else ""
    local str3 = if var1.directiveIsRepeatable then "isRepeatable" else ""

    local function inputDeprecation(str4: string): string -- Luacid: Inlined by compiler; 5 call sites recovered
        return if var1.inputValueDeprecation then str4 else ""
    end

    return ("\n    query IntrospectionQuery {\n      __schema {\n        %s\n        queryType { name }\n        mutationType { name }\n        subscriptionType { name }\n        types {\n          ...FullType\n        }\n        directives {\n          name\n          %s\n          %s\n          locations\n          args%s {\n            ...InputValue\n          }\n        }\n      }\n    }\n\n    fragment FullType on __Type {\n      kind\n      name\n      %s\n      %s\n      fields(includeDeprecated: true) {\n        name\n        %s\n        args%s {\n          ...InputValue\n        }\n        type {\n          ...TypeRef\n        }\n        isDeprecated\n        deprecationReason\n      }\n      inputFields%s {\n        ...InputValue\n      }\n      interfaces {\n        ...TypeRef\n      }\n      enumValues(includeDeprecated: true) {\n        name\n        %s\n        isDeprecated\n        deprecationReason\n      }\n      possibleTypes {\n        ...TypeRef\n      }\n    }\n\n    fragment InputValue on __InputValue {\n      name\n      %s\n      type { ...TypeRef }\n      defaultValue\n      %s\n      %s\n    }\n\n    fragment TypeRef on __Type {\n      kind\n      name\n      ofType {\n        kind\n        name\n        ofType {\n          kind\n          name\n          ofType {\n            kind\n            name\n            ofType {\n              kind\n              name\n              ofType {\n                kind\n                name\n                ofType {\n                  kind\n                  name\n                  ofType {\n                    kind\n                    name\n                  }\n                }\n              }\n            }\n          }\n        }\n      }\n    }\n  "):format(
        if var1.schemaDescription then str1 else "",
        str1,
        str3,
        inputDeprecation("(includeDeprecated: true)"),
        str1,
        str2,
        str1,
        inputDeprecation("(includeDeprecated: true)"),
        inputDeprecation("(includeDeprecated: true)"),
        str1,
        str1,
        inputDeprecation("isDeprecated"),
        (inputDeprecation("deprecationReason"))
    )
end

return {
    getIntrospectionQuery = getIntrospectionQuery
}
